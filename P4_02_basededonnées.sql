-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3308
-- Généré le :  mer. 22 avr. 2020 à 17:01
-- Version du serveur :  8.0.18
-- Version de PHP :  7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `mydb`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `idadresse` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) DEFAULT NULL,
  `rue` varchar(45) DEFAULT NULL,
  `codePostal` int(11) DEFAULT NULL,
  `ville` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idadresse`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `adresse`
--

INSERT INTO `adresse` (`idadresse`, `numero`, `rue`, `codePostal`, `ville`) VALUES
(1, 9, 'avenue de la republique', 69005, 'Lyon'),
(2, 17, 'rue des soeurs', 69009, 'Lyon'),
(3, 45, 'rue des frères lumière', 69001, 'Lyon'),
(4, 12, 'avenue de la charité', 69160, 'Tassin'),
(5, 60, 'boulevard des capucines', 69002, 'Lyon'),
(6, 85, 'rue des ages', 69005, 'Lyon');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `idcommande` int(11) NOT NULL AUTO_INCREMENT,
  `utilisateur_idclient` int(11) NOT NULL,
  `utilisateur_idlivreur` int(11) NOT NULL,
  `adresse_idadresse` int(11) NOT NULL,
  `statut` enum('paiement en attente','payée','en cours de livraison','livrée') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `date` datetime NOT NULL,
  `montant_TTC` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcommande`,`adresse_idadresse`,`utilisateur_idclient`,`utilisateur_idlivreur`),
  UNIQUE KEY `idcommande_UNIQUE` (`idcommande`),
  KEY `fk_commande_utilisateur1_idx` (`utilisateur_idclient`),
  KEY `fk_commande_utilisateur2_idx` (`utilisateur_idlivreur`),
  KEY `fk_commande_adresse1_idx` (`adresse_idadresse`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`idcommande`, `utilisateur_idclient`, `utilisateur_idlivreur`, `adresse_idadresse`, `statut`, `date`, `montant_TTC`) VALUES
(1, 1, 2, 1, 'livrée', '2020-04-09 00:00:00', 15),
(2, 5, 2, 2, 'livrée', '2020-04-08 20:00:00', 15),
(4, 1, 2, 2, 'paiement en attente', '2020-04-21 11:00:00', 18);

-- --------------------------------------------------------

--
-- Structure de la table `plat`
--

