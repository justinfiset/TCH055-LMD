-- TCH055 - LABORATOIRE 1 PARTIE 2
-- SCRIPT DE CREATION DU MODELE PHYSIQUE DE DONNES
-- AUTEUR : JUSTIN FISET

----------------------------------------------
---- Creation de la table Cours
----------------------------------------------
CREATE TABLE Cours (
    sigle VARCHAR2(6) NOT NULL,
    titre VARCHAR2(50) NOT NULL,
    nb_credits NUMBER(2) NOT NULL,
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_Cours PRIMARY KEY (sigle)
    CHECK 
);

----------------------------------------------
---- Creation de la table Prealable
----------------------------------------------
CREATE TABLE Prealable (
    sigle VARCHAR2(6),
    sigle_prealable VARCHAR(6),
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_Prealable PRIMARY KEY (sigle, sigle_prealable),
    
    -- Contrainte de clé étrangère
    CONSTRAINT FK_Sigle FOREIGN KEY (sigle) REFERENCES Cours,
    CONSTRAINT FK_SiglePrealable FOREIGN KEY (sigle_prealable) REFERENCES Cours
);

----------------------------------------------
---- Creation de la table SessionETS
----------------------------------------------
CREATE TABLE SessionETS (
    code_session NUMBER(2) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_SessoinETS PRIMARY KEY (code_session)
);

----------------------------------------------
---- Creation de la table CoursGroupe
----------------------------------------------
CREATE TABLE CoursGroupe (
    sigle VARCHAR2(6) NOT NULL,
    no_groupe NUMBER(2) NOT NULL,
    code_session NUMBER(2) NOT NULL,
    max_inscriptions NUMBER(3) NOT NULL,
    code_professeur VARCHAR2(5) NOT NULL,
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_CoursGroupe PRIMARY KEY (sigle, no_groupe, code_session),
    
    -- Contrainte de clé étrangère
    CONSTRAINT FK_Sigle FOREIGN KEY (sigle) REFERENCES Cours,
    CONSTRAINT FK_CodeSession FOREIGN KEY (code_session) REFERENCES SessionETS,
    CONSTRAINT FK_CodeProfesseur FOREIGN KEY (code_professeur) REFERENCES Professeur
);

----------------------------------------------
---- Creation de la table Professeur
----------------------------------------------
CREATE TABLE Professeur (
    code_professeur VARCHAR2(5) NOT NULL,
    nom VARCHAR2(20) NOT NULL,
    prenom VARCHAR2(20) NOT NULL,
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_CodeProfesseur PRIMARY KEY (code_professeur)
);