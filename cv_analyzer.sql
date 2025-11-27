-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 27 nov. 2025 à 20:20
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `cv_analyzer`
--

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cv_analyses`
--

CREATE TABLE `cv_analyses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cv_upload_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `overall_score` int(11) NOT NULL,
  `section_scores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`section_scores`)),
  `summary` text NOT NULL,
  `recommendations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`recommendations`)),
  `strengths` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`strengths`)),
  `weaknesses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`weaknesses`)),
  `extracted_text` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cv_analyses`
--

INSERT INTO `cv_analyses` (`id`, `cv_upload_id`, `user_id`, `overall_score`, `section_scores`, `summary`, `recommendations`, `strengths`, `weaknesses`, `extracted_text`, `created_at`, `updated_at`) VALUES
(1, 27, 3, 85, '{\"presentation\":90,\"experience\":80,\"formation\":95,\"competences\":90,\"coherence\":85}', 'Ce CV présente un candidat motivé et polyvalent avec une solide formation en ingénierie informatique et analyse de données. Il a une expérience pratique en développement full-stack, IoT et systèmes embarqués, ainsi que des compétences en data science et intelligence artificielle.', '[{\"category\":\"Pr\\u00e9sentation\",\"priority\":\"moyenne\",\"suggestion\":\"Ajouter un r\\u00e9sum\\u00e9 professionnel plus d\\u00e9taill\\u00e9 et des objectifs de carri\\u00e8re clairs\"},{\"category\":\"Exp\\u00e9rience\",\"priority\":\"haute\",\"suggestion\":\"D\\u00e9tailler les exp\\u00e9riences professionnelles avec des r\\u00e9sultats concrets et des r\\u00e9alisations sp\\u00e9cifiques\"},{\"category\":\"Comp\\u00e9tences\",\"priority\":\"basse\",\"suggestion\":\"Mettre \\u00e0 jour les comp\\u00e9tences techniques avec les derni\\u00e8res technologies et outils\"}]', '[\"Formation solide en ing\\u00e9nierie informatique et analyse de donn\\u00e9es\",\"Exp\\u00e9rience pratique en d\\u00e9veloppement full-stack et IoT\",\"Comp\\u00e9tences en data science et intelligence artificielle\"]', '[\"Manque d\'exp\\u00e9rience professionnelle prolong\\u00e9e\",\"Pas de mention de r\\u00e9sultats concrets ou de r\\u00e9alisations sp\\u00e9cifiques\",\"Certifications limit\\u00e9es\"]', 'SERSIF Développeur Full-Stack | Ingénieur Logiciel | IoT & Systèmes Embarqués El Jadida, Maroc I # Profil Professionnel Étudiant en Master 2 Ingénierie Informatique et Analyse de Données, à la recherche d’un stage PFE pour approfondir mes compétences en développement full-stack,Intelligence artificielle,Analyse de données, IoT et systèmes embarqués. Développeur passionné avec une expérience pratique en applications web/mobile, solutions IoT pour l’agriculture de précision et optimisation de processus industriels. Motivé, rigoureux et prêt à contribuer activement aux projets innovants de l’entreprise. Éducation 2024 – En cours Master en Ingénierie Informatique et Analyse de Données,, El Jadida, Maroc Spécialisation en analyse de données, Big Data, Architecture logicielle. Projets recherche IA appliquée. 2020 – 2024,, El Jadida, Maroc Formation algorithmes, structures données, statistiques. Projets développement logiciel. Expériences Professionnelles Août 2025 – Octobre 2025 Data Scientist / Ingénieur Processus,, Maroc — — — — Janvier 2024 – Avril 2024 Développeur Full-Stack,, Maroc — — — Projets Techniques Majeurs Système IoT Agriculture de Précision, — — Chatbot Scientifique Intelligent, — — Marketplace Revent Ticket, — — Compétences Techniques et Personnelles Technologies et Outils Langages de Programmation HTML, CSS, Python, Java EE, JavaScript, C, PHP, SQL Développement Web & Mobile React.js, Angular, Next.js, React Native, Node.js, Express.js, API RESTful Data Science & Deep Learning Pandas, NumPy, Scikit-learn, OpenCV, TensorFlow, Keras, PyTorch, RNN, LLM Bases de Données MySQL, Oracle, MongoDB IoT & DevOps Arduino, ESP32, capteurs/actionneurs, Docker, Kubernetes, CI/CD, Git/GitHub, Linux, Postman, Jira Compétences Personnelles Méthodologies Agile/Scrum, DevOps Soft Skills Résolution problèmes complexes, communication tech- nique, leadership projet Langues Arabe Français Anglais Certifications Introduction à l’IA Science des Données', '2025-11-26 17:41:40', '2025-11-26 17:41:40'),
(2, 28, 3, 85, '{\"presentation\":90,\"experience\":80,\"formation\":95,\"competences\":90,\"coherence\":85}', 'Le CV est bien structuré et présente une bonne cohérence entre les différentes sections. Le candidat a une solide formation en ingénierie informatique et analyse de données, ainsi que des expériences professionnelles pertinentes.', '[{\"category\":\"Pr\\u00e9sentation\",\"priority\":\"moyenne\",\"suggestion\":\"Ajouter une photo de profil et des liens vers des r\\u00e9seaux sociaux professionnels pour am\\u00e9liorer la pr\\u00e9sence en ligne\"},{\"category\":\"Exp\\u00e9rience\",\"priority\":\"haute\",\"suggestion\":\"Fournir des d\\u00e9tails sur les r\\u00e9sultats et les impacts des projets r\\u00e9alis\\u00e9s, ainsi que des r\\u00e9f\\u00e9rences de superviseurs ou de coll\\u00e8gues\"},{\"category\":\"Comp\\u00e9tences\",\"priority\":\"basse\",\"suggestion\":\"Explorer de nouvelles technologies et outils pour rester \\u00e0 jour avec les derni\\u00e8res tendances du march\\u00e9\"}]', '[\"Solide formation en ing\\u00e9nierie informatique et analyse de donn\\u00e9es\",\"Exp\\u00e9riences professionnelles pertinentes en d\\u00e9veloppement full-stack et data science\",\"Bonnes comp\\u00e9tences techniques et personnelles, notamment en r\\u00e9solution de probl\\u00e8mes complexes et communication technique\"]', '[\"Manque d\'exp\\u00e9rience dans des projets \\u00e0 grande \\u00e9chelle\",\"Pas d\'informations d\\u00e9taill\\u00e9es sur les r\\u00e9sultats et les impacts des projets r\\u00e9alis\\u00e9s\",\"Pas de certifications professionnelles avanc\\u00e9es\"]', 'SERSIF Développeur Full-Stack | Ingénieur Logiciel | IoT & Systèmes Embarqués El Jadida, Maroc I # Profil Professionnel Étudiant en Master 2 Ingénierie Informatique et Analyse de Données, à la recherche d’un stage PFE pour approfondir mes compétences en développement full-stack,Intelligence artificielle,Analyse de données, IoT et systèmes embarqués. Développeur passionné avec une expérience pratique en applications web/mobile, solutions IoT pour l’agriculture de précision et optimisation de processus industriels. Motivé, rigoureux et prêt à contribuer activement aux projets innovants de l’entreprise. Éducation 2024 – En cours Master en Ingénierie Informatique et Analyse de Données,, El Jadida, Maroc Spécialisation en analyse de données, Big Data, Architecture logicielle. Projets recherche IA appliquée. 2020 – 2024,, El Jadida, Maroc Formation algorithmes, structures données, statistiques. Projets développement logiciel. Expériences Professionnelles Août 2025 – Octobre 2025 Data Scientist / Ingénieur Processus,, Maroc — — — — Janvier 2024 – Avril 2024 Développeur Full-Stack,, Maroc — — — Projets Techniques Majeurs Système IoT Agriculture de Précision, — — Chatbot Scientifique Intelligent, — — Marketplace Revent Ticket, — — Compétences Techniques et Personnelles Technologies et Outils Langages de Programmation HTML, CSS, Python, Java EE, JavaScript, C, PHP, SQL Développement Web & Mobile React.js, Angular, Next.js, React Native, Node.js, Express.js, API RESTful Data Science & Deep Learning Pandas, NumPy, Scikit-learn, OpenCV, TensorFlow, Keras, PyTorch, RNN, LLM Bases de Données MySQL, Oracle, MongoDB IoT & DevOps Arduino, ESP32, capteurs/actionneurs, Docker, Kubernetes, CI/CD, Git/GitHub, Linux, Postman, Jira Compétences Personnelles Méthodologies Agile/Scrum, DevOps Soft Skills Résolution problèmes complexes, communication tech- nique, leadership projet Langues Arabe Français Anglais Certifications Introduction à l’IA Science des Données', '2025-11-26 17:56:01', '2025-11-26 17:56:01'),
(3, 33, 3, 85, '{\"presentation\":90,\"experience\":80,\"formation\":95,\"competences\":90,\"coherence\":85}', 'Ce CV présente un profil de développeur full-stack avec une expérience variée et une formation solide en ingénierie informatique et analyse de données. Les compétences techniques sont nombreuses et pertinentes, mais il serait utile de préciser les réalisations concrètes et les résultats obtenus dans les expériences professionnelles.', '[{\"category\":\"Pr\\u00e9sentation\",\"priority\":\"haute\",\"suggestion\":\"Ajouter une photo de profil professionnelle et une br\\u00e8ve introduction personnelle pour rendre le CV plus attractif\"},{\"category\":\"Exp\\u00e9rience\",\"priority\":\"moyenne\",\"suggestion\":\"Pr\\u00e9ciser les r\\u00e9alisations concr\\u00e8tes et les r\\u00e9sultats obtenus dans les exp\\u00e9riences professionnelles, ainsi que les technologies utilis\\u00e9es et les d\\u00e9fis rencontr\\u00e9s\"},{\"category\":\"Comp\\u00e9tences\",\"priority\":\"basse\",\"suggestion\":\"Revoir les comp\\u00e9tences techniques pour les mettre \\u00e0 jour et les rendre plus sp\\u00e9cifiques, et ajouter des certifications ou des formations compl\\u00e9mentaires pour renforcer le profil\"}]', '[\"Formation solide en ing\\u00e9nierie informatique et analyse de donn\\u00e9es\",\"Exp\\u00e9rience vari\\u00e9e en d\\u00e9veloppement full-stack et IoT\",\"Comp\\u00e9tences techniques nombreuses et pertinentes\"]', '[\"Manque de d\\u00e9tails sur les r\\u00e9alisations concr\\u00e8tes et les r\\u00e9sultats obtenus dans les exp\\u00e9riences professionnelles\",\"Pas de mention de projets personnels ou de contributions open-source\",\"Certifications limit\\u00e9es, il serait utile d\'en ajouter d\'autres pour renforcer le profil\"]', 'SERSIF Développeur Full-Stack | Ingénieur Logiciel | IoT & Systèmes Embarqués El Jadida, Maroc I # Profil Professionnel Étudiant en Master 2 Ingénierie Informatique et Analyse de Données, à la recherche d’un stage PFE pour approfondir mes compétences en développement full-stack,Intelligence artificielle,Analyse de données, IoT et systèmes embarqués. Développeur passionné avec une expérience pratique en applications web/mobile, solutions IoT pour l’agriculture de précision et optimisation de processus industriels. Motivé, rigoureux et prêt à contribuer activement aux projets innovants de l’entreprise. Éducation 2024 – En cours Master en Ingénierie Informatique et Analyse de Données,, El Jadida, Maroc Spécialisation en analyse de données, Big Data, Architecture logicielle. Projets recherche IA appliquée. 2020 – 2024,, El Jadida, Maroc Formation algorithmes, structures données, statistiques. Projets développement logiciel. Expériences Professionnelles Août 2025 – Octobre 2025 Data Scientist / Ingénieur Processus,, Maroc — — — — Janvier 2024 – Avril 2024 Développeur Full-Stack,, Maroc — — — Projets Techniques Majeurs Système IoT Agriculture de Précision, — — Chatbot Scientifique Intelligent, — — Marketplace Revent Ticket, — — Compétences Techniques et Personnelles Technologies et Outils Langages de Programmation HTML, CSS, Python, Java EE, JavaScript, C, PHP, SQL Développement Web & Mobile React.js, Angular, Next.js, React Native, Node.js, Express.js, API RESTful Data Science & Deep Learning Pandas, NumPy, Scikit-learn, OpenCV, TensorFlow, Keras, PyTorch, RNN, LLM Bases de Données MySQL, Oracle, MongoDB IoT & DevOps Arduino, ESP32, capteurs/actionneurs, Docker, Kubernetes, CI/CD, Git/GitHub, Linux, Postman, Jira Compétences Personnelles Méthodologies Agile/Scrum, DevOps Soft Skills Résolution problèmes complexes, communication tech- nique, leadership projet Langues Arabe Français Anglais Certifications Introduction à l’IA Science des Données', '2025-11-26 17:58:48', '2025-11-26 17:58:48'),
(4, 35, 3, 70, '{\"presentation\":60,\"experience\":80,\"formation\":90,\"competences\":70,\"coherence\":80}', 'Le CV de NOUHAILA CHAHMI présente une bonne cohérence et une expérience professionnelle solide, mais nécessite une amélioration de la présentation et une mise en avant des compétences techniques.', '[{\"category\":\"Pr\\u00e9sentation\",\"priority\":\"haute\",\"suggestion\":\"Ajouter une photo de profil professionnelle et am\\u00e9liorer la mise en page du CV pour le rendre plus attractif\"},{\"category\":\"Exp\\u00e9rience\",\"priority\":\"moyenne\",\"suggestion\":\"D\\u00e9tailler les responsabilit\\u00e9s et les r\\u00e9alisations dans les exp\\u00e9riences professionnelles pour montrer l\'impact sur les projets\"},{\"category\":\"Comp\\u00e9tences\",\"priority\":\"basse\",\"suggestion\":\"Lister les comp\\u00e9tences techniques de mani\\u00e8re plus d\\u00e9taill\\u00e9e et pr\\u00e9cise pour montrer les capacit\\u00e9s du candidat\"}]', '[\"Exp\\u00e9rience professionnelle vari\\u00e9e\",\"Formation acad\\u00e9mique solide\",\"Comp\\u00e9tences en d\\u00e9veloppement web et gestion de bases de donn\\u00e9es\"]', '[\"Pr\\u00e9sentation peu attractive\",\"Manque de d\\u00e9tails sur les comp\\u00e9tences techniques\",\"Pas d\'informations sur les r\\u00e9alisations personnelles\"]', 'Photo\nNOUHAILA CHAHMI\nDÉVELOPPEUSE WEB / RECHERCHE D’UN STAGE PFE\n#\n*\nÉtudiante de 23 ans originaire d’El Gharbia, je suis actuellement en Master en Ingénierie Informatique et Analyse\nde Données. J’ai acquis de solides bases en développement et en gestion de bases de données. Curieuse et motivée,\nje cherche à renforcer mes compétences à travers des expériences professionnelles concrètes.\nEXPÉRIENCES PROFESSIONNELLES\nStage - Nextronic ABA Technologie\nProjet : Détection automatique des plaques métalliques à l’aide de l’IA\n—\nplaques métalliques\nRecensement général de la population et de l’habitat\n2024\n—\n—\nd’équipe\nPROJETS ET RÉALISATIONS\nChatbot de Recherche Scientifique\n—\ntifiques\n—\nbase de données scientifique\nProjet LoadLifter (Robotique)\nquée\n—\nchariot autonome\nSite web CHU El Jadida\ntion\n—\n—\nApplication mobile de gestion des livres\npress, MySQL\n—\n—\nPARCOURS ACADÉMIQUE\nMaster spécialisé en Ingénierie Informatique et Analyse des Don-\nnées\nFaculté des Sciences d’El Jadida\nLicence fondamentale en Sciences Mathématiques et Informa-\ntiques\nFaculté des Sciences d’El Jadida\nCOMPÉTENCES\nSoft Skills\n—\n—\n—\n—\nTECHNOLOGIES\n?\n—\n—\n—\nj\nLearning\n—\n—\n?\n—\n—\nˆ\n—\n—\n—\n{\n—\n—\n—\n—\nLANGUES\n—\n—\n—', '2025-11-26 18:06:37', '2025-11-26 18:06:37'),
(5, 36, 3, 85, '{\"presentation\":80,\"experience\":90,\"formation\":95,\"competences\":95,\"coherence\":85}', 'Le CV présente un candidat très qualifié avec une expérience solide en développement logiciel, data science et intelligence artificielle. Les compétences techniques sont très variées et adaptées aux besoins actuels du marché. Cependant, la présentation pourrait être améliorée pour mettre en avant les réalisations et les compétences de manière plus claire.', '[{\"category\":\"Pr\\u00e9sentation\",\"priority\":\"haute\",\"suggestion\":\"R\\u00e9organiser la pr\\u00e9sentation pour mettre en avant les comp\\u00e9tences et les r\\u00e9alisations de mani\\u00e8re plus claire et concise\"},{\"category\":\"Exp\\u00e9rience\",\"priority\":\"moyenne\",\"suggestion\":\"Ajouter plus de d\\u00e9tails sur les projets men\\u00e9s \\u00e0 bien et les r\\u00e9alisations obtenues pour donner une meilleure id\\u00e9e de l\'exp\\u00e9rience et des comp\\u00e9tences du candidat\"},{\"category\":\"Comp\\u00e9tences\",\"priority\":\"basse\",\"suggestion\":\"Ajouter des informations sur les comp\\u00e9tences transversales telles que la gestion de projet, la communication et la r\\u00e9solution de probl\\u00e8mes pour donner une image plus compl\\u00e8te du candidat\"}]', '[\"Exp\\u00e9rience confirm\\u00e9e en d\\u00e9veloppement logiciel et data science\",\"Comp\\u00e9tences techniques tr\\u00e8s vari\\u00e9es et adapt\\u00e9es aux besoins actuels du march\\u00e9\",\"Formation acad\\u00e9mique solide en ing\\u00e9nierie informatique et analyse de donn\\u00e9es\"]', '[\"Pr\\u00e9sentation un peu d\\u00e9sorganis\\u00e9e et difficile \\u00e0 suivre\",\"Manque de d\\u00e9tails sur les r\\u00e9alisations et les projets men\\u00e9s \\u00e0 bien\",\"Pas enough d\'informations sur les comp\\u00e9tences transversales telles que la gestion de projet et la communication\"]', 'SERSIF ABDELJALIL\nIngénieur Logiciel\n#\nProfil Professionnel\nIngénieur logiciel passionné par laintelligence artificielle, avec une solide expertise en\nfull-stack. Expérience confirmée en. À la recherche\nd’opportunités stimulantes en data science, transformation digitale et innovation technologique.\nCompétences Techniques\nLangages de Programmation\nPythonJava EEJavaScriptCPHPSQL\nDéveloppement Web & Mobile\nReact.jsAngularNext.jsReact NativeNode.jsExpress.jsREST API\nData Science & ML\nPandasNumPyScikit-learnOpenCV\nDeep Learning\nTensorFlowKerasPyTorchRNNLLM\nBases de Données\nMySQLOracleMongoDB\nIoT & Systèmes Embarqués\nArduinoESP32Capteurs\nDevOps & Outils\nDockerKubernetesCI/CDGit/GitHubLinuxPostmanJiraExpérience Professionnelle\nData Scientist / Ingénieur Processus\nz\n—\nde l’efficacité opérationnelle\n—, identification de patterns critiques d’optimisation\n—\n—\nDéveloppeur Full-Stack\nz\n—\nReact Native)\n—\n—\nProjets Techniques Majeurs\nSystème IoT d’Agriculture de Précision\n—\n—\nChatbot Scientifique Intelligent\n—\n—\nMarketplace Revent Ticket\n—\n—\nFormation Académique\nMaster en Ingénierie Informatique et Analyse de Données\n?\nSpécialisation en,, et. Projets de recherche en IA appliquée.\nLicence en Mathématiques et Informatique\n?\nFormation solide en algorithmes, structures de données, et statistiques. Projets de développement logiciel.\nCertifications & Compétences Transversales\n?\nIntroduction à l’Intelligence Artificielle\nScience des Données et Analytics\n?\nAgile/Scrum, DevOps, Test-Driven Development\n`\nArabe\nFrançais\n?\nRésolution de problèmes complexes\nCommunication technique Leadership projet\n?', '2025-11-26 18:18:39', '2025-11-26 18:18:39'),
(6, 37, 3, 85, '{\"presentation\":80,\"experience\":90,\"formation\":95,\"competences\":85,\"coherence\":90}', 'Le CV présente un candidat expérimenté dans le domaine du développement logiciel et de l\'analyse de données, avec une solide formation académique et des compétences techniques variées. Cependant, certaines sections pourraient être améliorées pour une meilleure lisibilité et cohérence.', '[{\"category\":\"Pr\\u00e9sentation\",\"priority\":\"haute\",\"suggestion\":\"R\\u00e9organiser les sections pour une meilleure lisibilit\\u00e9 et ajouter des titres et des sous-titres pour faciliter la navigation\"},{\"category\":\"Exp\\u00e9rience\",\"priority\":\"moyenne\",\"suggestion\":\"Fournir plus de d\\u00e9tails sur les exp\\u00e9riences professionnelles, notamment les r\\u00e9alisations et les responsabilit\\u00e9s\"},{\"category\":\"Comp\\u00e9tences\",\"priority\":\"basse\",\"suggestion\":\"D\\u00e9tailler les certifications et les comp\\u00e9tences transversales pour montrer la polyvalence du candidat\"}]', '[\"Exp\\u00e9rience pertinente dans le domaine de l\'informatique et de l\'analyse de donn\\u00e9es\",\"Formation solide en ing\\u00e9nierie informatique et en analyse de donn\\u00e9es\",\"Comp\\u00e9tences techniques diversifi\\u00e9es, notamment en d\\u00e9veloppement full-stack et en intelligence artificielle\"]', '[\"Pr\\u00e9sentation des informations parfois d\\u00e9sorganis\\u00e9e\",\"Manque de d\\u00e9tails sur certains projets et exp\\u00e9riences professionnelles\",\"Certifications et comp\\u00e9tences transversales pourraient \\u00eatre plus d\\u00e9taill\\u00e9es\"]', 'SERSIF ABDELJALIL\nSoftware Engineer | Data Analyst | Full-Stack Developer\n#\nPROFESSIONAL PROFILE\nSoftware engineer specialized in data analysis and AI, with expertise in full-stack development and ML. Hands-on\nexperience in IoT and industrial process optimization. Seeking opportunities in data science and digital transformation.\nTECHNICAL SKILLS\nLanguages:\nWeb/Mobile:\nData Science:\nDatabases:\nIoT:\nDevOps:\nPROFESSIONAL EXPERIENCE\nData Scientist / Process Engineer | OCP/KOFERT (OCP Group)\nAugust 2025 - October 2025\n•\n•\n•\n•\nFull-Stack Developer | Iqra El Jadida Library\nJanuary 2024 - April 2024\n•\n•\n•\nMAJOR TECHNICAL PROJECTS\nPrecision Agriculture IoT System | C, Arduino, ESP32, IoT\n•\n•\n•\nIntelligent Scientific Chatbot | NLP, Python, Scopus API\n•\n•\nRevent Ticket Marketplace | Full-Stack, React, Node.js\n•\n•\nACADEMIC BACKGROUND\nMaster’s Degree in Computer Engineering and Data Analysis\nChouaib Doukkali University, El Jadida | 2024 - Ongoing\nSpecialization in data analysis, Big Data, software architecture. Applied AI research projects.\nBachelor’s Degree in Mathematics and Computer Science\nChouaib Doukkali University, El Jadida | 2020 - 2024\nTraining in algorithms, data structures, statistics. Software development projects.\nCERTIFICATIONS & CROSS-FUNCTIONAL SKILLS\nCertifications:\nMethodologies:\nLanguages:\nSoft Skills:', '2025-11-26 18:24:07', '2025-11-26 18:24:07'),
(7, 38, 2, 40, '{\"presentation\":20,\"experience\":30,\"formation\":10,\"competences\":50,\"coherence\":30}', 'Ce CV présente des informations techniques et scientifiques complexes, mais manque de clarté et de structure. Les expériences et les compétences sont difficiles à identifier.', '[{\"category\":\"Pr\\u00e9sentation\",\"priority\":\"haute\",\"suggestion\":\"R\\u00e9organiser le CV pour am\\u00e9liorer la clart\\u00e9 et la lisibilit\\u00e9, en utilisant des titres et des sous-titres pour structurer les informations.\"},{\"category\":\"Exp\\u00e9rience\",\"priority\":\"moyenne\",\"suggestion\":\"Mettre en avant les exp\\u00e9riences professionnelles et les r\\u00e9alisations concr\\u00e8tes, en utilisant des verbes d\'action pour d\\u00e9crire les responsabilit\\u00e9s et les accomplishments.\"},{\"category\":\"Comp\\u00e9tences\",\"priority\":\"basse\",\"suggestion\":\"Lister les comp\\u00e9tences et les connaissances techniques de mani\\u00e8re claire et concise, en utilisant des termes standardis\\u00e9s pour faciliter la compr\\u00e9hension.\"}]', '[\"Pr\\u00e9sence de concepts scientifiques et techniques avanc\\u00e9s\",\"Utilisation de formules et d\'\\u00e9quations math\\u00e9matiques\",\"R\\u00e9f\\u00e9rences \\u00e0 des th\\u00e9ories et des principes physiques\"]', '[\"Manque de clart\\u00e9 et de structuration\",\"Difficult\\u00e9 \\u00e0 identifier les exp\\u00e9riences et les comp\\u00e9tences\",\"Utilisation excessive de termes techniques et d\'abr\\u00e9viations\"]', '1 \n. \n سصلانا حعشلأ ًئُظ عثىم حطساُت ثؼجو حمٍلس حٍئُظ حمضحجُم لُؼبٍرnm633 . حشاش ىهع .\nحشاشنا ىهع حٍئُظ حعمت نُكذ ظحلاو .\nسصلانا غجىمَ خشبشنا هٕث غعو خسٕفص ذخُٔكش بٍث . \n خشبشنا ّهػ ذٌبشو خفبسمنا ٓف خػُظُمنا Dة كشنا همبٍؽسُزر خئٕعم بؼل ٓف خمهظم غمثيبدرا غم ذمبؼزم يبدراكشنا ، غجىمك كشنا فشصزٔ ثٕسث \n ٓئُظٓمٌَ .حشٌبظث ّمسر حشٌبظنا يزٌ دُٕسنا . \nخظُسهم : لبمؼزسبثغٕفس كهسكشنا سَد تؼهٔ ػٕخنا ثٕسث خمثبسنا حئبزىنا سفو ّهػ مصسو .\n ًث ضخبز لبمؼزسا ذىػَ خسزفخٔشئاد :خسزفنا شؽل هم شجكأ بٌشؽل خٔشئاد خؼمث ّهػ مصسوٓسرَ ،غ خمهظم دبمهز ٓناُزنا ّهػ بٍث ِشخأَخئٕعم . \n ٓفهٕزنبسنا - كشنا ضشػ شغص بمهك دادضٔ خٔضكشمنا خؼمجنا ضشػ. \n- بٍظشػ دادضَٔ ممؼزسمنا ءُعنا خخُم لُؼ دادصا بمهك خفبسمنا ددادصا بمهك َأD. \n قشفناَْاضنا  هم بللاؽوا خٔضكشمنا خؼمجنا فصو بٍنلاخ هم ذٌبشو ٓزنا خَٔاضنا ٌٓ كشنا. \n( كشنا هم بللاؽوا بٍفشؼ هم سبمنا عبؼشناَ خٔضكشمنا خؼمجنا ضكشم هم سبمنا عبؼشنا بٍوُكٔ ٓزنا خَٔاضنا ْأ) \n ■ةبرجت : \nخفبسمنا ٓف خشبشنا غعوmD5,1 ضشؼنا خفهزخم كمش دار رئبفص ممؼزسوَ a ضشؼنا خسٕفص مكن خجسىنبث سٕمو مث، L خٔضكشمنا خؼمجهن \nخشبشنا ّهػ حذٌبشمنا .دبسبٕمنا لَذخ:\n2 \n ■ تارٍغتل لثمملا ىنحنملا مسر ةللادب a\n : \n ■هجوملا لماعملا ةمٍق دٌدحت : \n ■ قشلا ضرع رٍبعت: \n هٕزللاؼنا للاخ هم(1) َ(2 : )\n دواك امهك ًوأ حعرٌ حللاعنا يزٌ للاخ هم َأ Dاشٍثك حٌضكشمنا حعمثنا ضشع ناك امهك هٍذشٍثك ناك امهكَ a(كشنا ضشع) ناك امهك اشٍغص ضشع\nحمتاسنا حتشجرنا جئارو عم كتاطرٌ يزنا ءًشنا اشٍثك كنزك حٍئُعنا حعمثنا. \nحظُحهم :\n يشطل عٍفس طٍخ لامعرسا حناح ًف يَاضنا قشفنا هع شثعٌd حللاعنات : d\n\n َحناح ًف لامعرسا حللاعنات يشئاد ةمث :a\n\n\n.22,1\n .\n خظشؼزسم خٕسٕؽىغمشٍك خخُم ءُعنا ششزىٔ ؽاشفنا ٓفَ خفبفشنا خٔدبمنا غبسَلأا ٓف . \n * نوللا يداحلأا ءوضلا : \n. \n ػسُث كهؼزٔ نُهنا ْدبزلأا ءُعنا خخُم لُؼ بمىٕثسبشزولاا. \nشخٖ ػسَ هم فهزخر ءُعنا سبشزوا خػشس.، لاثمف : \n ءاٍُنا َأ ؽاشفنا ٓف ءُعنا سبشزوا خػشس:smc /10.3\n8\n جبخضنا ٓفَ :=2.10\n8\nm/sجبخصv ءبمنا ٓفَ =2,25.10\n8\nm/sءبمv . \n\nc\no \nرجصر خمثبسنا خللاؼنا كنزثَ : c=3.10\n8\nm/s : بىٔذنَ (la célérité) c خظُسهم : ة بٍٕنإ ضمشٔ ؽاشفنا ٓف ءُعنا سبشزوا خػشس \n : ؽاشفنا ٓف خٕئُعنا خخُمنا لُؼ.o \n *ضٍبلأا ءوضلا:ًئرملا ءوضلا وأ : \nطٕثلأا ءُعنا : ٓئشمنا ءُعنا َأ : ْأ ناُنلأا دذؼزم ءُظ نُهنا خٔدبزأ دبػبؼشإ هم حٔضم ( َأ ذبجصمنا ءُظ َأ سمشنا ءُظ مثم\n خؼمشنا ءُظ...) ٓئشمنا ءُعنا لبدمَ، :\n3 \nخٕنبزنا خللاؼنا ًٕؽؼر ْزنا يسبسكوا ممبؼمث ضٕمزٔ فبفش ػسَ مك :\n جشٌاظ ٌُ ءُعنا ساسكوا ذىع يساسم هع ًئُعنا عاعشنا فاشحوا َشميس طسَ هم فافش حطسناشخآ فافش طسَ ىنإ. \n .\n ءُعنا ساسكولا خساكٌد نُوال :2211 sin.sin. inin  \nكٍثطذ :\n حٌَاص نُكذ ثٍحت حٍئُظ حمضح مسشو70\no\n ًنارنا مكشنا ًىٍثٌ امك ءامنا حطس عم :\nأ ) اسكوا مماعم نأ امهعس ءاٍُنا = 1ءاٌُ nءامنا ساسكوا مماعمَ=1,33 ءام n حٌَاص حمٍل ذجَأ ساسكولاا .\nب ) يَاسذ ساسكولاا حٌَاص دواك ارإ دَسُنا حٌَاص حمٍل ام30\no\n ؟ \n------------------------ ةبوجأ ...................\nأ) دَسُنا خَٔاص نأ رعزٔ مكشنا للاخ هم :o\ni 207090\n1  \nتسز ءُعنا ساسكولا خساكٌد نُوال بىٔذن :2211 sin.sin. inin  ًىمَ :.\nsin.\nsin\n2\n11\n2\nn\nin\ni نرإ :\n\n\n\n\n\n\n\n\n\n.\nsin.\nsin\n2\n111\n2\nn\nin\ni \nد.ع :o\ni 9,14\n33,1\n20sin.1\nsin\n1\n2\n\n\n\n\n\n\n\n \nة) بىٔذن :2211 sin.sin. inin   1\n22\n1\nsin.\nsin\nn\nin\ni نرإ :\n\n\n\n\n\n\n\n\n\n1\n221\n1\nsin.\nsin\nn\nin\ni د .ع :o\ni 7,41\n1\n30sin.33,1\nsin\n1\n1\n\n\n\n\n\n\n\n\n4 \nسُشُمنا فشز ّمسٔ مٕمزسم ذىػ نبؼؼبمزٔ ذسم هٍٕخُث دَذسم سوبدزم فبفش ػسَ سُشُمنا .( سُشُمنا حذػبل ّمسٔ فشسهن مثبممنا ًخُنا). \n،سُشُم ًخَ ّهػ نُهنا خٔدبزأ خٕئُظ خمضز مسشو غعخر خمضسنا نأ ظزلاوسبسكولاسُشُمنا حذػبل ُسو فشسىرَ ٓوبثنا ًخُنا ّهػ مث لَلأا ًخُنا ّهػ . \n \'rrA سُشُمنا خَٔاص: rnisinsin \n دسبكٔد نُوبل كٕجؽر سبسكولاءُعنا سُشُمهن لَلأا ًخُنا ّهػ: \n \'sin\'sin irn  \n دسبكٔد نُوبل كٕجؽر سبسكولاسُشُمهن ٓوبثنا ًخُنا ّهػ ءُعنا: AiiD \' \n خَٔاصفاشسولااسُشُمهن يصبٕزخا ذؼث دساُنا عبؼشهن ٓهكنا : \n■ ةبرجت : \n خٕنبزنا ناُنلأا هم نُكزمنا طٕثلأا ءُعنا فٕؼ ّهػ مصسىف سُشُم ًخَ ّهػ طٕثلأا ءُعنا هم خمضز مسشو: ، شعخلأا ، شفصلأا ، ٓنبمرشجنا ، شمزلأا\nٓدسفىجناَ ٓهٕىنا ن قسصلأا. \n طٕثلأا ءُعنا فٕؼ ّهػ مصسىف سُشُمهن يصبٕزخا ذؼث ءُعنا دذجزٔ. \nسُشُم خؽساُث طٕثلأا ءُعنا دذجر \n■لٍلعت : \n ●مصزم طٕثلأا ءُعنا فٕؼَ نُهنا خٔدبزأ ءاُظأ حذػ هم نُكزٔ طٕثلأا ءُعنا . \n● تجسسُشُمنا مخاد يسَشم ءاىثأ حفهرخمنا ًواُنأ ىنإ طٍتلأا ءُعنا مهحذ ٌُ فلازخاًف ءُعنا حعشسسُشُمنا جدام (لاجاجص)ءاٍُنا ًف ًرعشس هع \nءًشنا ْزناىنإ يدؤٌ ساسكوا حعشأءُعنا طٍتلأا ًنُخد ذىع ا منحفهرخم ساسكوا اٌاَضت سُشُمًن اٌصاٍرجا ذعت طعثنا اٍععت هع مصفرف . \n ● بمك خخُمنا لُؽن خٕصلبىر خناد ٍُف يصبزدر ٓزنا خٕئُعنا خخُمنا ددشزث كهؼزٔ سُشُمنا سبسكوا ممبؼم نُك ّنإ طٕثلأا ءُعنا دذجر ِضؼٔ \n n=c/v ● نأ بمث خٕئُعنا دبخُمنا ددشزث كهؼزٔ سُشُمنا سبسكوا ممبؼم.خللاؼنا ًىٕجر بمك خػشسنبث كهؼزٔ سبسكولاا ممبؼم نأ بمثَ : \n نإف دذجم ػسَ سُشُمنا نإف ٓنبزنبثَ ددشزنبث كهؼزر خٕئُعنا دبخُمنا سبشزوا خػشس. \n------------------------------------- \nر. َشٕجسا مٔشكنا ذجػ \n ًف ممعنا ازٌ باُث معجا مٍهنادفٍحصيامٍٍهع للها حمحس اٍفُذ نازهنا يذناَ .', '2025-11-26 18:31:51', '2025-11-26 18:31:51'),
(9, 40, 2, 85, '{\"presentation\":80,\"experience\":70,\"formation\":90,\"competences\":95,\"coherence\":85}', 'Le candidat présente un profil intéressant avec une bonne formation et des compétences techniques variées, mais son expérience professionnelle est limitée. Il a une bonne maîtrise des technologies et outils de développement web et mobile, ainsi que des compétences en data science et intelligence artificielle.', '[{\"category\":\"Pr\\u00e9sentation\",\"priority\":\"haute\",\"suggestion\":\"Ajouter une photo de profil et un r\\u00e9sum\\u00e9 plus d\\u00e9taill\\u00e9 pour pr\\u00e9senter ses comp\\u00e9tences et exp\\u00e9riences de mani\\u00e8re plus attractive\"},{\"category\":\"Exp\\u00e9rience\",\"priority\":\"moyenne\",\"suggestion\":\"Fournir plus de d\\u00e9tails sur les exp\\u00e9riences professionnelles, notamment les r\\u00e9alisations et les d\\u00e9fis rencontr\\u00e9s\"},{\"category\":\"Comp\\u00e9tences\",\"priority\":\"basse\",\"suggestion\":\"Mettre \\u00e0 jour les comp\\u00e9tences techniques pour refl\\u00e9ter les derni\\u00e8res tendances et technologies du march\\u00e9\"}]', '[\"Bonnes comp\\u00e9tences techniques en d\\u00e9veloppement web et mobile\",\"Connaissances en data science et intelligence artificielle\",\"Exp\\u00e9rience avec les syst\\u00e8mes embarqu\\u00e9s et l\'IoT\"]', '[\"Exp\\u00e9rience professionnelle limit\\u00e9e\",\"Manque de d\\u00e9tails sur les projets et exp\\u00e9riences professionnelles\",\"Pas de certifications professionnelles majeures\"]', 'SERSIF\nDéveloppeur Full-Stack | Ingénieur Logiciel | IoT & Systèmes\nEmbarqués\nEl Jadida, Maroc\nI\n#\nProfil Professionnel\nÉtudiant en Master 2 Ingénierie Informatique et Analyse de Données, à la recherche d’un stage PFE pour approfondir mes\ncompétences en développement full-stack,Intelligence artificielle,Analyse de données, IoT et systèmes embarqués. Développeur\npassionné avec une expérience pratique en applications web/mobile, solutions IoT pour l’agriculture de précision et optimisation\nde processus industriels. Motivé, rigoureux et prêt à contribuer activement aux projets innovants de l’entreprise.\nÉducation\n2024 – En\ncours\nMaster en Ingénierie Informatique et Analyse de Données,, El Jadida, Maroc\nSpécialisation en analyse de données, Big Data, Architecture logicielle. Projets recherche IA appliquée.\n2020 – 2024,, El Jadida, Maroc\nFormation algorithmes, structures données, statistiques. Projets développement logiciel.\nExpériences Professionnelles\nAoût 2025 –\nOctobre 2025\nData Scientist / Ingénieur Processus,, Maroc\n—\n—\n—\n—\nJanvier 2024 –\nAvril 2024\nDéveloppeur Full-Stack,, Maroc\n—\n—\n—\nProjets Techniques Majeurs\nSystème IoT Agriculture de Précision,\n—\n—\nChatbot Scientifique Intelligent,\n—\n—\nMarketplace Revent Ticket,\n—\n—\nCompétences Techniques et Personnelles\nTechnologies et Outils\nLangages de Programmation\nHTML, CSS, Python, Java EE, JavaScript, C, PHP, SQL\nDéveloppement Web & Mobile\nReact.js, Angular, Next.js, React Native, Node.js, Express.js,\nAPI RESTful\nData Science & Deep Learning\nPandas, NumPy, Scikit-learn, OpenCV, TensorFlow, Keras,\nPyTorch, RNN, LLM\nBases de Données\nMySQL, Oracle, MongoDB\nIoT & DevOps\nArduino, ESP32, capteurs/actionneurs, Docker, Kubernetes,\nCI/CD, Git/GitHub, Linux, Postman, Jira\nCompétences Personnelles\nMéthodologies\nAgile/Scrum, DevOps\nSoft Skills\nRésolution problèmes complexes, communication tech-\nnique, leadership projet\nLangues\nArabe\nFrançais\nAnglais\nCertifications\nIntroduction à l’IA\nScience des Données', '2025-11-26 18:39:34', '2025-11-26 18:39:34');

