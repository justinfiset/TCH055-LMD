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
--Création du TRIGGER qui permet de détecter si le stock est inférieur à zéro. Si oui,
--il renvoie une exception , sinon il fait rien.
--------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_qte_stock
        AFTER UPDATE ON produit
        FOR EACH ROW 
        BEGIN     
            --Si la quantité en stock est inférieur à zéro, on lève l'exception E_STOCK_INSUFISANT, sinon on fait rien--
             IF produit.quantite_sock<0 THEN
                RAISE E_STOCK_INSUFFISANT;
                ROLLBACK; 
             END IF;
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
CREATE OR REPLACE TRIGGER TRG_stat_vente
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


-- -----------------------------------------------------------------------------
-- Question 8
-- -----------------------------------------------------------------------------

