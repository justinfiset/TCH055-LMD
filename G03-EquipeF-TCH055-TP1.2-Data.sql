----------------------------------------
---- Création des cours d'automne
----------------------------------------
INSERT INTO Cours (sigle, titre, nb_credits) 
VALUES ('TCH055', 'BD', 2);

INSERT INTO Cours (sigle, titre, nb_credits) 
VALUES ('TCH057', 'Mobile', 3);

INSERT INTO Cours (sigle, titre, nb_credits) 
VALUES ('TCH056', 'Web', 4);

INSERT INTO Cours (sigle, titre, nb_credits) 
VALUES ('TCH017', 'Architecture', 3);

INSERT INTO Cours (sigle, titre, nb_credits) 
VALUES ('TCH099', 'Projet Integrateur', 3);

INSERT INTO Cours (sigle, titre, nb_credits) 
VALUES ('COM100', 'Français', 2);

INSERT INTO Cours (sigle, titre, nb_credits) 
VALUES ('COM121', 'Français 2', 2);

INSERT INTO Cours (sigle, titre, nb_credits)
VALUES ('LOG320', 'Programmation avancé', 3);

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
INSERT INTO Professeur (code_professeur, nom, prenom) 
VALUES ('PROF1', 'Dhillon', 'Sally');

INSERT INTO Professeur (code_professeur, nom, prenom) 
VALUES ('PROF2', 'Carrier', 'Christiane');

INSERT INTO Professeur (code_professeur, nom, prenom) 
VALUES ('PROF3', 'Cooper', 'Sue');

INSERT INTO Professeur (code_professeur, nom, prenom) 
VALUES ('PROF4', 'Silva', 'Nicola');

INSERT INTO Professeur (code_professeur, nom, prenom) 
VALUES ('PROF5', 'Fuller', 'Leslie');

INSERT INTO Professeur (code_professeur, nom, prenom) 
VALUES ('PROF6', 'Bruce', 'Josephine');

INSERT INTO Professeur (code_professeur, nom, prenom) 
VALUES ('PROF7', 'Bell', 'Garth');

INSERT INTO Professeur (code_professeur, nom, prenom) 
VALUES ('PROF8', 'Best', 'Jocelyn');

----------------------------------------
---- Création des étudiants
----------------------------------------
INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B01', 'Rousseau', 'Gilles', 201);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B02', 'Lafontaine', 'Darren', 201);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B03', 'Potter', 'Blair', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B04', 'Harding', 'Patsy', 203);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B05', 'McKenzie', 'Jesse', 201);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B06', 'Dennis', 'Charlotte', 203);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B07', 'Wood', 'Mohamed', 201);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B08', 'Boily', 'Sarah', 204);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B09', 'Wells', 'Laurent', 201);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B10', 'Plourde', 'Laura', 203);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B11', 'Berthiaume', 'Travis', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B12', 'Bissonnette', 'Dick', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B13', 'Beck', 'Larry', 204);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B14', 'Simard', 'Shaun', 204);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B15', 'FitzGerald', 'Ying', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B16', 'Wilson', 'Line', 204);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B17', 'Knight', 'Alison', 204);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B17', 'Dubois', 'Martine', 203);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme)
VALUES ('A1B18', 'Hudson', 'Sandi', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B19', 'Cloutier', 'Remi', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B20', 'Laporte', 'Matthew', 204);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B21', 'Lewis', 'Lawrence', 203);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B22', 'Bolduc', 'Gregory', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B23', 'Dumais', 'Deb', 204);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B24', 'Fleury', 'Roxanne', 201);

----------------------------------------
---- Création des groupes
----------------------------------------
-- SESSION AUTOMNE 2024
INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscription, code_professeur)
VALUES ('TCH055', 1, 1, 50, 'PROF1');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscription, code_professeur)
VALUES ('TCH056', 1, 1, 40, 'PROF2');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscription, code_professeur)
VALUES ('TCH057', 1, 1, 35, 'PROF3');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscription, code_professeur)
VALUES ('COM100', 1, 1, 55, 'PROF4');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscription, code_professeur)
VALUES ('TCH017', 1, 1, 35, 'PROF1'); -- Le deuxîême cours donnée par le même professeur pour la session A24

-- SESSION HIVERS 2025
-- Les cours sont données par 4 prof différentes mais 2 sont des anciens de la session d'automne.
INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscription, code_professeur)
VALUES ('TCH099', 1, 2, 45, 'PROF1');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscription, code_professeur)
VALUES ('COM121', 1, 2, 45, 'PROF7');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscription, code_professeur)
VALUES ('LOG320', 1, 2, 50, 'PROF8');

-- On a un cours qui a déjà été donné à la session d'automne
INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscription, code_professeur)
VALUES ('TCH057', 1, 2, 40, 'PROF3');

----------------------------------------
---- Création des Préalable
----------------------------------------
-- PRÉALABLES POUR LES SESSION H25
-- Le cours 1 et 2 ont uniquement un préalable qui a été donnée à la session A24
INSERT INTO Prealable (sigle, sigle_prealable)
VALUES ('TCH099', 'TCH056');

INSERT INTO Prealable (sigle, sigle_prealable)
VALUES ('COM121', 'COM100');

-- On définit que le cours LOG320 (3e cours) possède 2 préalable (TCH056 ET TCH055)
INSERT INTO Prealable (sigle, sigle_prealable)
VALUES ('LOG320', 'TCH056');

INSERT INTO Prealable (sigle, sigle_prealable)
VALUES ('LOG320', 'TCH055');

----------------------------------------
---- Création des Inscription
----------------------------------------
-- INSCRIPTIONS POUR LA SESSION H2024
-- Cours 1
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ();

-- Cours 2
-- Cours 3
-- Cours 4
-- Cours 5

-- INSCRIPTIONS POUR LA SESSION H2025
-- Cours 1
-- Cours 2
-- Cours 3
-- Cours 4

----------------------------------------
---- Création des groupes pour les cours
----------------------------------------

----------------------------------------
---- Gestion des abansons
----------------------------------------
