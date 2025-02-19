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
SELECT nom_produit, prix_unitaire
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
-- Requête 2.1 : Retrouver le type de paiement le plus utilisé par les clients.
-- -----------------------------------------------------------------------------

SELECT type_paiement
FROM (
        SELECT type_paiement, COUNT(*) AS cpt
        FROM Paiement
        GROUP BY type_paiement
        ORDER BY cpt DESC
     )
WHERE ROWNUM=1;
-- -----------------------------------------------------------------------------
-- Requête 2.2 :
-- -----------------------------------------------------------------------------

SELECT nom,prenom, no_civique, nom_rue, ville, pays,code_postal
FROM  Client
JOIN Adresse ON Client.id_adresse = Adresse.id_adresse
WHERE Adresse.id_adresse IN 
    (SELECT  Adresse.id_adresse
     FROM Client
     JOIN Adresse ON Client.id_adresse = Adresse.id_adresse
     GROUP BY Adresse.id_adresse 
     HAVING COUNT(Client.id_adresse)>1);
     
-- -----------------------------------------------------------------------------
-- Requête 2.3 : Lister les différentes catégories en indiquant le nom de la super catégorie si elle existe. 
-- -----------------------------------------------------------------------------

SELECT nom_categorie, nom_categorie_mere
FROM Categorie;
-- -----------------------------------------------------------------------------
-- Requête 2.4 :Afficher les prix réduits des produits en promotion. Pour cette requête, afficher pour chaque 
-- produit en promotion, le nom du produit, le prix unitaire, le montant de la promotion (le 
-- pourcentage), le montant de la réduction et le prix réduit. Trier le résultat par nom de produit 
-- et afficher les montants avec 2 chiffres après la virgule.  
-- -----------------------------------------------------------------------------

SELECT produit.nom_produit, produit.prix_unitaire, promotion.reduction AS reduc_pourcentage, 
(produit.prix_unitaire * (promotion.reduction/100))AS reductionPrix
,( produit.prix_unitaire -(produit.prix_unitaire * (promotion.reduction/100)))AS prix_Reduit
FROM produit, promotion
WHERE produit.id_promotion = promotion.id_promotion
ORDER BY produit.nom_produit;

-- ************************************BLOC 3***********************************
-- -----------------------------------------------------------------------------
-- Requête 3.1 :Trouvez les clients (nom et prénom) qui ont commandé les produits de la marque ‘DELL’.
-- -----------------------------------------------------------------------------
SELECT DISTINCT c.nom, c.prenom, c.no_client
FROM Client c
JOIN Commande co ON c.no_client = co.no_client
JOIN Commande_Produit cp ON co.no_commande = cp.no_commande
JOIN Produit p ON cp.no_produit = p.ref_produit
WHERE p.marque = 'DELL';

-- -----------------------------------------------------------------------------
-- Requête 3.2 :Affichez les produits (nom, marque, prix unitaire) par ordre croissant de prix et ordre croissant
-- de nom.
-- -----------------------------------------------------------------------------
SELECT p.nom_produit, p.marque, p.prix_unitaire
FROM Produit p
ORDER BY p.prix_unitaire ASC, p.nom_produit ASC;

-- -----------------------------------------------------------------------------
-- Requête 3.3 :Affichez le nombre de commande pour chaque statut (ENCOURS, ANNULEE ou FERMEE).
-- Pour cette requête, afficher le statut et le nombre de commandes correspondants par ordre
-- décroissant de nombre de commande.
-- -----------------------------------------------------------------------------
SELECT c.statut, COUNT(*) AS nombre_commandes
FROM Commande c
GROUP BY c.statut
ORDER BY nombre_commandes DESC;

-- -----------------------------------------------------------------------------
-- REQUËTE 3.4 : Afficher pour chaque facture le total des paiements effectués : afficher l’identifiant de la
-- facture et le total de ses paiements, par ordre croissant de l’identifiant.
-- -----------------------------------------------------------------------------
SELECT f.id_facture, SUM(p.montant) AS total_paiements
FROM Facture f
JOIN Paiement p ON f.id_facture = p.id_facture
GROUP BY f.id_facture
ORDER BY f.id_facture ASC;

