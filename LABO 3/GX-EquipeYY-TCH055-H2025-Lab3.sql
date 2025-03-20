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


-- -----------------------------------------------------------------------------
-- Question 3-A
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Question 3-B
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Question 4
-- -----------------------------------------------------------------------------


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

