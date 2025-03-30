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
            dbms_output.put_line('Quantité insuffisante pour la livraison!');
END;
/

EXECUTE p_test_creation_livraison;

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
-- Affiche les informations demandés en utilisant un curseur.
--===========================================
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_afficher_client
IS
CURSOR cur_qte_livre IS     
        SELECT Client.nom, Client.prenom,Commande.no_commande, Produit.ref_produit, Commande_Produit.quantite_cmd, 
        f_quantite_deja_livree(Produit.ref_produit, Commande.no_commande) AS qte_livre
        FROM Commande
        JOIN Client ON Commande.no_client = Client.no_client
        JOIN Commande_Produit ON Commande.no_commande = Commande_Produit.no_commande
        JOIN Produit ON Commande_Produit.no_produit = Produit.ref_produit
        JOIN Livraison_Commande_Produit ON Commande_Produit.no_commande = Livraison_Commande_Produit.no_commande
        WHERE f_quantite_deja_livree(Produit.ref_produit, Commande.no_commande)>0;

        nom_client       Client.nom%TYPE;
        prenom_client    Client.prenom%TYPE;
        no_commande      Commande.no_commande%TYPE;
        ref_produit      Produit.ref_produit%TYPE;
        qte_cmd          Commande_Produit.quantite_cmd%TYPE;
        qte_livre        NUMBER;

BEGIN
   OPEN cur_qte_livre;
    LOOP 
        
        FETCH cur_qte_livre INTO nom_client, prenom_client, no_commande, ref_produit, qte_cmd, qte_livre;
        DBMS_OUTPUT.PUT_LINE('Nom :'||nom_client ||'Prénom :'||prenom_client ||'No Commande :'|| no_commande 
        ||'Référence produit :  '|| ref_produit ||'Quantité commandé au totale : '|| qte_cmd ||'Quantité livrée : '|| qte_livre);

        EXIT WHEN cur_qte_livre%NOTFOUND;
    END LOOP;   
    CLOSE cur_qte_livre;
END P_AFFICHER_CLIENT;
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
CREATE OR REPLACE PROCEDURE p_preparer_livraison (
    num_livraison NUMBER) IS 
    livraison_count NUMBER;
    livraison_client Livraison%ROWTYPE;
    client_livraison Client%ROWTYPE;
    commande_client Commande%ROWTYPE;
    adresse_client Adresse%ROWTYPE;
    num_client NUMBER;

    -- Curseur pour récupérer les produits de la livraison
    CURSOR cur_produits_livraison IS
        SELECT *
        FROM Livraison_Commande_Produit
        WHERE no_livraison = num_livraison;
    liv_com_produit Livraison_Commande_Produit%ROWTYPE;
    produits_livraison Produit%ROWTYPE;
    date_commande_liv DATE;
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    -- Récupération du nombre de livraison avec ce numéro de livraison (0 ou 1)
    SELECT COUNT(*) 
    INTO livraison_count
    FROM Livraison
    WHERE Livraison.no_livraison = num_livraison;

    IF livraison_count > 0 THEN -- Si la livraison existe bien (donc que le compte n'est pas 0)
        -- On récupère la livraison avec ce numéro
        SELECT *
        INTO livraison_client
        FROM Livraison
        WHERE Livraison.no_livraison = num_livraison;

        -- On récupère le no du client associé à la livraison
        SELECT Commande.no_client
        INTO num_client
        FROM Commande
        INNER JOIN Livraison_Commande_Produit ON Livraison_Commande_Produit.no_commande = Commande.no_commande
        WHERE livraison_commande_produit.no_livraison = num_livraison
        AND ROWNUM = 1;

        -- Récuperation du client à l'aide du no de client récupéré plus haut
        SELECT *
        INTO client_livraison
        FROM Client
        WHERE Client.no_client = num_client;

        -- Récupération de l'adresse associé au client de la livraison
        SELECT *
        INTO adresse_client
        FROM Adresse
        WHERE id_adresse = client_livraison.id_adresse;

        -- Affichage de l'entête du bordereau de livraison
        dbms_output.put_line(RPAD('No Client', 10) || ': ' || client_livraison.no_client);
        dbms_output.put_line(RPAD('Nom', 10) || ': ' || client_livraison.nom);
        dbms_output.put_line(RPAD('Prénom', 10) || ': ' || client_livraison.prenom);
        dbms_output.put_line(RPAD('Téléphone', 10) || ': ' || client_livraison.telephone);
        dbms_output.put_line(RPAD('Adresse', 10) || ': ' || adresse_client.no_civique || ', ' 
            || adresse_client.nom_rue || ', ' || adresse_client.ville || ', ' 
            || adresse_client.code_postal || '. ' || adresse_client.pays);
        dbms_output.put_line(RPAD('No Livraison', 15) || ': ' || num_livraison);
        dbms_output.put_line(RPAD('Date Livraison', 15) || ': ' || TO_CHAR(livraison_client.date_livraison));
        
        -- Affichage du contenue de la livraion
        dbms_output.put_line(RPAD('-', 87, '-'));
        dbms_output.put_line(RPAD('No Produit', 12) || RPAD('Nom Produit', 22) ||
                             RPAD('Marque', 22) || RPAD('Q. Livrée', 12) || 
                             RPAD('No CMD.', 9) || RPAD('Date CMD.', 12));
        dbms_output.put_line(RPAD('-', 87, '-'));
        
        -- On affiche les produits de la livraison
        OPEN cur_produits_livraison; -- Ouverture de pointeur

        LOOP
            FETCH cur_produits_livraison INTO liv_com_produit; -- On récupère un produit de la livraison
            EXIT WHEN cur_produits_livraison%NOTFOUND; -- On sort de la boucle si on a tout lu les produits dans la livraison

            -- On récupère le produuit qui correspond au curseur en cours
            SELECT *
            INTO produits_livraison
            FROM Produit
            WHERE Produit.ref_produit = liv_com_produit.no_produit;
            
            -- On récupère la date de la commande associée à la livraison
            SELECT Commande.date_commande
            INTO date_commande_liv
            FROM Commande
            WHERE Commande.no_commande = liv_com_produit.no_commande; 

            -- Affichage des détails du produit
            dbms_output.put_line(RPAD(liv_com_produit.no_produit, 12) || RPAD(produits_livraison.nom_produit, 22) ||
                                 RPAD(produits_livraison.marque, 22) || RPAD(liv_com_produit.quantite_livree, 12) ||
                                 RPAD(liv_com_produit.no_commande, 9) || RPAD(TO_CHAR(date_commande_liv), 12));
        END LOOP;
        CLOSE cur_produits_livraison; -- Fermeture du pointeur
        
        dbms_output.put_line(RPAD('-', 87, '-'));
        dbms_output.put_line(RPAD('-', 87, '-'));
    ELSE -- Gestion du cas où la livraison n'existe pas, on affiche une erreur
        dbms_output.put_line('Erreur: la livraison ' || num_livraison || ' n''existe pas.');
    END IF;
END;
/

EXECUTE p_preparer_livraison(50037);
EXECUTE p_preparer_livraison(99999);

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

