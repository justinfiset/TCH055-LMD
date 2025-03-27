-- ===================================================================
-- Auteurs : Justin Fiset, Aimé Melançon, Nikola Sunjka, Justin Lavoie-Ladouceur

-- Description : 
--
-- ====================================================================

-- -----------------------------------------------------------------------------
-- Question 1  :
--Implémenter un déclencheur qui met à jour la quantité en stock d’un produit qui sera livré. Il faut que 
--votre déclencheur vérifie en premier, si la quantité en stock est suffisante. Si ce n’est pas le cas, le 
--déclencheur lève une exception nommée E_STOCK_INSUFFISANT. 
--Indication : lorsqu’un un produit est destiné à être livré, il y aura une insertion d’un tuple dans la table 
--Livraison_Commande_Produit.  
--Note : Pour simplification, on ne traite pas les modifications dans la quantité à livrer, car dans ce cas, 
--la mise à jour de la quantité en stock est différente.
-------------------------------------------------------------------------------------
--
--DECLENCHEUR: TRG_qte_stock
--TABLE: Commande_Produit
--TYPE: En même temps qu'une mise à jours
--DESCRIPTION:
-- Vérifie si le stock du produit n'est pas inférieur à zéro. Si la quantité du stock n'est pas 
--suffisante le déclencheur lève une exception nommée E_STOCK_INSUFFISANT. Si la quantité du stock 
--est suffisante il va avoir une insertion d'un tuple dans la table Livraison_Commande_Produit.
--
--
--------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_qte_stock 
AFTER UPDATE ON commande_produit
   FOR EACH ROW
   --Déclaration des variables
DECLARE
   qte_stock number(10);
   E_STOCK_INSUFFISANT EXCEPTION;
BEGIN
    --Permet la sélection pour la vérification du stock
   SELECT produit.quantite_stock
     INTO qte_stock
     FROM commande_produit
     JOIN produit ON produit.ref_produit = no_produit
     WHERE ref_produit = :NEW.no_produit;
    --Si la quantité en stock est inférieur à zéro, on lève l'exception E_STOCK_INSUFISANT, sinon on fait rien.
   IF qte_stock < 0 THEN
      RAISE E_STOCK_INSUFFISANT;
      ROLLBACK;
   ELSE
    --Permet la sélection de la quantité de stock qui va être livré
      SELECT produit.quantite_stock
        INTO qte_stock
        FROM commande_produit
        JOIN produit ON produit.ref_produit = no_produit
        WHERE ref_produit = :OLD.no_produit;

             --On insère dans Livraison_Commande_Produit la quantite qui va être livrée.
      INSERT INTO livraison_commande_produit ( quantite_livree ) 
      VALUES ( qte_stock );
   END IF;

EXCEPTION
    --Si l'exception est lancé, elle va afficher le code d'erreur personnalisé avec ça description.
   WHEN E_STOCK_INSUFFISANT THEN
      RAISE_APPLICATION_ERROR( -2001,'Stock insuffisant pour ce produit.');
END;
/

-- -----------------------------------------------------------------------------
-- Question 2
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_auto_approvisionnement
AFTER UPDATE ON Produit
FOR EACH ROW
WHEN (NEW.quantite_stock < NEW.quantite_seuil)
DECLARE
    v_count NUMBER;
    v_fournisseur_id NUMBER;
BEGIN
    -- verifier si une commande en cours existe deja
    SELECT COUNT(*) INTO v_count
    FROM Approvisionnement
    WHERE no_produit = :NEW.ref_produit 
    AND statut = 'ENCOURS';

    -- si aucune commande en cours, creer une nouvelle
    IF v_count = 0 THEN
        -- Sélectionner le fournisseur prioritaire
        SELECT code_fournisseur INTO v_fournisseur_id
        FROM Produit_Fournisseur
        WHERE no_produit = :NEW.ref_produit
        AND ROWNUM = 1
        ORDER BY code_fournisseur ASC;

        -- inserer la nouvelle commande
        INSERT INTO Approvisionnement (no_produit, code_fournisseur, quantite_approvis, date_cmd_approvis, statut)
        VALUES (:NEW.ref_produit, v_fournisseur_id, ROUND(:NEW.quantite_seuil * 1.1), SYSDATE, 'ENCOURS');
    END IF;
END;
/
-- -----------------------------------------------------------------------------
-- Question 3-A
-- -----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_stat_vente
AFTER INSERT
ON Livraison_Commande_Produit

FOR EACH ROW
DECLARE
    nb_stat NUMBER(10);
    date_livraison DATE := SYSDATE;
BEGIN
    -- Vérification si la statistique existe
    SELECT COUNT(*)
    INTO nb_stat
    FROM Statistique_Vente 
    WHERE ref_produit = :NEW.no_produit;
    
IF nb_stat > 0 THEN
    UPDATE Statistique_Vente
    SET quantite_vendue = quantite_vendue + :NEW.quantite_livree
    WHERE Statistique_Vente.ref_produit = :NEW.no_produit;
ELSE
    INSERT INTO Statistique_Vente(ref_produit, code_mois, quantite_vendue)
    VALUES (:NEW.no_produit, extract(month FROM date_livraison), :NEW.quantite_livree);
END IF;

END;
/

-- -----------------------------------------------------------------------------
-- Question 3-B
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE p_test_creation_livraison IS
    commande_produits Commande%ROWTYPE;
