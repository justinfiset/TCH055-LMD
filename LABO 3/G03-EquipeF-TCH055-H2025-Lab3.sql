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
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Question 6
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Question 7
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE P_produire_facture(
    p_id_livraison IN NUMBER,
    p_remise IN NUMBER DEFAULT 0
) IS
    v_id_facture NUMBER;
    v_id_client NUMBER;
    v_nom_client VARCHAR2(100);
    v_prenom_client VARCHAR2(100);
    v_telephone VARCHAR2(20);
    v_adresse VARCHAR2(255);
    v_date_livraison DATE;
    v_date_limite DATE;
    v_total NUMBER := 0;
    v_total_apres_remise NUMBER;
    v_total_taxes NUMBER;
    v_montant_total NUMBER;
    
    -- Curseur pour récupérer les produits livrés
    CURSOR cur_produits IS
        SELECT p.id_produit, p.nom, p.marque, p.prix_unitaire, lc.quantite
        FROM Livraison_Commande_Produit lc
        JOIN Produit p ON lc.id_produit = p.id_produit
        WHERE lc.id_livraison = p_id_livraison;
    
BEGIN
    -- Vérifier si la livraison existe
    SELECT c.id_client, c.nom, c.prenom, c.telephone, c.adresse, l.date_livraison
    INTO v_id_client, v_nom_client, v_prenom_client, v_telephone, v_adresse, v_date_livraison
    FROM Livraison l
    JOIN Commande co ON l.id_commande = co.id_commande
    JOIN Client c ON co.id_client = c.id_client
    WHERE l.id_livraison = p_id_livraison;

    -- Calcul de la date limite de paiement (30 jours après livraison)
    v_date_limite := v_date_livraison + 30;

    -- Calculer le total avant remise
    FOR r IN cur_produits LOOP
        v_total := v_total + (r.prix_unitaire * r.quantite);
    END LOOP;

    -- Appliquer la remise
    v_total_apres_remise := v_total * (1 - p_remise / 100);

    -- Calculer les taxes et le montant total
    v_total_taxes := v_total_apres_remise * 0.15;
    v_montant_total := v_total_apres_remise + v_total_taxes;

    -- Générer l'identifiant de la facture via une séquence
    SELECT SEQ_FACTURE.NEXTVAL INTO v_id_facture FROM DUAL;

    -- Insérer la facture dans la base de données
    INSERT INTO Facture (id_facture, id_livraison, date_facturation, date_limite, montant_total, montant_remise, montant_taxes)
    VALUES (v_id_facture, p_id_livraison, SYSDATE, v_date_limite, v_total, v_total_apres_remise, v_total_taxes);

    -- Affichage de la facture
    DBMS_OUTPUT.PUT_LINE('--- FACTURE ---');
    DBMS_OUTPUT.PUT_LINE('Client : ' || v_nom_client || ' ' || v_prenom_client);
    DBMS_OUTPUT.PUT_LINE('Téléphone : ' || v_telephone);
    DBMS_OUTPUT.PUT_LINE('Adresse : ' || v_adresse);
    DBMS_OUTPUT.PUT_LINE('Livraison # ' || p_id_livraison || ' - Date : ' || v_date_livraison);
    DBMS_OUTPUT.PUT_LINE('Date limite de paiement : ' || v_date_limite);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    FOR r IN cur_produits LOOP
        DBMS_OUTPUT.PUT_LINE(r.nom || ' | ' || r.marque || ' | ' || r.prix_unitaire || ' | ' || r.quantite || ' | ' || (r.prix_unitaire * r.quantite));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total avant taxes : ' || v_total);
    DBMS_OUTPUT.PUT_LINE('Remise : ' || p_remise || '%');
    DBMS_OUTPUT.PUT_LINE('Total après remise : ' || v_total_apres_remise);
    DBMS_OUTPUT.PUT_LINE('Taxes (15%) : ' || v_total_taxes);
    DBMS_OUTPUT.PUT_LINE('Montant total à payer : ' || v_montant_total);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Livraison introuvable.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END P_produire_facture;
/


-- -----------------------------------------------------------------------------
-- Question 8
-- -----------------------------------------------------------------------------

