-- Création de la base
CREATE DATABASE IF NOT EXISTS hotel2025;
USE hotel2025;

-- Table Hotel
CREATE TABLE Hotel (
    id INT PRIMARY KEY,
    ville VARCHAR(100),
    pays VARCHAR(100),
    code_postal INT
);

-- Table Client
CREATE TABLE Client (
    id INT PRIMARY KEY,
    adresse VARCHAR(200),
    ville VARCHAR(100),
    code_postal INT,
    email VARCHAR(100),
    telephone VARCHAR(20),
    nom VARCHAR(100)
);

-- Table Prestation
CREATE TABLE Prestation (
    id INT PRIMARY KEY,
    prix DECIMAL(10,2),
    libelle VARCHAR(100)
);

-- Table TypeChambre
CREATE TABLE TypeChambre (
    id INT PRIMARY KEY,
    type VARCHAR(50),
    prix DECIMAL(10,2)
);

-- Table Chambre
CREATE TABLE Chambre (
    id INT PRIMARY KEY,
    numero INT,
    etage INT,
    balcon BOOLEAN,
    type_id INT,
    hotel_id INT,
    FOREIGN KEY (type_id) REFERENCES TypeChambre(id),
    FOREIGN KEY (hotel_id) REFERENCES Hotel(id)
);

-- Table Reservation
CREATE TABLE Reservation (
    id INT PRIMARY KEY,
    date_debut DATE,
    date_fin DATE,
    client_id INT,
    chambre_id INT,
    FOREIGN KEY (client_id) REFERENCES Client(id),
    FOREIGN KEY (chambre_id) REFERENCES Chambre(id)
);

-- Table Evaluation
CREATE TABLE Evaluation (
    id INT PRIMARY KEY,
    date_evaluation DATE,
    note INT,
    commentaire TEXT,
    reservation_id INT,
    FOREIGN KEY (reservation_id) REFERENCES Reservation(id)
);

-- Insertion des données
INSERT INTO Hotel VALUES
(1, 'Paris', 'France', 75001),
(2, 'Lyon', 'France', 69002);

INSERT INTO Client VALUES
(1, '12 Rue de Paris', 'Paris', 75001, 'jean.dupont@email.fr', '0612345678', 'Jean Dupont'),
(2, '5 Avenue Victor Hugo', 'Lyon', 69002, 'marie.leroy@email.fr', '0623456789', 'Marie Leroy'),
(3, '8 Boulevard Saint-Michel', 'Marseille', 13005, 'paul.moreau@email.fr', '0634567890', 'Paul Moreau'),
(4, '27 Rue Nationale', 'Lille', 59800, 'lucie.martin@email.fr', '0645678901', 'Lucie Martin'),
(5, '3 Rue des Fleurs', 'Nice', 06000, 'emma.giraud@email.fr', '0656789012', 'Emma Giraud');

-- (tu continueras avec Prestation, TypeChambre, Chambre, Reservation, Evaluation)
