-- TCH055 - LABORATOIRE 1 PARTIE 2
-- SCRIPT DE CREATION DU MODELE PHYSIQUE DE DONNES
-- AUTEUR : JUSTIN FISET, AIMÉ MELANÇON, NIKOLA SUNJKA, JUSTIN LAVOIE-LADOUCEUR

DROP TABLE Etudiant     CASCADE CONSTRAINTS;
DROP TABLE Inscription  CASCADE CONSTRAINTS;
DROP TABLE Cours        CASCADE CONSTRAINTS;
DROP TABLE Prealable    CASCADE CONSTRAINTS;
DROP TABLE SessionETS   CASCADE CONSTRAINTS;
DROP TABLE CoursGroupe  CASCADE CONSTRAINTS;
DROP TABLE Professeur   CASCADE CONSTRAINTS;

----------------------------------------------
---- Creation de la table Cours
----------------------------------------------
CREATE TABLE Cours (
    sigle       VARCHAR2(6)  NOT NULL,
    titre       VARCHAR2(50) NOT NULL,
    nb_credits  NUMBER(2)    NOT NULL,
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_C_Cours PRIMARY KEY (sigle),
    
    -- Contrainte de sigle de cours, doit être constitué de 
    -- 3 lettres et de 3 chiffres (Exemple : TCH055)
    CONSTRAINT CH_C_Sigle CHECK (REGEXP_LIKE(sigle, '^[A-Z]{3}[0-9]{3}$'))
);

----------------------------------------------
---- Creation de la table Prealable
----------------------------------------------
CREATE TABLE Prealable (
    sigle           VARCHAR2(6),
    sigle_prealable VARCHAR(6),
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_P_Prealable PRIMARY KEY (sigle, sigle_prealable),
    
    -- Contrainte de clé étrangère
    CONSTRAINT FK_P_Sigle           FOREIGN KEY (sigle)           REFERENCES Cours
    ON DELETE CASCADE,
    CONSTRAINT FK_P_SiglePrealable  FOREIGN KEY (sigle_prealable) REFERENCES Cours
    ON DELETE CASCADE
);

----------------------------------------------
---- Creation de la table SessionETS
----------------------------------------------
CREATE TABLE SessionETS (
    code_session    NUMBER(2)   NOT NULL,
    date_debut      DATE        NOT NULL,
    date_fin        DATE        NOT NULL,
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_SessionETS PRIMARY KEY (code_session)
);
----------------------------------------------
---- Creation de la table Professeur
----------------------------------------------
CREATE TABLE Professeur (
    code_professeur VARCHAR2(5)  NOT NULL,
    nom             VARCHAR2(20) NOT NULL,
    prenom          VARCHAR2(20) NOT NULL,
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_P_CodeProfesseur PRIMARY KEY (code_professeur)
);

----------------------------------------------
---- Creation de la table CoursGroupe
----------------------------------------------
CREATE TABLE CoursGroupe (
    sigle            VARCHAR2(6) NOT NULL,
    no_groupe        NUMBER(2)   NOT NULL,
    code_session     NUMBER(2)   NOT NULL,
    max_inscriptions NUMBER(3)  NOT NULL,
    code_professeur  VARCHAR2(5) NOT NULL,
    
    -- Contrainte de clé primaire
    CONSTRAINT PK_CoursGroupe PRIMARY KEY (sigle, no_groupe, code_session),
    
    -- Contrainte de clé étrangère
    CONSTRAINT FK_CG_Sigle          FOREIGN KEY (sigle)           REFERENCES Cours
    ON DELETE CASCADE,
    CONSTRAINT FK_CG_CodeSession    FOREIGN KEY (code_session)    REFERENCES SessionETS
    ON DELETE CASCADE,
    CONSTRAINT FK_CG_CodeProfesseur FOREIGN KEY (code_professeur) REFERENCES Professeur
);

----------------------------------------------
---- Création de la table Etudiant
----------------------------------------------
CREATE TABLE Etudiant(
    code_permanent VARCHAR2(12)  NOT NULL,
    nom            VARCHAR2(20)  NOT NULL,
    prenom         VARCHAR2(20)  NOT NULL,
    code_programme NUMBER(3)     NULL,
    --Contrainte ce clée primaire de la table Etudiant
    CONSTRAINT PK_E_Etudiant       PRIMARY KEY(code_permanent)
);

----------------------------------------------
---- Création de la table inscription
----------------------------------------------
CREATE TABLE Inscription(
    code_permanent  VARCHAR2(12)   NOT NULL,
    sigle           VARCHAR2(6)    NOT NULL,
    no_groupe       NUMBER(2)      NOT NULL,
    code_session    NUMBER(2)      NOT NULL,
    date_inscription DATE           NOT NULL,
    date_abandon    DATE           NULL,
    note            NUMBER(3)      NULL ,

    --Contraintes des clées primaires--
    CONSTRAINT PK_Inscription        PRIMARY KEY (code_permanent,sigle,no_groupe,code_session),
    --Contraintes des clées étrangères primaires venant de la table CoursGroupe--
    CONSTRAINT FK_I_CoursGroupe      FOREIGN KEY (sigle,no_groupe,code_session) 
    REFERENCES CoursGroupe(sigle,no_groupe,code_session) 
    ON DELETE CASCADE,
     --Contraintes des clées étrangères primaires venant de la table Etudiant--
    CONSTRAINT FR_I_Etudiant         FOREIGN KEY (code_permanent) 
    REFERENCES Etudiant(code_permanent)
    ON DELETE CASCADE
);