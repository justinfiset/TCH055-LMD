----------------------------------------
---- Création des cours d'automne
----------------------------------------
INSERT INTO Cours (sigle, titre, nb_credits) VALUES ('AUT001', 'BD', 2);
INSERT INTO Cours (sigle, titre, nb_credits) VALUES ('AUT002', 'Mobile', 3);
INSERT INTO Cours (sigle, titre, nb_credits) VALUES ('AUT003', 'Web', 4);
INSERT INTO Cours (sigle, titre, nb_credits) VALUES ('AUT004', 'Architecture', 3);
INSERT INTO Cours (sigle, titre, nb_credits) VALUES ('AUT005', 'Français', 2);

----------------------------------------
---- Création des sessions
----------------------------------------
INSERT INTO SessionETS (code_session, date_debut, date_fin)
VALUES (1, TO_DATE('2024-09-02', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'));
INSERT INTO SessionETS (code_session, date_debut, date_fin)
VALUES (2, TO_DATE('2025-01-06', 'YYYY-MM-DD'), TO_DATE('2025-04-27', 'YYYY-MM-DD'));

----------------------------------------
---- Création des professeurs
----------------------------------------
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (1, 'Dhillon', 'Sally');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (2, 'Carrier', 'Christiane');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (3, 'Cooper', 'Sue');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (4, 'Silva', 'Nicola');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (5, 'Fuller', 'Leslie');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (6, 'Bruce', 'Josephine');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (7, 'Bell', 'Garth');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (8, 'Best', 'Jocelyn');

----------------------------------------
---- Création des étudiants
----------------------------------------
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (1, 'Dhillon', 'Sally');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (2, 'Carrier', 'Christiane');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (3, 'Cooper', 'Sue');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (4, 'Silva', 'Nicola');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (5, 'Fuller', 'Leslie');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (6, 'Bruce', 'Josephine');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (7, 'Bell', 'Garth');
INSERT INTO Professeur (code_professeur, nom, prenom) VALUES (8, 'Best', 'Jocelyn');

----------------------------------------
---- Création des groupes
----------------------------------------
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B1', 'Rousseau', 'Gilles', 201);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B2', 'Lafontaine', 'Darren', 201);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B3', 'Potter', 'Blair', 202);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B4', 'Harding', 'Patsy', 203);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B5', 'McKenzie', 'Jesse', 201);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B6', 'Dennis', 'Charlotte', 203);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B7', 'Wood', 'Mohamed', 201);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B8', 'Boily', 'Sarah', 204);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B9', 'Wells', 'Laurent', 201);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B10', 'Plourde', 'Laura', 203);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B11', 'Berthiaume', 'Travis', 202);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B12', 'Bissonnette', 'Dick', 202);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B13', 'Beck', 'Larry', 204);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B14', 'Simard', 'Shaun', 204);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B15', 'FitzGerald', 'Ying', 202);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B16', 'Wilson', 'Line', 204);
INSERT INTO etudiant (code_permanent, nom, prenom, code_programme) VALUES ('A1B17', 'Knight', 'Alison', 204);

----------------------------------------
---- Création des Préalable
----------------------------------------

----------------------------------------
---- Création des Inscription
----------------------------------------