-- --------------------------------------------------------

--
-- Structure de la table `cv_conversations`
--

CREATE TABLE `cv_conversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `cv_analysis_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `response` text NOT NULL,
  `role` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cv_conversations`
--

INSERT INTO `cv_conversations` (`id`, `user_id`, `cv_analysis_id`, `message`, `response`, `role`, `created_at`, `updated_at`) VALUES
(1, 3, 3, 'donner moi un plan pour ameloirer mon cv', 'Pour améliorer votre CV, voici un plan d\'action détaillé basé sur les points forts et les points faibles identifiés lors de l\'analyse :\n\n### Étape 1 : Ajouter des détails sur les réalisations concrètes et les résultats obtenus\n\n1. **Révisez vos expériences professionnelles** : Pour chaque poste occupé, essayez de quantifier vos réalisations. Par exemple, si vous avez amélioré la vitesse d\'exécution d\'une application, indiquez le pourcentage d\'amélioration (par exemple, \"Amélioration de 30% de la vitesse d\'exécution d\'une application full-stack\").\n2. **Utilisez des verbes d\'action** : Commencez chaque phrase de description de vos expériences professionnelles avec des verbes d\'action comme \"Développé\", \"Amélioré\", \"Géré\", \"Créé\", etc.\n3. **Faites ressortir vos contributions** : Même si vous étiez dans une équipe, essayez de mettre en avant vos contributions spécifiques aux projets.\n\n### Étape 2 : Inclure des projets personnels ou des contributions open-source\n\n1. **Identifiez vos projets personnels** : Réfléchissez à tout projet personnel que vous avez mené à bien, même s\'il s\'agit d\'un petit projet. Ces projets montrent votre initiative et vos compétences.\n2. **Participez à des projets open-source** : Recherchez des projets open-source sur GitHub ou d\'autres plateformes qui correspondent à vos compétences et intérêts. Contribuez à ces projets, même de manière mineure, pour montrer votre engagement envers la communauté du développement.\n3. **Présentez ces projets dans votre CV** : Créez une section \"Projets\" ou \"Contributions Open-Source\" où vous décrivez brièvement chaque projet, votre rôle dans celui-ci, et les compétences techniques utilisées.\n\n### Étape 3 : Renforcer votre profil avec des certifications\n\n1. **Recherchez des certifications pertinentes** : Identifiez les certifications qui sont hautement valorisées dans votre domaine, comme des certifications en développement web, en sécurité informatique, en données, etc.\n2. **Planifiez votre formation** : Une fois que vous avez identifié les certifications souhaitées, planifiez votre formation. Beaucoup de certifications nécessitent une préparation et des études approfondies.\n3. **Ajoutez les certifications à votre CV** : Dès que vous obtenez une certification, ajoutez-la à votre CV. Cela montre que vous êtes actif dans votre développement professionnel et que vous êtes à jour avec les dernières technologies et méthodes.\n\n### Étape 4 : Révision et optimisation générale du CV\n\n1. **Assurez-vous que votre CV est clair et facile à lire** : Utilisez des polices de caractères standard et un formatage uniforme.\n2. **Utilisez des mots-clés** : Incorporuez des mots-clés liés à votre domaine dans votre CV, notamment dans la section des compétences et dans les descriptions de vos expériences professionnelles.\n3. **Vérifiez les fautes d\'orthographe et de grammaire** : Un CV bien écrit sans erreurs montre de l\'attention aux détails.\n\n### Étape 5 : Demandez des retours\n\n1. **Demandez à des collègues ou à des mentors** : Partagez votre CV avec des personnes de confiance dans votre réseau professionnel et demandez-leur un retour d\'expérience.\n2. **Intégrez les feedbacks** : Utilisez les commentaires pour faire des ajustements finals à votre CV.\n\nEn suivant ces étapes, vous devriez être en mesure d\'améliorer significativement votre CV, en mettant en valeur vos compétences, vos réalisations et votre potentiel pour les postes de développeur full-stack et dans d\'autres domaines liés aux technologies de l\'information.', 'user', '2025-11-26 17:59:36', '2025-11-26 17:59:36'),
(2, 3, 4, 'Comment puis-je améliorer mon score ?', 'Pour améliorer votre score, il est essentiel de cibler les points faibles identifiés dans l\'analyse de votre CV. Voici quelques conseils personnalisés pour vous aider à améliorer votre score :\n\n1. **Amélioration de la présentation** : Investissez du temps pour créer une mise en page plus attractive et fácil à lire. Utilisez des polices de caractères claires, des titres bien définis et des espaces blancs pour améliorer la lisibilité. Vous pouvez également utiliser des modèles de CV modernes pour vous inspirer.\n\n2. **Mise en avant des compétences techniques** : Développez les sections relatives à vos compétences techniques, notamment en développement web et en gestion de bases de données. Listez les langages de programmation que vous maîtrisez, les frameworks que vous avez utilisés, les systèmes de gestion de bases de données avec lesquels vous avez travaillé, etc. Soyez précis et utilisez des termes clés pertinents pour votre domaine.\n\n3. **Ajout d\'informations sur les réalisations personnelles** : Intégrez des détails sur vos réalisations et contributions significatives dans vos précédents postes. Cela peut inclure des projets que vous avez menés à bien, des défis que vous avez surmontés, ou des améliorations que vous avez apportées à vos processus de travail. Utilisez des chiffres et des statistiques pour démontrer l\'impact de votre travail.\n\n4. **Formation académique et expérience professionnelle** : Bien que votre CV montre une bonne cohérence dans ces domaines, assurez-vous de mettre en avant les aspects les plus pertinents et les plus impressionnants de votre parcours académique et professionnel. Cela peut inclure des récompenses, des bourses, ou des expériences de travail significatives.\n\n5. **Vérification et révision** : Faites une relecture attentive de votre CV pour vous assurer qu\'il n\'y a pas d\'erreurs d\'orthographe, de grammaire ou de syntaxe. Demandez également à des personnes de confiance de revoir votre CV et de vous fournir des feedbacks constructifs.\n\nEn suivant ces conseils, vous devriez être en mesure d\'améliorer la présentation, de mettre en valeur vos compétences techniques et de mettre en avant vos réalisations personnelles, ce qui à son tour améliorera votre score global. N\'hésitez pas à me poser d\'autres questions si vous avez besoin de plus de détails ou de conseils spécifiques sur ces points.', 'user', '2025-11-26 18:07:04', '2025-11-26 18:07:04'),
(3, 3, 5, 'Que penses-tu de mon expérience professionnelle ?', 'D\'après l\'analyse de ton CV, il ressort que tu as une expérience professionnelle très solide en développement logiciel, data science et intelligence artificielle. Tes compétences techniques sont très variées et adaptées aux besoins actuels du marché, ce qui est un atout considérable pour tout employeur.\n\nEn particulier, je note que tu as une expérience confirmée en développement logiciel et data science, ce qui suggère que tu as une bonne compréhension des principes et des méthodes de développement de logiciels et d\'analyse de données. Cela est renforcé par ta formation académique solide en ingénierie informatique et analyse de données.\n\nCependant, pour mettre en avant tes réalisations et tes compétences de manière plus claire, je te conseille de fournir plus de détails sur les projets que tu as menés à bien et les résultats que tu as obtenus. Cela pourrait inclure des informations sur les technologies utilisées, les défis rencontrés et les solutions apportées, ainsi que les impacts positifs que tes projets ont eu sur les entreprises ou les organisations pour lesquelles tu as travaillé.\n\nEn résumé, ton expérience professionnelle est très solide, mais il est important de la présenter de manière plus détaillée et plus claire pour que les employeurs potentiels puissent apprécier pleinement tes compétences et tes réalisations. Qu\'est-ce que tu penses de cette suggestion ?', 'user', '2025-11-26 18:21:15', '2025-11-26 18:21:15'),
(4, 3, 5, 'est qu\'il ya une faux d\'ortaugraph ?', 'Je vois que tu as fait une erreur d\'orthographe dans ta question ! En effet, \"faux d\'ortaugraph\" devrait être écrit \"faute d\'orthographe\".\n\nMais pour répondre à ta question, je n\'ai pas remarqué de fautes d\'orthographe majeures dans ton CV. Cependant, il est possible que quelques erreurs de grammaire ou de ponctuation soient présentes. Il est important de vérifier soigneusement ton CV pour s\'assurer qu\'il est exempt d\'erreurs, car cela peut donner une mauvaise impression aux employeurs potentiels.\n\nJe te conseille de relire ton CV attentivement pour détecter toute erreur d\'orthographe, de grammaire ou de ponctuation. Il est également utile de demander à quelqu\'un de réviser ton CV pour avoir une autre perspective et détecter les erreurs que tu n\'as pas vues.\n\nEn outre, il est important de noter que les fautes d\'orthographe et de grammaire peuvent affecter la crédibilité de ton CV et donner une mauvaise impression aux employeurs. Il est donc essentiel de prendre le temps de vérifier et de corriger ton CV pour s\'assurer qu\'il est parfait. Qu\'est-ce que tu penses de cette suggestion ?', 'user', '2025-11-26 18:21:52', '2025-11-26 18:21:52'),
(5, 3, 6, 'hiba', 'Bonjour ! Je suis ravi de discuter avec vous à propos de votre CV. Comme vous le savez, nous avons effectué une analyse de votre CV et nous avons obtenu un score global de 85/100. C\'est un excellent score, qui reflète votre expérience et vos compétences dans le domaine du développement logiciel et de l\'analyse de données.\n\nJe remarque que vous avez une solide formation académique en ingénierie informatique et en analyse de données, ainsi que des compétences techniques diversifiées, notamment en développement full-stack et en intelligence artificielle. C\'est vraiment un atout pour un candidat dans votre domaine !\n\nCependant, nous avons identifié quelques points qui pourraient être améliorés pour rendre votre CV encore plus percutant. Par exemple, certaines sections pourraient être mieux organisées pour une meilleure lisibilité et cohérence. De plus, il serait utile de fournir plus de détails sur certains projets et expériences professionnelles pour donner une meilleure idée de vos réalisations et de vos compétences.\n\nJe suis là pour vous aider à comprendre ces recommandations et à améliorer votre CV. Qu\'est-ce que vous aimeriez savoir ou discuter en premier lieu ? Vos points forts, vos points faibles, ou peut-être comment améliorer votre présentation ? Je suis à votre écoute !', 'user', '2025-11-26 18:24:37', '2025-11-26 18:24:37'),
(7, 2, 9, 'Comment rendre mon CV plus attractif ?', 'Pour rendre votre CV plus attractif, je vous recommande de mettre en œuvre les suggestions suivantes, basées sur l\'analyse que nous avons effectuée :\n\n1. **Ajoutez plus de détails sur vos expériences professionnelles** : Bien que vous ayez une bonne formation et des compétences techniques variées, votre expérience professionnelle est limitée. Essayez d\'ajouter plus de détails sur les projets que vous avez réalisés, les défis que vous avez surmontés et les résultats que vous avez obtenus. Cela aidera les recruteurs à mieux comprendre vos capacités et votre potentiel.\n\n2. **Mettez en avant vos réalisations** : Au lieu de simplement énumérer vos tâches et responsabilités, mettez en avant vos réalisations et les résultats que vous avez obtenus. Par exemple, au lieu de dire \"j\'ai développé une application mobile\", dites \"j\'ai développé une application mobile qui a augmenté les ventes de 25% en 6 mois\".\n\n3. **Incluez des certifications professionnelles** : Bien que vous n\'ayez pas de certifications professionnelles majeures, il est important de les inclure si vous en avez. Les certifications peuvent démontrer votre expertise et votre engagement dans votre domaine.\n\n4. **Utilisez des mots-clés pertinents** : Les recruteurs utilisent souvent des logiciels de suivi des candidatures pour filtrer les CV. Utilisez des mots-clés pertinents liés à votre domaine pour augmenter les chances que votre CV soit sélectionné.\n\n5. **Mettez en avant vos compétences en data science et intelligence artificielle** : Vos compétences en data science et intelligence artificielle sont un atout majeur. Mettez-les en avant et expliquez comment vous les avez utilisées dans vos projets précédents.\n\n6. **Incluez des liens vers vos projets ou votre portfolio** : Si vous avez des projets ou un portfolio en ligne, incluez des liens vers eux dans votre CV. Cela permettra aux recruteurs de voir vos réalisations et de mieux comprendre vos capacités.\n\n7. **Faites une mise en page claire et lisible** : Une mise en page claire et lisible est essentielle pour un CV. Utilisez des titres, des sous-titres et des paragraphes pour rendre votre CV facile à lire.\n\nEn suivant ces conseils, vous pourrez rendre votre CV plus attractif et augmenter vos chances de réussite dans votre recherche d\'emploi. N\'hésitez pas à me poser d\'autres questions si vous avez besoin de plus de détails ou de conseils personnalisés.', 'user', '2025-11-26 18:39:44', '2025-11-26 18:39:44');

-- --------------------------------------------------------

--
-- Structure de la table `cv_uploads`
--

CREATE TABLE `cv_uploads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `stored_filename` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_size` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cv_uploads`
--

