DELETE FROM Cours;
DELETE FROM Etudiant;
DELETE FROM Professeur;
DELETE FROM SessionETS;
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
VALUES ('A1B18', 'Dubois', 'Martine', 203);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme)
VALUES ('A1B19', 'Hudson', 'Sandi', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B20', 'Cloutier', 'Remi', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B21', 'Laporte', 'Matthew', 204);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B22', 'Lewis', 'Lawrence', 203);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B23', 'Bolduc', 'Gregory', 202);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B24', 'Dumais', 'Deb', 204);

INSERT INTO Etudiant (code_permanent, nom, prenom, code_programme) 
VALUES ('A1B25', 'Fleury', 'Roxanne', 201);

----------------------------------------
---- Création des groupes
----------------------------------------
-- SESSION AUTOMNE 2024
INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscriptions, code_professeur)
VALUES ('TCH055', 1, 1, 50, 'PROF1');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscriptions, code_professeur)
VALUES ('TCH056', 1, 1, 40, 'PROF2');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscriptions, code_professeur)
VALUES ('TCH057', 1, 1, 35, 'PROF3');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscriptions, code_professeur)
VALUES ('COM100', 1, 1, 55, 'PROF4');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscriptions, code_professeur)
VALUES ('TCH017', 1, 1, 35, 'PROF1'); -- Le deuxîême cours donnée par le même professeur pour la session A24

-- SESSION HIVERS 2025
-- Les cours sont données par 4 prof différentes mais 2 sont des anciens de la session d'automne.
INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscriptions, code_professeur)
VALUES ('TCH099', 1, 2, 45, 'PROF2'); -- Un des deux cours qui sont donner par un professeur pour la session A24

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscriptions, code_professeur)
VALUES ('COM121', 1, 2, 45, 'PROF5');

INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscriptions, code_professeur)
VALUES ('LOG320', 1, 2, 50, 'PROF6');

-- On a un cours qui a déjà été donné à la session d'automne
INSERT INTO CoursGroupe (sigle, no_groupe, code_session, max_inscriptions, code_professeur)
VALUES ('TCH057', 1, 2, 40, 'PROF3'); -- Deuxieme des deux cours qui sont donner par un professeur pour la session A24

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
-- Cours 1(10 inscription avec aucun abandon)
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B01', 'TCH055', 1, 1, TO_DATE('16-04-2024','DD-MM-YYYY' ), NULL, 81);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B02', 'TCH055', 1, 1, TO_DATE('16-04-2024','DD-MM-YYYY' ), NULL, 56);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B03', 'TCH055', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY' ), NULL, 87);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B04', 'TCH055', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY' ), NULL, 84);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B05', 'TCH055', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY' ), NULL, 59);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B06', 'TCH055', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY' ), NULL, 92);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B07', 'TCH055', 1, 1, TO_DATE('16-04-2024','DD-MM-YYYY' ), NULL, 48);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B08', 'TCH055', 1, 1, TO_DATE('12-05-2024','DD-MM-YYYY' ), NULL, 74);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B09', 'TCH055', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY' ), NULL, 68);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES ('A1B10', 'TCH055', 1, 1, TO_DATE('12-05-2024','DD-MM-YYYY' ), NULL, 56);

-- Cours 2(10 inscription avec aucun abandon)
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B10', 'TCH056', 1, 1, TO_DATE('16-04-2024','DD-MM-YYYY' ), NULL, 31);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B11', 'TCH056', 1, 1, TO_DATE('22-04-2024','DD-MM-YYYY' ), NULL, 64);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B12', 'TCH056', 1, 1, TO_DATE('16-04-2024','DD-MM-YYYY' ), NULL, 89);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B13', 'TCH056', 1, 1, TO_DATE('22-04-2024','DD-MM-YYYY' ), NULL, 37);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B14', 'TCH056', 1, 1, TO_DATE('22-04-2024','DD-MM-YYYY' ), NULL, 49);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B15', 'TCH056', 1, 1, TO_DATE('16-04-2024','DD-MM-YYYY' ), NULL, 56);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B16', 'TCH056', 1, 1, TO_DATE('12-05-2024','DD-MM-YYYY' ), NULL, 76);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B07', 'TCH056', 1, 1, TO_DATE('16-04-2024','DD-MM-YYYY' ), NULL, 100);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B08', 'TCH056', 1, 1, TO_DATE('27-04-2024','DD-MM-YYYY' ), NULL, 95);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B09', 'TCH056', 1, 1, TO_DATE('16-04-2024','DD-MM-YYYY' ), NULL, 55);