-- -----------------------------------------------------------------------------
-- Requête 3.5 : Affichez les informations du client et l’adresse pour chaque livraison. Pour cette requête,
-- afficher le numéro et la date de livraison, le nom, le prénom et le numéro de téléphone du
-- client, ainsi que l’adresse de livraison (toutes les composantes de l’adresse). Triez par ordre
-- croissant du numéro de livraison. 
-- -----------------------------------------------------------------------------
SELECT l.no_livraison, l.date_livraison, 
       c.nom AS nom_client, c.prenom AS prenom_client, c.telephone,
       a.nom_rue, a.ville, a.code_postal, a.pays
FROM Livraison l
JOIN livraison_commande_produit lcp ON l.no_livraison = lcp.no_livraison
JOIN Commande_produit cp ON  lcp.no_commande = cp.no_commande
JOIN Commande co ON cp.no_commande= co.no_commande
JOIN Client c ON co.no_client = c.no_client
JOIN Adresse a ON c.id_adresse = a.id_adresse
GROUP BY l.no_livraison, l.date_livraison, 
       c.nom, c.prenom, c.telephone,
       a.nom_rue, a.ville, a.code_postal, a.pays
ORDER BY l.no_livraison ASC;

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
-- Requête 5.1 :Affichez la liste des clients qui ont réalisé au moins une commande. Pour cette requête,
-- afficher le nom, le prénom, le téléphone et les attributs de l’adresse du client.
-- -----------------------------------------------------------------------------
SELECT c.nom, c.prenom, c.telephone, 
       a.no_civique, a.nom_rue, a.ville, 
       a.pays, a.code_postal
FROM commande o
JOIN client c ON c.no_client = o.no_client
JOIN adresse a ON c.id_adresse = a.id_adresse
GROUP BY c.no_client, c.nom, c.prenom, 
         c.telephone, a.no_civique, 
         a.nom_rue, a.ville, a.pays, 
         a.code_postal
HAVING COUNT(*) > 1;

-- -----------------------------------------------------------------------------
-- Requête 5.2 :Affichez les commandes de la semaine du 06 février au 12 février. Pour cette requête, afficher
-- le numéro et la date de la commande, le nom, le prénom et le téléphone du client.
-- -----------------------------------------------------------------------------
SELECT o.no_commande, o.date_commande, c.nom, c.prenom, c.telephone
FROM commande o
JOIN client c ON o.no_client = c.no_client
WHERE o.date_commande between '2025/02/06' and '2025/02/12';

-- -----------------------------------------------------------------------------
-- Requête 5.3 : Affichez chaque produit et ses fournisseurs. Pour cette requête, afficher la référence du
-- produit, ainsi que le nom et le téléphone du fournisseur.
-- -----------------------------------------------------------------------------
SELECT DISTINCT p.ref_produit, f.nom_fournisseur, f.telephone
FROM produit p
JOIN produit_fournisseur j ON p.ref_produit = j.no_produit
JOIN fournisseur f ON j.code_fournisseur = f.code_fournisseur
OR p.code_fournisseur_prioritaire = f.code_fournisseur
ORDER BY p.ref_produit;

-- -----------------------------------------------------------------------------
-- Requête 5.4 : Lister les livraisons du mois de février 2025. Pour cette requête, afficher le numéro de la
-- commande, le numéro de la livraison et la date de livraison. Afficher le résultat par ordre
-- chronologique de la date de livraison.
-- -----------------------------------------------------------------------------
SELECT c.no_commande, l.no_livraison, l.date_livraison
FROM livraison l
JOIN livraison_commande_produit j ON l.no_livraison = j.no_livraison
JOIN commande c ON c.no_commande = j.no_commande
WHERE extract(month from l.date_livraison) = 2 
  AND extract(year from l.date_livraison) = 2025
