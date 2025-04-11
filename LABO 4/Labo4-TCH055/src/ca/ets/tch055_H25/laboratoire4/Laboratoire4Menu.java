package ca.ets.tch055_H25.laboratoire4;

import javax.xml.transform.Result;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;
import java.text.ParseException;
import java.util.Scanner;


/**
 * Classe principale du laboratoire 4
 * Contient un ensemble de méthodes statique pour
 * la manipulation de la BD Produit
 *
 * @author Pamella Kissok
 * @author Inoussa Legrene
 * @author Amal Ben Abdellah
 * @author
 * @author
 * @author
 * @author
 * @version 2
 * @equipe : XX
 */
public class Laboratoire4Menu {

    public static Statement statmnt = null;

    /* Référence vers l'objer de connection à la BD*/
    public static Connection connexion = null;

    /* Chargement du pilote Oracle */
    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {

            e.printStackTrace();
        }
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {

            e.printStackTrace();
        }
    }

    /**
     * Question : Ouverture de la connection
     *
     * @param login
     * @param password
     * @param uri
     * @return
     * @throws SQLException
     */
    public static Connection connexionBDD(String login, String password, String uri) throws SQLException, ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection une_connexion = DriverManager.getConnection(uri, login, password);
        return une_connexion;
    }

    /**
     * Option 1 - lister les produits
     *
     * @throws SQLException
     */
    public static void listerProduits() {
        try {
            Statement requete = connexion.createStatement();
            ResultSet resultats = requete.executeQuery(
                    "SELECT * FROM Produit ORDER BY ref_produit ASC"
            );
            System.out.println("--------------------------------------------------------------------------------------------");
            System.out.printf("%-10s %-15s %-15s %-15s %-10s %-8s %-10s %-10s\n",
                    "Référence", "NOM", "MARQUE", "Prix Unitaire", "Quantité", "Seuil", "Statut", "Code four.");
            System.out.println("--------------------------------------------------------------------------------------------");

            while (resultats.next()) {
                String ref = resultats.getString("ref_produit");
                String nom = resultats.getString("nom_produit");
                String marque = resultats.getString("marque");
                double prix = resultats.getDouble("prix_unitaire");
                int quantite = resultats.getInt("quantite_stock");
                int seuil = resultats.getInt("quantite_seuil");
                String statut = resultats.getString("statut_produit");
                int codeFournisseur = resultats.getInt("code_fournisseur_prioritaire");

                System.out.printf("%-10s %-15s %-15s %-15.1f %-10d %-8d %-10s %-10d\n",
                        ref, nom, marque, prix, quantite, seuil, statut, codeFournisseur);
            }
            System.out.println("--------------------------------------------------------------------------------------------");
            System.out.println("Appuyer sur ENTER pour continuer...");
            new java.util.Scanner(System.in).nextLine();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("Option 1 : listerProduits() n'est pas implémentée");
        }
    }

    /**
     * Option 2 - Ajouter un produit
     */
    public static void ajouterProduit() {
        Scanner sc = new Scanner(System.in);

        try {
            System.out.print("Veuillez saisir le numéro de référence : ");
            String ref = sc.nextLine();

            System.out.print("Veuillez saisir le nom du produit : ");
            String nom = sc.nextLine();

            System.out.print("Veuillez saisir la marque : ");
            String marque = sc.nextLine();

            System.out.print("Veuillez saisir le prix unitaire : ");
            double prix = Double.parseDouble(sc.nextLine());

            System.out.print("Veuillez saisir la quantité en stock : ");
            int stock = Integer.parseInt(sc.nextLine());

            System.out.print("Veuillez saisir la quantité seuil : ");
            int seuil = Integer.parseInt(sc.nextLine());

            System.out.print("Veuillez saisir la code de la catégorie : ");
            String nom_categorie = sc.nextLine();

            System.out.print("Veuillez saisir le code fournisseur prioritaire : ");
            int fournisseur = Integer.parseInt(sc.nextLine());

            PreparedStatement requete = connexion.prepareStatement("INSERT INTO Produit(ref_produit, " +
                    "nom_produit, marque, prix_unitaire, quantite_stock, quantite_seuil, nom_categorie, code_fournisseur_prioritaire)" +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

            requete.setString(1, ref);
            requete.setString(2, nom);
            requete.setString(3, marque);
            requete.setDouble(4, prix);
            requete.setInt(5, stock);
            requete.setInt(6, seuil);
            requete.setString(7, nom_categorie);
            requete.setInt(8, fournisseur);

            requete.executeUpdate();

            System.out.println("Produit ajouté avec succes!");
            System.out.println("Appuyer sur ENTER pour continuer...");
            sc.nextLine();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("Vous avez entrées des informations invalides. Veuillez recommencer.");
        }
    }

    /**
     * Option 3 : Affiche la Commande et ses items
     *
     * @param numCommande : numéro de la commande à afficher
     */
    public static void afficherCommande(int numCommande) throws SQLException {
        Scanner sc = new Scanner(System.in);
        float montantTotal = 0;
        //Section client/commande
        PreparedStatement requeteCommande = connexion.prepareStatement(
                "SELECT * FROM Client c " +
                        "JOIN Commande co ON c.no_client=co.no_client " +
                        "WHERE no_commande=?");
        requeteCommande.setInt(1, numCommande);
        ResultSet resultCommande = requeteCommande.executeQuery();
        while (resultCommande.next()) {
            System.out.println("Client	    : " + resultCommande.getString("prenom") + " " + resultCommande.getString("nom") + "\n" +
                    "Téléphone   : " + resultCommande.getString("telephone") + "\n" +
                    "No Commande : " + String.valueOf(resultCommande.getInt("no_commande")) + "\n" +
                    "Date        : " + resultCommande.getDate("date_commande") + "\n" +
                    "Statut      : " + resultCommande.getString("statut") + "\n" +
                    "----------------------------------------------------------------------------------------\n" +
                    "Ref Produit  Nom          Marque       Prix         Q.Commandée  Q.Stock      T.Partiel\n" +
                    "----------------------------------------------------------------------------------------");
        }

        //Section produits
        PreparedStatement requeteProduit = connexion.prepareStatement(
                "SELECT * FROM Commande_Produit cp " +
                        "JOIN Produit p ON p.ref_produit=cp.no_produit " +
                        "WHERE no_commande=?");
        requeteProduit.setInt(1, numCommande);
        ResultSet resultProduit = requeteProduit.executeQuery();
        while (resultProduit.next()) {
            montantTotal += (float) (resultProduit.getInt("quantite_cmd") * resultProduit.getInt("prix_unitaire"));
            System.out.printf("%-12s %-12s %-11.2s %8.2f %9.2f %13.2f %14.2f\n",
                    resultProduit.getString("ref_produit"), resultProduit.getString("nom_produit"), resultProduit.getString("marque"), (float) resultProduit.getInt("prix_unitaire"), (float) resultProduit.getInt("quantite_cmd"), (float) resultProduit.getInt("quantite_stock"), (float) (resultProduit.getInt("quantite_cmd") * resultProduit.getInt("prix_unitaire")));
        }
        System.out.println("----------------------------------------------------------------------------------------");

        System.out.println("Total commande :   " + montantTotal + "  $");
        System.out.println("Appuyer sur ENTER pour continuer...");
        sc.nextLine();
    }

    /**
     * Option 4 : Calcule le total des paiements effectués pour une facture
     *
     * @param numFacture : numéro de la facture
     * @param affichage  : si false, la méthode ne fait aucun affichage ni arrêt
     */
    public static float calculerPaiements(int numFacture, boolean affichage) {
        float total = 0;

        try {
            PreparedStatement requete = connexion.prepareStatement(
                    "SELECT montant FROM Paiement WHERE id_facture = ?");

            requete.setInt(1, numFacture);
            boolean factureExiste = false;
            ResultSet resultats = requete.executeQuery();
            while (resultats.next()) {
                total += resultats.getFloat("montant");
                factureExiste = true;
            }

            if (!factureExiste) {
                if (affichage) {
                    System.out.println("Aucun paiement trouvé pour la facture " + numFacture);
                }
                return -1;
            }

            if (affichage) {
                System.out.println("Total des paiements pour la facture " + numFacture + " : " + total);
                return total;
            } else {
                return total;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } catch (Exception e) {
            System.out.println("Option 4 : calculerPaiements() a échoué");
            return -1;
        }
    }


    /**
     * Option 5 -  Enregistrer un paiement
     * Ajoute un paiement pour une facture
     *
     * @param numFacture : numéro de la facture pour laquelle est fait le paiement
     */
    public static void enregistrerPaiement(int numFacture) {
        boolean factureExiste = false;
        float montantTotalFacture = 0.0f;

        try {
            // Vérification que la facture existe et récup du montant total de cette facture
            PreparedStatement request = connexion.prepareStatement("SELECT * FROM Facture WHERE id_facture = ?");
            request.setInt(1, numFacture);
            ResultSet results = request.executeQuery();

            while (results.next()) {
                factureExiste = true; // Si on a une facture, on garde en mémoire qu'elle existe
                float montant = results.getFloat("montant");
                float taxe = results.getFloat("taxe");
                montantTotalFacture = montant + taxe; // On caclule le montant total de la facture
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        // si la facture n'existe pas, on affiche un message et on arrête la fonctoin.
        if (!factureExiste) {
            System.out.println("La facture n'existe pas !");
            return;
        }

        Scanner sc = new Scanner(System.in);

        // Récup des paiements déjà fait sur la facture
        float paiementTotal = calculerPaiements(numFacture, false);
        float paiementRestant = montantTotalFacture - paiementTotal;
        // Affichage des montants à l'utilisateur
        System.out.println("=============================================================");
        System.out.println("Montant total de la facture : " + montantTotalFacture);
        System.out.println("Montant total des paiements déjà effectués : " + paiementTotal);

        // Si la facture est déjà payé, il est inutile de continuer la transaction
        if(paiementRestant <= 0) {
            System.out.println("La facture est déjà payé.");
            System.out.println("=============================================================");
            System.out.println("Appuyer sur ENTER pour continuer...");
            sc.nextLine();
            return;
        } else { // Sinon on affiche le montant que l'on peut payer
            System.out.println("Montant restant à payer : " + paiementRestant);
        }
        System.out.println("=============================================================");

        // récup du type de paiement de l'utilisateur
        System.out.print("Veuillez choisir un type de paiement ( cash / cheque / credit ) : ");
        String typePaiement = sc.nextLine().toUpperCase();

        // Si le montant du paiement est sup. au total, on affiche une erreur et arrête la fonction.
        try {
            System.out.print("Veuillez entrer le montant du paiement : ");
            float montant = Float.parseFloat(sc.nextLine());

            if ((paiementTotal + montant) > montantTotalFacture) {
                System.out.println("Le montant du nouveau paiement dépasse le montant total de la facture " +
                        "incluant les taxes. Veuillez choisir un montant inférieur ou égal au montant de la facture.");
                System.out.println("Appuyer sur ENTER pour continuer...");
                sc.nextLine();
                return;
            }

            int sucess = 0;
            PreparedStatement request;
            switch (typePaiement) { // On ignore la case pour le type
                case "CASH":
                    request = connexion.prepareStatement(
                            "INSERT INTO Paiement (date_paiement, montant, type_paiement, id_facture)" +
                                    "VALUES (?, ?, ?, ?)"
                    );
                    request.setDate(1, new java.sql.Date(System.currentTimeMillis()));
                    request.setFloat(2, montant);
                    request.setString(3, typePaiement);
                    request.setInt(4, numFacture);

                    sucess = request.executeUpdate();
                    break;
                case "CHEQUE":
                    System.out.print("Veuillez choisir le numéro du cheque : ");
                    int noCheque = Integer.parseInt(sc.nextLine());
                    System.out.print("Veuillez entrer le nom de la banque : ");
                    String nomBanque = sc.nextLine();

                    request = connexion.prepareStatement(
                            "INSERT INTO Paiement (date_paiement, montant, type_paiement, no_cheque, nom_banque, id_facture)" +
                                    "VALUES (?, ?, ?, ?, ?, ?)"
                    );
                    request.setDate(1, new java.sql.Date(System.currentTimeMillis()));
                    request.setFloat(2, montant);
                    request.setString(3, typePaiement);
                    request.setInt(4, noCheque);
                    request.setString(5, nomBanque);
                    request.setInt(6, numFacture);

                    sucess = request.executeUpdate();
                    break;
                case "CREDIT":
                    System.out.print("Veuillez entrer le numéro de la carte de crédit : ");
                    String noCarte = sc.nextLine();
                    System.out.print("Veuillez entrer le mois d'expiration de la carte : ");
                    int moisExpiration = Integer.parseInt(sc.nextLine()) + 1; // On ajoute + 1 car le constructeur de date comprend un mois entre 0 et 11
                    System.out.print("Veuillez entrer l'anné d'expiraiton de la carte : ");
                    int anneExpiration = Integer.parseInt(sc.nextLine());
                    Date dateExpiration = new Date(anneExpiration, moisExpiration, 0);
                    System.out.print("Veuillez entrer le type de la carte (VISA / MASTERCARD / AMEX) : ");
                    String typeCarte = sc.nextLine().toUpperCase();

                    request = connexion.prepareStatement(
                            "INSERT INTO Paiement (date_paiement, montant, type_paiement, no_carte_credit, date_expiration, type_carte_credit, id_facture)" +
                                    "VALUES (?, ?, ?, ?, ?, ?, ?)"
                    );
                    request.setDate(1, new java.sql.Date(System.currentTimeMillis()));
                    request.setFloat(2, montant);
                    request.setString(3, typePaiement);
                    request.setString(4, noCarte);
                    request.setDate(5, dateExpiration);
                    request.setString(6, typeCarte);
                    request.setInt(7, numFacture);

                    sucess = request.executeUpdate();
                    break;
                default:
                    System.out.println("Veuillez entrer un type de paiment valide.");
                    break;
            }

            // On vérifie si le nb de colonne est plus grand que 0 et on indique l'état à l'utilisateur
            if (sucess > 0) {
                System.out.println("Paiement réussi !\n");
            } else {
                System.out.println("Erreur lors de l'insertion du paiement.");
            }
        } catch (NumberFormatException e) {
            System.out.println("Veuillez entrer un nombre valide.");
        } catch (SQLException e) {
            System.out.println("Erreur de création du paiement : " + e.getMessage());
        }
        System.out.println("Appuyer sur ENTER pour continuer...");
        sc.nextLine();
    }

    /**
     * Option 6 : enregistre une liste d'évalutions dans la BD. Les données d'une évaluation sont des objets
     * SatisfactionData.
     *
     * @param listEvaluation : tableau d'objet StatisfactionData, contient les données des évaluations
     *                       du client à insérer dans la BD
     */
    public static void enregistreEvaluation(SatisfactionData[] listEvaluation) {
        try {

            PreparedStatement evalExistant = connexion.prepareStatement("SELECT * FROM Satisfaction WHERE no_client = ? AND ref_produit = ? AND note= ? AND  commentaire = ?");
            PreparedStatement requete = connexion.prepareStatement("INSERT INTO Satisfaction (no_client,ref_produit,note,commentaire) VALUES (?,?,?,?)");
            PreparedStatement verifieNoClient = connexion.prepareStatement("SELECT * FROM Client WHERE no_client = ?");
            PreparedStatement verifieRefProduit = connexion.prepareStatement("SELECT * FROM Produit WHERE ref_produit=?");

            int total = 0;

            for (SatisfactionData satisfactionData : listEvaluation) {

                verifieNoClient.setInt(1, satisfactionData.no_client);
                verifieRefProduit.setString(1, satisfactionData.ref_produit);
                ResultSet resultVerif1 = verifieNoClient.executeQuery();
                ResultSet resultVerif2 = verifieRefProduit.executeQuery();

                if (resultVerif1.next() && resultVerif2.next()) {

                    evalExistant.setInt(1, satisfactionData.no_client);
                    evalExistant.setString(2, satisfactionData.ref_produit);
                    evalExistant.setInt(3, satisfactionData.note);
                    evalExistant.setString(4, satisfactionData.commentaire);
                    ResultSet result = evalExistant.executeQuery();

                    if (!result.next()) {

                        requete.setInt(1, satisfactionData.no_client);
                        requete.setString(2, satisfactionData.ref_produit);
                        requete.setInt(3, satisfactionData.note);
                        requete.setString(4, satisfactionData.commentaire);
                        total = +1;
                        requete.addBatch();
                    }
                }

            }

            requete.executeBatch();


            System.out.printf("Le nombre d'insertion d'évaluation produit réussi est de %d.\n\n", total);

        } catch (SQLException e) {
            System.out.println(e.getMessage() + '\n' + e.getCause());
        }


    }

    /**
     * Question 9 - fermeture de la connexion
     *
     * @return
     */
    public static boolean fermetureConnexion() {
        boolean resultat = false;

        try {
            connexion.close();
            resultat = true;
        } catch (SQLException e) {
            System.out.println("Erreur lors de la fermeture de connexion : " + e.getMessage());
        }

        return resultat;
    }

    // ==============================================================================
    // NE PAS MODIFIER LE CODE QUI VA SUIVRE
    // ==============================================================================

    /**
     * Crée et retourne un tableau qui contient 5 évaluations de produits
     * Chaque évaluation est stockée dans un objet de la classe SatisfactionData
     *
     * @return un tableau d'objets SatisfactionData
     */
    public static SatisfactionData[] listSatisfactionData() {

        SatisfactionData[] list = new SatisfactionData[5];

        list[0] = new SatisfactionData(105, "PC2000", 4, "PC très performant");
        list[1] = new SatisfactionData(105, "LT2011", 3, "Produit satisfaisant, un peu bruyant");
        list[2] = new SatisfactionData(103, "PC2000", 5, "Excellent ordinateur");
        list[3] = new SatisfactionData(101, "DD2003", 2, "Performance moyenne du disque");
        list[4] = new SatisfactionData(104, "SF3001", 4, "Je suis très satisfait de ma nouvelle version de l'OS");

        return list;
    }
    /* ------------------------------------------------------------------------- */

    /**
     * Affiche un menu pour le choix des opérations
     */
    public static void afficheMenu() {
        System.out.println("0. Quitter le programme");
        System.out.println("1. Lister les produits");
        System.out.println("2. Ajouter un produit");
        System.out.println("3. Afficher une commande");
        System.out.println("4. Afficher le montant payé d'une facture");
        System.out.println("5. Enregistrer un paiement");
        System.out.println("6. Enregistrer les évaluations des clients");
        System.out.println();
        System.out.println("Votre choix...");
    }


    /**
     * La méthode main pour le lancement du programme
     * Il faut mettre les informations d'accès à la BDD
     *
     * @param args
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public static void main(String args[]) throws ClassNotFoundException, SQLException {

        // Mettre les informations de votre compte sur SGBD Oracle
        String username = "tp4";
        String motDePasse = "tp4";

        String uri = "jdbc:oracle:thin:@localhost:1521:xe";

        // Appel de le méthode pour établir la connexion avec le SGBD
        connexion = connexionBDD(username, motDePasse, uri);

        if (connexion != null) {

            System.out.println("Connection reussie...");

            // Affichage du menu pour le choix des opérations
            afficheMenu();

            Scanner sc = new Scanner(System.in);
            String choix = sc.nextLine();

            while (!choix.equals("0")) {

                if (choix.equals("1")) {

                    listerProduits();

                } else if (choix.equals("2")) {

                    ajouterProduit();

                } else if (choix.equals("3")) {

                    System.out.print("Veuillez saisir le numéro de la commande: ");
                    sc = new Scanner(System.in);
                    int numCommande = Integer.parseInt(sc.nextLine().trim());

                    afficherCommande(numCommande);

                } else if (choix.equals("4")) {

                    sc = new Scanner(System.in);
                    System.out.print("Veuillez saisir le numéro de la facture : ");
                    int numFacture = Integer.parseInt(sc.nextLine().trim());
                    calculerPaiements(numFacture, true);

                } else if (choix.equals("5")) {


                    System.out.print("Veuillez saisir le numéro de la facture : ");
                    int numFacture = Integer.parseInt(sc.nextLine().trim());
                    sc = new Scanner(System.in);
                    enregistrerPaiement(numFacture);

                } else if (choix.equals("6")) {
                    enregistreEvaluation(listSatisfactionData());

                }

                afficheMenu();
                sc = new Scanner(System.in);
                choix = sc.nextLine();

            } // while

            // FIn de la boucle While - Fermeture de la connexion
            if (fermetureConnexion()) {
                System.out.println("Déconnexion réussie...");
            } else {
                System.out.println("Échec ou Erreur lors de le déconnexion...");
            }

        } else {  // if (connexion != null) {

            System.out.println("Échec de la Connection. Au revoir ! ");

        } // if (connexion != null) {
    } // main()
}


// =============================================================================================

/**
 * Contient les données d'une évaluation d'un produit
 *
 * @author Pamella Kissok
 * @author Inoussa Legrene
 * @author Amal Ben Abdellah
 * @version 2
 */
class SatisfactionData {
    int no_client;
    String ref_produit;
    int note;
    String commentaire;

    /**
     * Constructeur
     *
     * @param no_client
     * @param ref_produit
     * @param note
     * @param commentaire
     */
    public SatisfactionData(int no_client, String ref_produit, int note, String commentaire) {
        super();
        this.no_client = no_client;
        this.ref_produit = ref_produit;
        this.note = note;
        this.commentaire = commentaire;
    }
}