-- Cours 3(10 inscription avec 2 abandon, ALB12 et ALB13)
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B01', 'TCH057', 1, 1, TO_DATE('27-04-2024','DD-MM-YYYY' ), NULL, 68);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B03', 'TCH057', 1, 1, TO_DATE('01-05-2024','DD-MM-YYYY' ), NULL, 36);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B06', 'TCH057', 1, 1, TO_DATE('27-04-2024','DD-MM-YYYY' ), NULL, 60);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B07', 'TCH057', 1, 1, TO_DATE('22-04-2024','DD-MM-YYYY' ), NULL, 58);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B10', 'TCH057', 1, 1, TO_DATE('01-05-2024','DD-MM-YYYY' ), NULL, 78);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B12', 'TCH057', 1, 1, TO_DATE('27-04-2024','DD-MM-YYYY' ), TO_DATE('06-12-2024','DD-MM-YYYY'), NULL);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B13', 'TCH057', 1, 1, TO_DATE('27-04-2024','DD-MM-YYYY' ), TO_DATE('24-11-2024','DD-MM-YYYY'), NULL);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B14', 'TCH057', 1, 1, TO_DATE('24-04-2024','DD-MM-YYYY' ), NULL, 51);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B15', 'TCH057', 1, 1, TO_DATE('27-04-2024','DD-MM-YYYY' ), NULL, 91);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B17', 'TCH057', 1, 1, TO_DATE('24-04-2024','DD-MM-YYYY' ), NULL, 84);

-- Cours 4 (15 inscriptions avec 5 abandons)
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B03', 'COM100', 1, 1, TO_DATE('27-04-2024','DD-MM-YYYY' ), NULL, 51);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B04', 'COM100', 1, 1, TO_DATE('29-04-2024','DD-MM-YYYY' ), NULL, 40);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B05', 'COM100', 1, 1, TO_DATE('30-04-2024','DD-MM-YYYY' ), NULL, 68);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B06', 'COM100', 1, 1, TO_DATE('24-04-2024','DD-MM-YYYY' ), TO_DATE('02-10-2024','DD-MM-YYYY'), NULL);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B07', 'COM100', 1, 1, TO_DATE('24-04-2024','DD-MM-YYYY' ), TO_DATE('26-09-2024','DD-MM-YYYY'), NULL);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B08', 'COM100', 1, 1, TO_DATE('27-04-2024','DD-MM-YYYY' ), TO_DATE('15-09-2024','DD-MM-YYYY'), NULL);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B09', 'COM100', 1, 1, TO_DATE('28-04-2024','DD-MM-YYYY' ), TO_DATE('19-10-2024','DD-MM-YYYY'), NULL);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B10', 'COM100', 1, 1, TO_DATE('30-04-2024','DD-MM-YYYY' ), TO_DATE('19-09-2024','DD-MM-YYYY'), NULL);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B11', 'COM100', 1, 1, TO_DATE('01-05-2024','DD-MM-YYYY' ), NULL, 85);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B12', 'COM100', 1, 1, TO_DATE('01-05-2024','DD-MM-YYYY' ), NULL, 77);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B13', 'COM100', 1, 1, TO_DATE('01-05-2024','DD-MM-YYYY' ), NULL, 90);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B14', 'COM100', 1, 1, TO_DATE('01-05-2024','DD-MM-YYYY' ), NULL, 49);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B15', 'COM100', 1, 1, TO_DATE('01-05-2024','DD-MM-YYYY' ), NULL, 44);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B16', 'COM100', 1, 1, TO_DATE('30-04-2024','DD-MM-YYYY' ), NULL, 76);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B17', 'COM100', 1, 1, TO_DATE('30-04-2024','DD-MM-YYYY' ), NULL, 61);

-- Cours 5 (12 inscriptions avec aucun abandon)
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B03', 'TCH017', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY'), NULL, 51);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B04', 'TCH017', 1, 1, TO_DATE('18-04-2024','DD-MM-YYYY'), NULL, 40);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B05', 'TCH017', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY'), NULL, 68);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B06', 'TCH017', 1, 1, TO_DATE('18-04-2024','DD-MM-YYYY'), NULL, 78);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B07', 'TCH017', 1, 1, TO_DATE('18-04-2024','DD-MM-YYYY'), NULL, 45);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B08', 'TCH017', 1, 1, TO_DATE('24-04-2024','DD-MM-YYYY'), NULL, 43);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B09', 'TCH017', 1, 1, TO_DATE('24-04-2024','DD-MM-YYYY'), NULL, 77);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B10', 'TCH017', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY'), NULL, 99);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B11', 'TCH017', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY'), NULL, 41);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B12', 'TCH017', 1, 1, TO_DATE('24-04-2024','DD-MM-YYYY'), NULL, 79);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B13', 'TCH017', 1, 1, TO_DATE('17-04-2024','DD-MM-YYYY'), NULL, 72);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B14', 'TCH017', 1, 1, TO_DATE('24-04-2024','DD-MM-YYYY'), NULL, 91);


