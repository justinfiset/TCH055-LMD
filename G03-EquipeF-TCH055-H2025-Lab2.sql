-- ===================================================================
-- Authors : 
-- 
-- Description : 
--
-- ====================================================================

-- ************************************BLOC 1***********************************
-- -----------------------------------------------------------------------------
-- Requête 1.1 : Listez les noms des produits disponibles pour la vente. 
-- -----------------------------------------------------------------------------
SELECT nom_produit
FROM Produit;
-- -----------------------------------------------------------------------------
-- Requête 1.2 : Lister les produits (nom et prix unitaire) des produits
-- qui sont en promotion
-- -----------------------------------------------------------------------------
SELECT nom_produit, prix_unitaire,
FROM Produit
WHERE id_promotion IS NOT NULL;
-- -----------------------------------------------------------------------------
-- Requête 1.3 : Lister les noms de toutes les marques vendues par l’entreprise
-- -----------------------------------------------------------------------------
SELECT UNIQUE marque
FROM Produit;
-- -----------------------------------------------------------------------------
-- Requête 1.4 : Retrouvez le ou les clients (numéro du client, nom de famille
-- et prénom) dont le nom de famille est composé d’au moins 3 lettres, 
-- commençant par la lettre « k » et se terminant par la lettre « m ».
-- NOTE : La requête doit retrouver les noms de famille qu’ils soient en 
-- minuscules et en majuscules.
-- -----------------------------------------------------------------------------
SELECT no_client, nom, prenom
FROM Client
WHERE LOWER(nom) LIKE 'k_%m';
-- -----------------------------------------------------------------------------
-- Requête 1.5 : Lister les produits (nom, prix, quantité en stock, quantité 
-- seuil, statut) dont la quantité en stock est égale à la quantité seuil.
-- -----------------------------------------------------------------------------
SELECT nom_produit, prix_unitaire, quantite_stock, quantite_seuil, statut_produit
FROM Produit
WHERE quantite_stock = quantite_seuil;
-- ************************************BLOC 2***********************************
-- -----------------------------------------------------------------------------
-- Requête 2.1 :
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Requête 2.2 :
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Requête 2.3 :
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Requête 2.4 :
-- -----------------------------------------------------------------------------


-- ************************************BLOC 3***********************************
-- -----------------------------------------------------------------------------
-- Requête 3.1 :
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Requête 3.2 :
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Requête 3.3:
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- REQUËTE 3.4 
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Requête 3.5 :
-- -----------------------------------------------------------------------------


-- ************************************BLOC 4***********************************
-- -----------------------------------------------------------------------------
-- Requête 4.1 : Listez les informations des produits (le nom, la marque et le statut du produit) n’ayant jamais
-- été commandés. Triez le résultat par nom de produit alphabétique.
-- -----------------------------------------------------------------------------
SELECT nom_produit,  marque, statut_produit
FROM Produit
WHERE ref_produit IN (
                        SELECT ref_produit
                        FROM Produit
                        MINUS
                        SELECT no_produit as ref_produit
                        FROM Commande_Produit
                    )
ORDER BY nom_produit;
-- -----------------------------------------------------------------------------
-- Requête 4.2 : Listez la quantité (totale) commandée de chaque produit. Afficher le numéro de référence du
-- produit, la marque, le nombre de fois que le produit est commandé et la quantité totale
-- commandée. Trier le résultat par ordre croissant du numéro de référence du produit.
-- -----------------------------------------------------------------------------
SELECT no_produit, marque, nombre_commande, quantite_cmd
FROM (
      SELECT no_produit, COUNT(no_produit) as nombre_commande, SUM(quantite_cmd) as quantite_cmd
      FROM Commande_Produit
      GROUP BY no_produit
     )
INNER JOIN Produit ON no_produit = Produit.ref_produit
ORDER BY no_produit;
-- -----------------------------------------------------------------------------
-- Requête 4.3 : Calculez la recette en espèces du mois de novembre : implémenter une requête qui
-- détermine le total des paiements en espèces (CASH) pour le mois de novembre
-- -----------------------------------------------------------------------------
SELECT SUM(MONTANT) as recette_mois
FROM Paiement
WHERE type_paiement = 'CASH' AND extract(month from date_paiement) = 11;
-- -----------------------------------------------------------------------------
-- Requête 4.4 :
-- -----------------------------------------------------------------------------
-- a) Faites une requête pour afficher le nombre de produits (nombre d’items et non la quantité)
-- pour chaque commande, trier le résultat par ordre décroissant du nombre de produits.
-- Pour cette requête, affichez le numéro de la commande et le nombre produits
SELECT no_commande, SUM(quantite_cmd) as total_produit
FROM Commande_Produit
GROUP BY no_commande
ORDER BY total_produit DESC;
-- -----------------------------------------------------------------------------
-- b) Pour faire suite à la requête a), faire une requête pour afficher les commandes
-- constituées de plus d’un produit. Pour cette requête, afficher le numéro de la commande
-- et le nombre de produits.
SELECT no_commande, COUNT(*) as nb_produit
FROM Commande_Produit
GROUP BY no_commande
HAVING COUNT(*) > 0;
-- ************************************BLOC 5***********************************
-- -----------------------------------------------------------------------------
-- Requête 5.1 :
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Requête 5.2 :
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Requête 5.3 : 
-- -----------------------------------------------------------------------------


-- -----------------------------------------------------------------------------
-- Requête 5.4 : 
-- -----------------------------------------------------------------------------



-- ************************************BLOC 6***********************************
-- -----------------------------------------------------------------------------
-- Requête 6.1 :
-- -----------------------------------------------------------------------------
-- a)	


-- -----------------------------------------------------------------------------
-- b)	



-- -----------------------------------------------------------------------------
-- c)	



-- -----------------------------------------------------------------------------
-- d)	



-- -----------------------------------------------------------------------------
-- e)	



-- -----------------------------------------------------------------------------
-- Requête 6.2 :
-- -----------------------------------------------------------------------------
-- a)	


-- -----------------------------------------------------------------------------
-- b)	


-- -----------------------------------------------------------------------------
-- c)	


