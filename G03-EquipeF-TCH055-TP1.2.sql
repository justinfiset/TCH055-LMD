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
    CONSTRAINT PK_Etudiant       PRIMARY KEY(code_permanent)
);


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