BEGIN
    -- Récupérer la commande no 37
    SELECT *
    INTO commande_produits
    FROM Commande
    WHERE no_commande = 37;

    -- Créer la livraison
    INSERT INTO Livraison(no_livraison, date_livraison)
    VALUES (50037, commande_produits.date_commande);

    -- Création des livraison de produit individuelles
    INSERT INTO Livraison_Commande_Produit(no_livraison, no_commande, no_produit, quantite_livree)
    VALUES (50037, commande_produits.no_commande, 'DD2001', 2);
    
    INSERT INTO Livraison_Commande_Produit(no_livraison, no_commande, no_produit, quantite_livree)
    VALUES (50037, commande_produits.no_commande, 'LT2011', 1);
    
    INSERT INTO Livraison_Commande_Produit(no_livraison, no_commande, no_produit, quantite_livree)
    VALUES (50037, commande_produits.no_commande, 'PC2000', 4);
    
    INSERT INTO Livraison_Commande_Produit(no_livraison, no_commande, no_produit, quantite_livree)
    VALUES (50037, commande_produits.no_commande, 'DD2002', 2);
    
    INSERT INTO Livraison_Commande_Produit(no_livraison, no_commande, no_produit, quantite_livree)
    VALUES (50037, commande_produits.no_commande, 'SC2001', 3);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Quantité insuffisante pour la livraison!');
END;
/

-- -----------------------------------------------------------------------------
-- Question 4
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION f_quantite_deja_livree
(ref_produit Livraison_Commande_Produit.no_produit%TYPE,
 ref_commande Livraison_Commande_Produit.no_commande%TYPE)
RETURN Livraison_Commande_Produit.quantite_livree%TYPE 
IS
    quant_liv Livraison_Commande_Produit.quantite_livree%TYPE;
BEGIN
    SELECT l.quantite_livree
    INTO quant_liv
    FROM Livraison_Commande_Produit l
    WHERE l.no_produit=ref_produit
        AND l.no_commande=ref_commande;
    
    RETURN quant_liv;
        
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        quant_liv := -1;
        RETURN quant_liv;
        
END;
/ 

-- -----------------------------------------------------------------------------
-- Question 5   
--Implémenter une procédure qui va afficher, le nom de chaque client ayant faite une commande, le 
--numéro de commande des produits, la référence des produits commandées, la quantité commandée 
--pour chaque produit de la commande, et la quantité livrée. Utiliser la fonction faite à la question 4. 
-- -----------------------------------------------------------------------------
--===========================================
--Procédure:  p_afficher_client
--Description: 
--Permet d'afficher le nom de chaque client ayant faite une commande, le numéro de commande des produits,
--la référence des produits commandées, la quantité commande pour chaque produit de la commande, et la quantité
--livrée.
--IN (<TYPE>): 
--OUT (<TYPE>): Paramètrede type OUT (décrire!)
--===========================================
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_afficher_client
    (qteLivre NUMBER)
IS
DECLARE 
    CURSOR cur_qte_livre(qte_livraison NUMBER) IS 
        SELECT Client.nom, Client.prenom,Commande.no_commande, Produit.ref_produit, Commande_Produit.quantite_cmd, 
        f_quantite_deja_livree(Produit.ref_produit, Commande.no_commande) AS qte_livre
        FROM Commande
        JOIN Client ON Commande.no_client = Client.no_client
        JOIN Commande_Produit ON Commande.no_commande = Commande_Produit.no_commande
        JOIN Produit ON Commande_Produit.no_produit = Produit.ref_produit
        JOIN Livraison_Commande_Produit ON Commande_Produit.no_commande = Livraison_Commande_Produit.no_commande
        WHERE f_quantite_deja_livree(Produit.ref_produit, Commande.no_commande)>0;
BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE()

        EXIT WHEN cur_qte_livre%NOTFOUND;
    END LOOP;    

END;
/

SELECT Client.nom, Client.prenom,Commande.no_commande, Produit.ref_produit, Commande_Produit.quantite_cmd, 
f_quantite_deja_livree(Produit.ref_produit, Commande.no_commande) AS qte_livre
FROM Commande
JOIN Client ON Commande.no_client = Client.no_client
JOIN Commande_Produit ON Commande.no_commande = Commande_Produit.no_commande
JOIN Produit ON Commande_Produit.no_produit = Produit.ref_produit
JOIN Livraison_Commande_Produit ON Commande_Produit.no_commande = Livraison_Commande_Produit.no_commande
WHERE f_quantite_deja_livree(Produit.ref_produit, Commande.no_commande)>0;

-- -----------------------------------------------------------------------------
-- Question 6
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Question 7
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Question 8
-- -----------------------------------------------------------------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE p_affiche_facture
    (id     IN     NUMBER) 
IS
    mt_total Facture.montant%type;
    mt_paiements Paiement.montant%type;
    mt_restant Paiement.montant%type;
    date_limite Facture.date_facture%type;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Pour la facture ' || TO_CHAR(id) || ' :');
    SELECT montant, date_facture 
    INTO mt_total, date_limite 
    FROM Facture
    WHERE id_facture = id;
    DBMS_OUTPUT.PUT_LINE(' -Montant à payer   :' || TO_CHAR(mt_total) || ' $');
    SELECT SUM(montant)
    INTO mt_paiements
    FROM Paiement
    WHERE id_facture=id;
    DBMS_OUTPUT.PUT_LINE(' -Montant déjà payé :' || TO_CHAR(mt_paiements) || ' $');
    mt_restant := mt_total-mt_paiements;
    DBMS_OUTPUT.PUT_LINE(' -Montant restant à payer  :' || TO_CHAR(mt_restant) || ' $');
    
    IF mt_restant <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Paiement est complété');
    ELSIF date_limite > SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE('Paiement non complété : Date limite de paiement: ' || TO_CHAR(date_limite, 'DD-MON-YYYY'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Paiement non complété - Solde en souffrance : Date limite de paiement: ' || TO_CHAR(date_limite, 'DD-MON-YYYY'));
    END IF;
END;
/

EXECUTE p_affiche_facture(60023);