-- INSCRIPTIONS POUR LA SESSION H2025
-- Cours 1, 1 prealable(8 inscription avec aucun abandon)
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B18', 'TCH099', 1, 2, TO_DATE('27-11-2024','DD-MM-YYYY' ), NULL, 63);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B19', 'TCH099', 1, 2, TO_DATE('02-12-2024','DD-MM-YYYY' ), NULL, 94);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B20', 'TCH099', 1, 2, TO_DATE('10-12-2024','DD-MM-YYYY' ), NULL, 82);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B21', 'TCH099', 1, 2, TO_DATE('15-11-2024','DD-MM-YYYY' ), NULL, 86);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B22', 'TCH099', 1, 2, TO_DATE('05-12-2024','DD-MM-YYYY' ), NULL, 91);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B23', 'TCH099', 1, 2, TO_DATE('01-12-2024','DD-MM-YYYY' ), NULL, 64);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B24', 'TCH099', 1, 2, TO_DATE('20-11-2024','DD-MM-YYYY' ), NULL, 65);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B25', 'TCH099', 1, 2, TO_DATE('12-12-2024','DD-MM-YYYY' ), NULL, 69);

-- Cours 2, 1 prealable(8 inscription avec aucun abandon)
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B18', 'COM121', 1, 2, TO_DATE('28-11-2024','DD-MM-YYYY' ), NULL, 92);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B19', 'COM121', 1, 2, TO_DATE('02-12-2024','DD-MM-YYYY' ), NULL, 43);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B20', 'COM121', 1, 2, TO_DATE('10-12-2024','DD-MM-YYYY' ), NULL, 42);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B21', 'COM121', 1, 2, TO_DATE('15-11-2024','DD-MM-YYYY' ), NULL, 63);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B22', 'COM121', 1, 2, TO_DATE('05-12-2024','DD-MM-YYYY' ), NULL, 74);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B23', 'COM121', 1, 2, TO_DATE('01-12-2024','DD-MM-YYYY' ), NULL, 70);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B24', 'COM121', 1, 2, TO_DATE('20-11-2024','DD-MM-YYYY' ), NULL, 99);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B25', 'COM121', 1, 2, TO_DATE('12-12-2024','DD-MM-YYYY' ), NULL, 79);

-- Cours 3, 2 prealable(7 inscription avec 2 abandon)
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B08', 'LOG320', 1, 2, TO_DATE('02-12-2024','DD-MM-YYYY' ), NULL, 73);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B09', 'LOG320', 1, 2, TO_DATE('10-12-2024','DD-MM-YYYY' ), NULL, 64);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B10', 'LOG320', 1, 2, TO_DATE('06-12-2024','DD-MM-YYYY' ), TO_DATE('30-01-2025','DD-MM-YYYY' ), NULL);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B11', 'LOG320', 1, 2, TO_DATE('25-11-2024','DD-MM-YYYY' ), NULL, 77);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B12', 'LOG320', 1, 2, TO_DATE('05-12-2024','DD-MM-YYYY' ), NULL, 100);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B13', 'LOG320', 1, 2, TO_DATE('03-12-2024','DD-MM-YYYY' ), TO_DATE('23-02-2025','DD-MM-YYYY' ), NULL);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B14', 'LOG320', 1, 2, TO_DATE('15-11-2024','DD-MM-YYYY' ), NULL, 76);

-- Cours 4, meme cours de la session automne(8 inscription avec aucun abandon)
INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B01', 'TCH057', 1, 2, TO_DATE('06-12-2024','DD-MM-YYYY' ), NULL, 76);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B02', 'TCH057', 1, 2, TO_DATE('02-12-2024','DD-MM-YYYY' ), NULL, 74);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B03', 'TCH057', 1, 2, TO_DATE('05-12-2024','DD-MM-YYYY' ), NULL, 82);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B04', 'TCH057', 1, 2, TO_DATE('10-12-2024','DD-MM-YYYY' ), NULL, 71);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B05', 'TCH057', 1, 2, TO_DATE('13-12-2024','DD-MM-YYYY' ), NULL, 82);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B23', 'TCH057', 1, 2, TO_DATE('25-11-2024','DD-MM-YYYY' ), NULL, 84);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B24', 'TCH057', 1, 2, TO_DATE('30-11-2024','DD-MM-YYYY' ), NULL, 67);

INSERT INTO Inscription (code_permanent, sigle, no_groupe, code_session, date_inscription, date_abandon, note)
VALUES('A1B25', 'TCH057', 1, 2, TO_DATE('08-12-2024','DD-MM-YYYY' ), NULL, 41);


----------------------------------------
---- Gestion des abandons
----------------------------------------
DELETE FROM CoursGroupe 
WHERE sigle = (
    SELECT sigle 
    FROM Inscription 
    WHERE code_session = 2  
      AND date_abandon IS NOT NULL
    GROUP BY sigle
    HAVING COUNT(*) = 2
);