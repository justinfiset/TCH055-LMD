
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
    CONSTRAINT PK_Cours PRIMARY KEY (sigle),
    
    -- Contrainte de sigle de cours, doit être constitué de 
    -- 3 lettres et de 3 chiffres (Exemple : TCH055)
    CONSTRAINT CH_Sigle CHECK (REGEXP_LIKE(sigle, '^[A-Z]{3}[0-9]{3}$'))
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
    date_fin DATE NOT NULL,
    
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
    CONSTRAINT FK_Sigle FOREIGN KEY (sigle) REFERENCES Cours
    ON DELETE CASCADE,
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



/*
Création de la table Etudiant
*/

DROP TABLE Etudiant CASCADE CONSTRAINT;
DROP TABLE Inscription CASCADE CONSTRAINT;


CREATE TABLE Etudiant(
    code_permanent VARCHAR2(12)  NOT NULL,
    nom            VARCHAR2(20)  NOT NULL,
    prenom         VARCHAR2(20)  NOT NULL,
    code_programme NUMBER(3)     NULL,
    --Contrainte ce clée primaire de la table Etudiant
    CONSTRAINT PK_Etudiant       PRIMARY KEY(code_permanent)
);

/*
Création de la table inscrition
*/
CREATE TABLE Inscription(
    code_permanent  VARCHAR2(12)   NOT NULL REFERENCES Etudiant(code_permanent),
    sigle           VARCHAR2(6)    NOT NULL REFERENCES CoursGroupe(sigle),
    no_groupe       NUMBER(2)      NOT NULL REFERENCES CoursGroupe(no_groupe),
    code_session    NUMBER(2)      NOT NULL REFERENCES CoursGroupe(code_session),
    date_inscrition DATE           NOT NULL,
    date_abandon    DATE           NULL,
    note            NUMBER(3)      NULL ,

    --Contraintes des clées primaires--
    CONSTRAINT PK_Inscription      PRIMARY KEY (code_permanent,sigle,no_groupe,code_session),
    --Contraintes des clées étrangères primaires venant de la table CoursGroupe--
    CONSTRAINT FK_CoursGroupe      FOREIGN KEY (sigle,no_groupe,code_session) 
    REFERENCES CoursGroupe(sigle,no_groupe,code_session) 
    ON DELETE CASCADE,
     --Contraintes des clées étrangères primaires venant de la table Etudiant--
    CONSTRAINT FR_Etudiant         FOREIGN KEY (code_permanent) 
    REFERENCES Etudiant(code_permanent)
    ON DELETE CASCADE
);