ORDER BY l.date_livraison ASC;


-- ************************************BLOC 6***********************************
-- -----------------------------------------------------------------------------
-- Requête 6.1 :
-- -----------------------------------------------------------------------------
-- a)	Créez une vue nommé V_commande_item qui retrouve les items de toutes les
-- commandes (de tous les clients). Cette vue est composée des colonnes suivantes : le
-- nom et le prénom du client, le numéro de la commande, la quantité commandée, le prix
-- unitaire du produit et le statut de la commande.
CREATE OR REPLACE VIEW V_commande_item
AS
SELECT c.nom, c.prenom, co.no_commande, quantite_cmd, prix_unitaire, statut
FROM Commande_Produit
INNER JOIN Commande co ON Commande_Produit.no_commande = co.no_commande
INNER JOIN Client c ON co.no_client = c.no_client
INNER JOIN Produit ON Commande_Produit.no_produit = Produit.ref_produit;
-- -----------------------------------------------------------------------------
-- b)	Testez votre vue.
SELECT * 
FROM V_commande_item;
-- -----------------------------------------------------------------------------
-- c)	Utilisez la vue V_commande_item pour afficher tous les items de toutes les commandes
-- du client « Michel Tremblay ».
SELECT V_commande_item.*, (quantite_cmd * prix_unitaire) AS Prix_Total_Item
FROM V_commande_item
WHERE LOWER(prenom) = LOWER('Michel') -- Ici on vérifie sans tenir compte de la case
AND LOWER(nom) = LOWER('Tremblay');   -- Ainsi, peut importe l'entrée on trouve tous les items
-- -----------------------------------------------------------------------------
-- d)	Utilisez la vue V_commande_item pour afficher les items de la commande numéro 30. 
SELECT V_commande_item.*, (quantite_cmd * prix_unitaire) AS Prix_Total_Item
FROM V_commande_item
WHERE no_commande = 30;
-- -----------------------------------------------------------------------------
-- e)	Utilisez la vue pour afficher le montant total de la commande numéro 30.
SELECT sum(quantite_cmd * prix_unitaire) AS total_commande
FROM V_commande_item
WHERE no_commande = 30;
-- -----------------------------------------------------------------------------
-- Requête 6.2 :
-- -----------------------------------------------------------------------------
-- a) Écrire une requête qui retourne le plus grand nombre d’items (de produit) parmi toutes
-- les commandes. Cette requête affiche uniquement le nombre d’items.

SELECT MAX(SUM(quantite_cmd)) as max_nb_items
FROM commande_produit
GROUP BY no_commande;
-- -----------------------------------------------------------------------------
-- b)	Écrire une requête qui donne le numéro de la commande qui contient le plus d’items.
-- Indication : vous pouvez utiliser la requête a) comme une sous-requête. 
SELECT no_commande, max_nb_items
FROM (
    SELECT no_commande, SUM(quantite_cmd) AS max_nb_items
    FROM commande_produit
    GROUP BY no_commande
    ORDER BY max_nb_items DESC
)
WHERE ROWNUM = 1;
-- -----------------------------------------------------------------------------
-- c)	Écrire une requête pour déterminer la commande qui contient le plus d’items. Pour cette
-- requête, afficher le numéro, la date et le statut de la commande ainsi que le numéro du client
-- qui a passé cette commande, son nom et son prénom.
SELECT l.no_client, l.nom, l.prenom, c.date_commande, c.statut, p.no_commande, p.max_nb_items
FROM (
        SELECT no_commande, max_nb_items
        FROM (
                SELECT no_commande, SUM(quantite_cmd) AS max_nb_items
                FROM commande_produit
                GROUP BY no_commande
                ORDER BY max_nb_items DESC
             ) 
        WHERE ROWNUM = 1
     ) p
JOIN commande c ON c.no_commande = p.no_commande
JOIN client l ON c.no_client = l.no_client

