-- minuchin.`user` definition

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_uuid` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `user_email` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `password` char(60) NOT NULL,
  `can_edit` bit(1) NOT NULL DEFAULT b'1',
  `created` datetime NOT NULL DEFAULT (now()),
  `modified` datetime DEFAULT NULL,
  `modified_by` binary(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uc__uuid` (`user_uuid`),
  UNIQUE KEY `uc__user_email` (`user_email`),
  UNIQUE KEY `uc__username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- minuchin.address definition

CREATE TABLE `address` (
  `addr_id` int NOT NULL AUTO_INCREMENT,
  `addr_uuid` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `line_1` varchar(100) NOT NULL,
  `line_2` varchar(100) DEFAULT NULL,
  `line_3` varchar(100) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `county` varchar(50) DEFAULT NULL,
  `state` varchar(100) NOT NULL,
  `postal_code` varchar(25) NOT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`addr_id`),
  UNIQUE KEY `uc__addr_uuid` (`addr_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- minuchin.addr_history definition

CREATE TABLE `addr_history` (
  `addr_hist_id` int NOT NULL AUTO_INCREMENT,
  `addr_uuid` binary(16) NOT NULL,
  `line_1` varchar(100) NOT NULL,
  `line_2` varchar(100) DEFAULT NULL,
  `line_3` varchar(100) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `county` varchar(50) DEFAULT NULL,
  `state` varchar(100) NOT NULL,
  `postal_code` varchar(25) NOT NULL,
  `modified` datetime NOT NULL DEFAULT (now()),
  `modified_by` varchar(50) NOT NULL,
  PRIMARY KEY (`addr_hist_id`),
  KEY `fk__addrhist_addruuid__addr_uuid` (`addr_uuid`),
  CONSTRAINT `fk__addrhist_addruuid__addr_uuid` FOREIGN KEY (`addr_uuid`) REFERENCES `address` (`addr_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- minuchin.category definition

CREATE TABLE `category` (
  `cat_id` int NOT NULL AUTO_INCREMENT,
  `cat_title` varchar(50) NOT NULL,
  `cat_desc` varchar(250) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `uc__cat_title` (`cat_title`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- minuchin.contact definition

CREATE TABLE `contact` (
  `con_id` int NOT NULL AUTO_INCREMENT,
  `con_uuid` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `phone_1` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone_2` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone_tty` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`con_id`),
  UNIQUE KEY `uc__con_uuid` (`con_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--- minuchin.con_history definition

CREATE TABLE `con_history` (
  `con_hist_id` int NOT NULL AUTO_INCREMENT,
  `con_uuid` binary(16) NOT NULL,
  `phone_prime` varchar(25) DEFAULT NULL,
  `phone_second` varchar(25) DEFAULT NULL,
  `phone_tty` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `modified` datetime DEFAULT (now()),
  `modified_by` varchar(50) NOT NULL,
  PRIMARY KEY (`con_hist_id`),
  KEY `fk__conhist_con_uuid__contact_uuid` (`con_uuid`),
  CONSTRAINT `fk__conhist_con_uuid__contact_uuid` FOREIGN KEY (`con_uuid`) REFERENCES `contact` (`con_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
- minuchin.detail definition


-- minuchin.res_history definition

CREATE TABLE `res_history` (
  `res_hist_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL,
  `res_hist_title` varchar(100) NOT NULL,
  `res_hist_desc` varchar(2000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT b'0',
  `parent_uuid` binary(16) DEFAULT NULL,
  `is_statewide` bit(1) DEFAULT b'0',
  `is_nationwide` bit(1) DEFAULT b'0',
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`res_hist_id`),
  KEY `fk__reshist_resuuid__res_uuid` (`res_uuid`),
  CONSTRAINT `fk__reshist_resuuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- minuchin.resource definition

CREATE TABLE `resource` (
  `res_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `res_title` varchar(100) NOT NULL,
  `res_desc` varchar(2000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `is_parent` bit(1) NOT NULL DEFAULT b'1',
  `parent_uuid` binary(16) DEFAULT NULL,
  `is_statewide` bit(1) DEFAULT b'0',
  `is_nationwide` bit(1) DEFAULT b'0',
  `keyword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT (now()),
  `created_by` varchar(50) NOT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`res_id`),
  UNIQUE KEY `uc__res_uuid` (`res_uuid`),
  UNIQUE KEY `uc__res_title` (`res_title`),
  KEY `idx__res_keyword` (`keyword`),
  KEY `idx__is_statewide` (`is_statewide`),
  KEY `idx__is_nationwide` (`is_nationwide`),
  KEY `idx__res_parent_uuid` (`parent_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- minuchin.detail definition

CREATE TABLE `detail` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL,
  `addr_uuid` binary(16) DEFAULT NULL,
  `con_uuid` binary(16) DEFAULT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `fk__det_res_uuid__res_uuid` (`res_uuid`),
  KEY `fk__det_addr_uuid__addr_uuid` (`addr_uuid`),
  KEY `fk__det_con_uuid__contact_uuid` (`con_uuid`),
  CONSTRAINT `fk__det_addr_uuid__addr_uuid` FOREIGN KEY (`addr_uuid`) REFERENCES `address` (`addr_uuid`),
  CONSTRAINT `fk__det_con_uuid__contact_uuid` FOREIGN KEY (`con_uuid`) REFERENCES `contact` (`con_uuid`),
  CONSTRAINT `fk__det_res_uuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- minuchin.classification definition

CREATE TABLE `classification` (
  `class_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` binary(16) NOT NULL,
  `cat_id` int NOT NULL,
  PRIMARY KEY (`class_id`),
  KEY `fk__class_res_uuid__res_uuid` (`res_uuid`),
  KEY `fk__class_cat_id__cat_id` (`cat_id`),
  CONSTRAINT `fk__class_cat_id__cat_id` FOREIGN KEY (`cat_id`) REFERENCES `category` (`cat_id`),
  CONSTRAINT `fk__class_res_uuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- minuchin.edit definition

CREATE TABLE `edit` (
  `edit_id` int NOT NULL AUTO_INCREMENT,
  `user_uuid` binary(16) NOT NULL,
  `res_uuid` binary(16) NOT NULL,
  PRIMARY KEY (`edit_id`),
  KEY `fk__edit_useruuid__user_uuid` (`user_uuid`),
  KEY `fk__edit_resuuid__res_uuid` (`res_uuid`),
  CONSTRAINT `fk__edit_resuuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`),
  CONSTRAINT `fk__edit_useruuid__user_uuid` FOREIGN KEY (`user_uuid`) REFERENCES `user` (`user_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