INSERT INTO `cv_uploads` (`id`, `user_id`, `original_filename`, `stored_filename`, `file_path`, `file_type`, `file_size`, `created_at`, `updated_at`) VALUES
(1, 2, 'cv_sersif_abdeljalil-3.pdf', '1764072672_2.pdf', 'cvs/1764072672_2.pdf', 'pdf', 238098, '2025-11-25 11:11:12', '2025-11-25 11:11:12'),
(2, 2, 'cv_sersif_abdeljalil-3.pdf', '1764072681_2.pdf', 'cvs/1764072681_2.pdf', 'pdf', 238098, '2025-11-25 11:11:21', '2025-11-25 11:11:21'),
(3, 2, 'cv_sersif_abdeljalil-3.pdf', '1764073401_2.pdf', 'cvs/1764073401_2.pdf', 'pdf', 238098, '2025-11-25 11:23:21', '2025-11-25 11:23:21'),
(4, 2, 'cv_sersif_abdeljalil-3.pdf', '1764073601_2.pdf', 'cvs/1764073601_2.pdf', 'pdf', 238098, '2025-11-25 11:26:41', '2025-11-25 11:26:41'),
(5, 2, 'cv_sersif_abdeljalil-3.pdf', '1764098777_2.pdf', 'cvs/1764098777_2.pdf', 'pdf', 238098, '2025-11-25 18:26:17', '2025-11-25 18:26:17'),
(6, 2, 'cv_sersif_abdeljalil-3.pdf', '1764098914_2.pdf', 'cvs/1764098914_2.pdf', 'pdf', 238098, '2025-11-25 18:28:34', '2025-11-25 18:28:34'),
(7, 2, 'cv_sersif_abdeljalil-3.pdf', '1764099015_2.pdf', 'cvs/1764099015_2.pdf', 'pdf', 238098, '2025-11-25 18:30:15', '2025-11-25 18:30:15'),
(8, 2, 'cv_sersif_abdeljalil-3.pdf', '1764099166_2.pdf', 'cvs/1764099166_2.pdf', 'pdf', 238098, '2025-11-25 18:32:46', '2025-11-25 18:32:46'),
(9, 2, 'cv_sersif_abdeljalil-3.pdf', '1764099542_2.pdf', 'cvs/1764099542_2.pdf', 'pdf', 238098, '2025-11-25 18:39:03', '2025-11-25 18:39:03'),
(10, 2, 'cv_sersif_abdeljalil-3.pdf', '1764100200_2.pdf', 'cvs/1764100200_2.pdf', 'pdf', 238098, '2025-11-25 18:50:00', '2025-11-25 18:50:00'),
(11, 2, 'cv_sersif_abdeljalil-3.pdf', '1764100605_2.pdf', 'cvs/1764100605_2.pdf', 'pdf', 238098, '2025-11-25 18:56:45', '2025-11-25 18:56:45'),
(12, 2, 'cv_sersif_abdeljalil-3.pdf', '1764100827_2.pdf', 'cvs/1764100827_2.pdf', 'pdf', 238098, '2025-11-25 19:00:27', '2025-11-25 19:00:27'),
(13, 2, 'cv_sersif_abdeljalil-3.pdf', '1764101051_2.pdf', 'cvs/1764101051_2.pdf', 'pdf', 238098, '2025-11-25 19:04:11', '2025-11-25 19:04:11'),
(14, 2, 'cv_sersif_abdeljalil-2.pdf', '1764101305_2.pdf', 'cvs/1764101305_2.pdf', 'pdf', 252785, '2025-11-25 19:08:25', '2025-11-25 19:08:25'),
(15, 2, 'cv_sersif_abdeljalil-3.pdf', '1764101511_2.pdf', 'cvs/1764101511_2.pdf', 'pdf', 238098, '2025-11-25 19:11:51', '2025-11-25 19:11:51'),
(16, 3, 'cv_sersif_abdeljalil-3.pdf', '1764106874_3.pdf', 'cvs/1764106874_3.pdf', 'pdf', 238098, '2025-11-25 20:41:14', '2025-11-25 20:41:14'),
(17, 3, 'cv_sersif_abdeljalil-3.pdf', '1764107034_3.pdf', 'cvs/1764107034_3.pdf', 'pdf', 238098, '2025-11-25 20:43:54', '2025-11-25 20:43:54'),
(18, 3, 'cv_sersif_abdeljalil-3.pdf', '1764107238_3.pdf', 'cvs/1764107238_3.pdf', 'pdf', 238098, '2025-11-25 20:47:18', '2025-11-25 20:47:18'),
(19, 3, 'cv_sersif_abdeljalil-3.pdf', '1764107992_3.pdf', 'cvs/1764107992_3.pdf', 'pdf', 238098, '2025-11-25 20:59:52', '2025-11-25 20:59:52'),
(20, 3, 'cv_sersif_abdeljalil-2.pdf', '1764108093_3.pdf', 'cvs/1764108093_3.pdf', 'pdf', 252785, '2025-11-25 21:01:33', '2025-11-25 21:01:33'),
(21, 3, 'cv_sersif_abdeljalil-3.pdf', '1764109452_3.pdf', 'cvs/1764109452_3.pdf', 'pdf', 238098, '2025-11-25 21:24:12', '2025-11-25 21:24:12'),
(22, 3, 'cv_sersif_abdeljalil-3.pdf', '1764109590_3.pdf', 'cvs/1764109590_3.pdf', 'pdf', 238098, '2025-11-25 21:26:30', '2025-11-25 21:26:30'),
(23, 3, 'cv_sersif_abdeljalil-3.pdf', '1764109832_3.pdf', 'cvs/1764109832_3.pdf', 'pdf', 238098, '2025-11-25 21:30:32', '2025-11-25 21:30:32'),
(24, 3, 'cv_sersif_abdeljalil-3.pdf', '1764181759_3.pdf', 'cvs/1764181759_3.pdf', 'pdf', 238098, '2025-11-26 17:29:20', '2025-11-26 17:29:20'),
(25, 3, 'cv.pdf', '1764182277_3.pdf', 'cvs/1764182277_3.pdf', 'pdf', 309230, '2025-11-26 17:37:57', '2025-11-26 17:37:57'),
(26, 3, 'cv-1.pdf', '1764182364_3.pdf', 'cvs/1764182364_3.pdf', 'pdf', 162464, '2025-11-26 17:39:24', '2025-11-26 17:39:24'),
(27, 3, 'cv_sersif_abdeljalil-3.pdf', '1764182493_3.pdf', 'cvs/1764182493_3.pdf', 'pdf', 238098, '2025-11-26 17:41:34', '2025-11-26 17:41:34'),
(28, 3, 'cv_sersif_abdeljalil-3.pdf', '1764183358_3.pdf', 'cvs/1764183358_3.pdf', 'pdf', 238098, '2025-11-26 17:55:58', '2025-11-26 17:55:58'),
(29, 3, 'cv-1.pdf', '1764183431_3.pdf', 'cvs/1764183431_3.pdf', 'pdf', 162464, '2025-11-26 17:57:11', '2025-11-26 17:57:11'),
(30, 3, 'cv-1.pdf', '1764183434_3.pdf', 'cvs/1764183434_3.pdf', 'pdf', 162464, '2025-11-26 17:57:14', '2025-11-26 17:57:14'),
(31, 3, 'cv-1.pdf', '1764183499_3.pdf', 'cvs/1764183499_3.pdf', 'pdf', 162464, '2025-11-26 17:58:19', '2025-11-26 17:58:19'),
(32, 3, 'cv-1.pdf', '1764183501_3.pdf', 'cvs/1764183501_3.pdf', 'pdf', 162464, '2025-11-26 17:58:21', '2025-11-26 17:58:21'),
(33, 3, 'cv_sersif_abdeljalil-3.pdf', '1764183526_3.pdf', 'cvs/1764183526_3.pdf', 'pdf', 238098, '2025-11-26 17:58:46', '2025-11-26 17:58:46'),
(34, 3, 'cv.pdf', '1764183734_3.pdf', 'cvs/1764183734_3.pdf', 'pdf', 309230, '2025-11-26 18:02:14', '2025-11-26 18:02:14'),
(35, 3, 'cv-1.pdf', '1764183996_3.pdf', 'cvs/1764183996_3.pdf', 'pdf', 162464, '2025-11-26 18:06:36', '2025-11-26 18:06:36'),
(36, 3, 'cv.pdf', '1764184717_3.pdf', 'cvs/1764184717_3.pdf', 'pdf', 309230, '2025-11-26 18:18:37', '2025-11-26 18:18:37'),
(37, 3, 'cv_sersif_abdeljalil-1.pdf', '1764185046_3.pdf', 'cvs/1764185046_3.pdf', 'pdf', 146361, '2025-11-26 18:24:06', '2025-11-26 18:24:06'),
(38, 2, 'Leçon n°3 ondes lumineuses.pdf', '1764185509_2.pdf', 'cvs/1764185509_2.pdf', 'pdf', 549434, '2025-11-26 18:31:49', '2025-11-26 18:31:49'),
(39, 2, 'cv-1.pdf', '1764185545_2.pdf', 'cvs/1764185545_2.pdf', 'pdf', 162464, '2025-11-26 18:32:25', '2025-11-26 18:32:25'),
(40, 2, 'cv_sersif_abdeljalil-3.pdf', '1764185972_2.pdf', 'cvs/1764185972_2.pdf', 'pdf', 238098, '2025-11-26 18:39:32', '2025-11-26 18:39:32'),
(41, 3, 'TP0_Report-3.pdf', '1764186049_3.pdf', 'cvs/1764186049_3.pdf', 'pdf', 306794, '2025-11-26 18:40:49', '2025-11-26 18:40:49'),
(42, 4, 'cv-1.pdf', '1764233069_4.pdf', 'cvs/1764233069_4.pdf', 'pdf', 162464, '2025-11-27 07:44:29', '2025-11-27 07:44:29');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_11_25_112907_create_personal_access_tokens_table', 2),
(5, '2025_11_25_115552_create_cv_analyses_table', 3),
(6, '2025_11_25_115552_create_cv_uploads_table', 3),
(7, '2025_11_26_184429_create_cv_conversations_table', 4);

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 2, 'auth_token', 'ac310e48af8aa4eb338533180352d662173816354d0c0b32ecb33e0ae0425c48', '[\"*\"]', NULL, NULL, '2025-11-25 10:45:02', '2025-11-25 10:45:02'),
(2, 'App\\Models\\User', 2, 'auth_token', '568acbb16c8cb07cc26c4413669c7aa59e9cd5563a0cbdfa5c8d23afd6817b1b', '[\"*\"]', '2025-11-25 11:36:09', NULL, '2025-11-25 11:11:00', '2025-11-25 11:36:09'),
(3, 'App\\Models\\User', 2, 'auth_token', '95fbee924d2d17fc6842bd16cadaa5b2d16028c4abe5abd3a4c4ee4c925c7a22', '[\"*\"]', '2025-11-25 18:10:35', NULL, '2025-11-25 18:10:16', '2025-11-25 18:10:35'),
(4, 'App\\Models\\User', 2, 'auth_token', '96302ffd6d57d03396791e37f80acf581abd76353dbc0bbd87c1ab7caf380476', '[\"*\"]', '2025-11-25 18:56:45', NULL, '2025-11-25 18:17:31', '2025-11-25 18:56:45'),
(5, 'App\\Models\\User', 2, 'auth_token', 'cfe79ad5aee2468ded239306bf7a46c6dc5d1fd4c7eac6aa4ff09a673bdd7be5', '[\"*\"]', '2025-11-25 19:11:51', NULL, '2025-11-25 19:00:16', '2025-11-25 19:11:51'),
(6, 'App\\Models\\User', 3, 'auth_token', '28ae137f8f32d4b3257ba785b16c83b5e892e8bbd3fc891e2fed62c24017d4bb', '[\"*\"]', '2025-11-25 21:30:32', NULL, '2025-11-25 20:39:30', '2025-11-25 21:30:32'),
(7, 'App\\Models\\User', 3, 'auth_token', '4982db22a1285ce076c3c65e1d04edcc395efb3a4c8ea58094e0640359145b8d', '[\"*\"]', '2025-11-26 18:07:02', NULL, '2025-11-26 17:28:56', '2025-11-26 18:07:02'),
(8, 'App\\Models\\User', 3, 'auth_token', 'e0b040e66d10b0270e47fea7d8fe1ed139ec619b8361f570cbe33d4b83319786', '[\"*\"]', '2025-11-26 18:14:52', NULL, '2025-11-26 18:14:52', '2025-11-26 18:14:52'),
(9, 'App\\Models\\User', 3, 'auth_token', 'faf2ee55bf328e1f1d415b9ed60304ce0fbf21591a4329a7cd16809d3be1ea5b', '[\"*\"]', '2025-11-26 18:21:51', NULL, '2025-11-26 18:18:20', '2025-11-26 18:21:51'),
(10, 'App\\Models\\User', 3, 'auth_token', '68d267c09a7c7a78af117c9904ed1f1bf9b85cf5b44a15c8164cf882c511630f', '[\"*\"]', '2025-11-26 18:24:35', NULL, '2025-11-26 18:23:39', '2025-11-26 18:24:35'),
(11, 'App\\Models\\User', 2, 'auth_token', '4a61c09637c333ef4f915b44565c96573cb2eb3c858c665b19f38a6fbd001e9e', '[\"*\"]', '2025-11-26 18:26:01', NULL, '2025-11-26 18:26:01', '2025-11-26 18:26:01'),
(12, 'App\\Models\\User', 3, 'auth_token', '9d9c760fbc221bb4de9036632eb9db3c7ee346896d5fe2109cc3795324f5550c', '[\"*\"]', '2025-11-26 18:30:00', NULL, '2025-11-26 18:30:00', '2025-11-26 18:30:00'),
(13, 'App\\Models\\User', 2, 'auth_token', '93c6627274d95b6aa595df3558732cf943359ce0b6736636aff976fb5cb369b2', '[\"*\"]', '2025-11-26 18:39:42', NULL, '2025-11-26 18:31:39', '2025-11-26 18:39:42'),
(14, 'App\\Models\\User', 3, 'auth_token', 'ac40f6afceb3cf5016ab57e70c850d3c221a6cc5f4a2d2aaf98769afdfba7037', '[\"*\"]', '2025-11-26 18:43:05', NULL, '2025-11-26 18:40:40', '2025-11-26 18:43:05'),
(15, 'App\\Models\\User', 4, 'auth_token', 'f22ee609bdaab8ed57bd35dd740c7730f7fbe36df896dbedca7ddc9c307f4545', '[\"*\"]', '2025-11-27 07:44:29', NULL, '2025-11-27 07:44:13', '2025-11-27 07:44:29');

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Test User', 'test@example.com', NULL, '$2y$12$0rt6APbMBRGicEeRwI1wI.cXQqWjFFsdcdsGRzTZ7UWNFx5iizP8e', NULL, '2025-11-25 10:30:47', '2025-11-25 10:30:47'),
(2, 'abdo', 'aa@gmail.com', NULL, '$2y$12$wlZWVKYLMbkzQBoROwZLNeO0J1C.LsXCtkdZuvierYdkwYei6TGJe', NULL, '2025-11-25 10:44:48', '2025-11-25 10:44:48'),
(3, 'hiba', 'hibaabdo@gmail.com', NULL, '$2y$12$k.sX7ZXE1qwB8HS6IZVgYOvxJEy4oJIgh3ocbm4RzO9QlAI1wvBxm', NULL, '2025-11-25 20:39:17', '2025-11-25 20:39:17'),
(4, 'sersif abdeljalil', 'abdosarsif28@gmail.com', NULL, '$2y$12$.vVi2Ih8BtcN4qYmuCu2E.I7jdy2EyTZ/l.02X1H4eo.npLm8SRYe', NULL, '2025-11-27 07:44:02', '2025-11-27 07:44:02');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `cv_analyses`
--
ALTER TABLE `cv_analyses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cv_analyses_cv_upload_id_foreign` (`cv_upload_id`),
  ADD KEY `cv_analyses_user_id_foreign` (`user_id`);

--
-- Index pour la table `cv_conversations`
--
ALTER TABLE `cv_conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cv_conversations_user_id_foreign` (`user_id`),
  ADD KEY `cv_conversations_cv_analysis_id_foreign` (`cv_analysis_id`);

--
-- Index pour la table `cv_uploads`
--
ALTER TABLE `cv_uploads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cv_uploads_user_id_foreign` (`user_id`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Index pour la table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `cv_analyses`
--
ALTER TABLE `cv_analyses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `cv_conversations`
--
ALTER TABLE `cv_conversations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `cv_uploads`
--
ALTER TABLE `cv_uploads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `cv_analyses`
--
ALTER TABLE `cv_analyses`
  ADD CONSTRAINT `cv_analyses_cv_upload_id_foreign` FOREIGN KEY (`cv_upload_id`) REFERENCES `cv_uploads` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cv_analyses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cv_conversations`
--
ALTER TABLE `cv_conversations`
  ADD CONSTRAINT `cv_conversations_cv_analysis_id_foreign` FOREIGN KEY (`cv_analysis_id`) REFERENCES `cv_analyses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cv_conversations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cv_uploads`
--
ALTER TABLE `cv_uploads`
  ADD CONSTRAINT `cv_uploads_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