DROP TABLE IF EXISTS `plat`;
CREATE TABLE IF NOT EXISTS `plat` (
  `idplat` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `type` enum('plat','dessert') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `photo` varchar(45) DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `prix` int(11) DEFAULT NULL,
  `plat_du_jour` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idplat`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`idplat`, `nom`, `description`, `type`, `photo`, `date_creation`, `prix`, `plat_du_jour`) VALUES
(1, 'Gratin Dauphinois', 'Le gratin dauphinois ou pommes de terre à la dauphinoise est un plat gratiné traditionnel de la cuisine française, d\'origine dauphinoise, à base de pommes de terre et de lait.', 'plat', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQ', '2020-04-09 09:00:00', 6, 1),
(2, 'Roti de boeuf et ses tagliatelles.', 'Roti de boeuf accompagné de ses tagliatelles aux oeufs frais.', 'plat', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQ', '2020-04-09 14:00:00', 6, 1),
(3, 'Tarte aux pralines', 'La tarte aux pralines ou tarte à la praline est un dessert de type tarte, spécialité culinaire lyonnaise qui utilise la praline comme ingrédient central.', 'dessert', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQ', '2020-04-09 09:00:00', 3, 1),
(4, 'Compote de pommes', 'Une compote de pomme est une purée de fruits composée de pommes cuites ou fraiches et éventuellement d\'un peu de sucre ou de cannelle.', 'dessert', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQ', '2020-04-10 10:00:00', 3, 1),
(5, 'Steack frites', 'Steack haché accompagné de ses frites fraiches.', 'plat', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQ', '2020-04-11 09:00:00', 5, 0),
(6, 'Eclair au chosolat', 'Une pâtisserie que tout le monde aime', 'dessert', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQ', '2020-04-11 09:00:00', 3, 0);

-- --------------------------------------------------------

--
-- Structure de la table `plat_commande`
--

DROP TABLE IF EXISTS `plat_commande`;
CREATE TABLE IF NOT EXISTS `plat_commande` (
  `commande_idcommande` int(11) NOT NULL,
  `plat_idplat` int(11) NOT NULL,
  `quantité` int(11) DEFAULT NULL,
  `prix` int(11) DEFAULT NULL,
  PRIMARY KEY (`commande_idcommande`,`plat_idplat`),
  KEY `fk_plat_commande_plat1_idx` (`plat_idplat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plat_commande`
--

INSERT INTO `plat_commande` (`commande_idcommande`, `plat_idplat`, `quantité`, `prix`) VALUES
(1, 1, 2, 12),
(1, 3, 1, 3),
(2, 2, 1, 6),
(2, 3, 3, 9),
(4, 5, 3, 15);

-- --------------------------------------------------------

--
-- Structure de la table `statut_livreur`
--

DROP TABLE IF EXISTS `statut_livreur`;
CREATE TABLE IF NOT EXISTS `statut_livreur` (
  `utilisateur_idutilisateur` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `statut` enum('disponible','en cours de livraison','indisponible') DEFAULT NULL,
  PRIMARY KEY (`utilisateur_idutilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `statut_livreur`
--

INSERT INTO `statut_livreur` (`utilisateur_idutilisateur`, `date`, `latitude`, `longitude`, `statut`) VALUES
(2, '2020-04-09 08:48:17', '45.765946', '4.827627', 'en cours de livraison'),
(7, '2020-04-10 13:14:07', '45.767591', '4.836737', 'disponible');

-- --------------------------------------------------------

--
-- Structure de la table `stock_livreur`
--

DROP TABLE IF EXISTS `stock_livreur`;
CREATE TABLE IF NOT EXISTS `stock_livreur` (
  `utilisateur_idutilisateur` int(11) NOT NULL,
  `plat_idplat` int(11) NOT NULL,
  `quantité` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`utilisateur_idutilisateur`,`plat_idplat`),
  KEY `fk_stock_livreur_utilisateur1_idx` (`utilisateur_idutilisateur`),
  KEY `fk_stock_livreur_plat1` (`plat_idplat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `stock_livreur`
--

INSERT INTO `stock_livreur` (`utilisateur_idutilisateur`, `plat_idplat`, `quantité`, `date`) VALUES
(2, 1, 3, '2020-04-09 08:00:00'),
(2, 2, 4, '2020-04-09 08:00:00'),
(2, 3, 5, '2020-04-09 08:00:00'),
(2, 4, 4, '2020-04-09 08:00:00'),
(7, 1, 4, '2020-04-09 08:00:00'),
(7, 2, 2, '2020-04-09 08:00:00'),
(7, 3, 4, '2020-04-09 08:00:00'),
(7, 4, 3, '2020-04-09 10:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `idutilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `password` varchar(45) NOT NULL,
  `type` enum('client','livreur','chef','administrateur') NOT NULL,
  `date_inscription` datetime NOT NULL,
  PRIMARY KEY (`idutilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idutilisateur`, `nom`, `prenom`, `mail`, `telephone`, `password`, `type`, `date_inscription`) VALUES
(1, 'Patrick', 'Henri', 'patrick.henri@mail.com', '0606060606', '$2y$12$NZFJPkIAh3UhG6VsZryPgeQvmJ0UDjzvj.Q19A', 'client', '2020-04-12 08:00:00'),
(2, 'Philippe', 'Martin', 'philippe.martin@mail.com', '0601020304', '$2y$12$f2/CrC1cDi6r5Nc8Qo1xU.Y//dqEuCU/u1fIYl', 'livreur', '2020-04-12 08:00:00'),
(3, 'Michel', 'Francois', 'michel.francois@mail.com', '0601010101', '$2y$12$rrKl7belqWQlFaVl0hnXS.2xN5gh4egAmAx/LN', 'chef', '2020-04-12 08:00:00'),
(4, 'Mathieu', 'Grand', 'mathieu.grand@mail.com', '0602020202', '$2y$12$veqk72AKN5e3FoNvQ.Ab2ugRMvi.0Kz7k/ZaFD', 'client', '2020-04-12 08:00:00'),
(5, 'Clotilde', 'Franc', 'clotilde.franc@mail.com', '0612121212', '$2y$12$6LHcKY5r5t4HhyfjmGMGeeOTWocaTyTMUQ.EhR', 'client', '2020-04-12 08:00:00'),
(6, 'Eric', 'Maboul', 'eric.maboul@mail.com', '0654455445', '$2y$12$dQ4S/imEkbmvk7/sBsOs9.GBIoQWdq4GRgu1ZN', 'administrateur', '2020-04-12 08:00:00'),
(7, 'Jo', 'Manitou', 'jo.manitou@mail.com', '0652525252', '$2y$12$fI/px1pIHHuqdKWe9UNfa.O9AMnwM/ijSmoG7n', 'livreur', '2020-04-12 08:00:00'),
(8, 'martin', 'luc', 'luc@mail.com', '0615151515', '$2y$12$6LHcKY5r5t4HhyfjmGMGeeOTWocaTyTMUQ.EhR', 'chef', '2020-04-21 11:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur_has_adresse`
--

DROP TABLE IF EXISTS `utilisateur_has_adresse`;
CREATE TABLE IF NOT EXISTS `utilisateur_has_adresse` (
  `utilisateur_idutilisateur` int(11) NOT NULL,
  `adresse_idadresse` int(11) NOT NULL,
  PRIMARY KEY (`utilisateur_idutilisateur`,`adresse_idadresse`),
  KEY `fk_utilisateur_has_adresse_adresse1_idx` (`adresse_idadresse`),
  KEY `fk_utilisateur_has_adresse_utilisateur_idx` (`utilisateur_idutilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur_has_adresse`
--

INSERT INTO `utilisateur_has_adresse` (`utilisateur_idutilisateur`, `adresse_idadresse`) VALUES
(1, 1),
(1, 2),
(4, 3),
(4, 4),
(5, 5);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `fk_commande_adresse1` FOREIGN KEY (`adresse_idadresse`) REFERENCES `adresse` (`idadresse`),
  ADD CONSTRAINT `fk_commande_utilisateur1` FOREIGN KEY (`utilisateur_idclient`) REFERENCES `utilisateur` (`idutilisateur`),
  ADD CONSTRAINT `fk_commande_utilisateur2` FOREIGN KEY (`utilisateur_idlivreur`) REFERENCES `utilisateur` (`idutilisateur`);

--
-- Contraintes pour la table `plat_commande`
--
ALTER TABLE `plat_commande`
  ADD CONSTRAINT `fk_plat_commande_commande1` FOREIGN KEY (`commande_idcommande`) REFERENCES `commande` (`idcommande`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_plat_commande_plat1` FOREIGN KEY (`plat_idplat`) REFERENCES `plat` (`idplat`);

--
-- Contraintes pour la table `statut_livreur`
--
ALTER TABLE `statut_livreur`
  ADD CONSTRAINT `fk_statut_livreur_utilisateur1` FOREIGN KEY (`utilisateur_idutilisateur`) REFERENCES `utilisateur` (`idutilisateur`);

--
-- Contraintes pour la table `stock_livreur`
--
ALTER TABLE `stock_livreur`
  ADD CONSTRAINT `fk_stock_livreur_plat1` FOREIGN KEY (`plat_idplat`) REFERENCES `plat` (`idplat`),
  ADD CONSTRAINT `fk_stock_livreur_utilisateur1` FOREIGN KEY (`utilisateur_idutilisateur`) REFERENCES `utilisateur` (`idutilisateur`);

--
-- Contraintes pour la table `utilisateur_has_adresse`
--
ALTER TABLE `utilisateur_has_adresse`
  ADD CONSTRAINT `fk_utilisateur_has_adresse_adresse1` FOREIGN KEY (`adresse_idadresse`) REFERENCES `adresse` (`idadresse`),
  ADD CONSTRAINT `fk_utilisateur_has_adresse_utilisateur` FOREIGN KEY (`utilisateur_idutilisateur`) REFERENCES `utilisateur` (`idutilisateur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
