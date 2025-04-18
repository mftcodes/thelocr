CREATE DATABASE minuchin;

USE minuchin;

/* ADDRESS TABLES */
DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
  `addr_id` int NOT NULL AUTO_INCREMENT,
  `addr_uuid` uuid NOT NULL DEFAULT (uuid()),
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;


DROP TABLE IF EXISTS `addr_history`;

CREATE TABLE `addr_history` (
  `addr_hist_id` int NOT NULL AUTO_INCREMENT,
  `addr_uuid` uuid NOT NULL,
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


/* CATEGORY TABLES */
DROP TABLE IF EXISTS `category`;

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* RESOURCE TABLES */
DROP TABLE IF EXISTS `resource`;

CREATE TABLE `resource` (
  `res_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` uuid NOT NULL DEFAULT (uuid()),
  `res_title` varchar(100) NOT NULL,
  `res_desc` varchar(2000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `is_parent` bit(1) NOT NULL DEFAULT b'1',
  `parent_uuid` uuid DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `res_history`;

CREATE TABLE `res_history` (
  `res_hist_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` uuid NOT NULL,
  `res_hist_title` varchar(100) NOT NULL,
  `res_hist_desc` varchar(2000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT b'0',
  `parent_uuid` uuid DEFAULT NULL,
  `is_statewide` bit(1) DEFAULT b'0',
  `is_nationwide` bit(1) DEFAULT b'0',
  `modified` datetime DEFAULT NULL,
  `modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`res_hist_id`),
  KEY `fk__reshist_resuuid__res_uuid` (`res_uuid`),
  CONSTRAINT `fk__reshist_resuuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* CLASSIFICATION TABLES */
DROP TABLE IF EXISTS `classification`;

CREATE TABLE `classification` (
  `class_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` uuid NOT NULL,
  `cat_id` int NOT NULL,
  PRIMARY KEY (`class_id`),
  KEY `fk__class_res_uuid__res_uuid` (`res_uuid`),
  KEY `fk__class_cat_id__cat_id` (`cat_id`),
  CONSTRAINT `fk__class_cat_id__cat_id` FOREIGN KEY (`cat_id`) REFERENCES `category` (`cat_id`),
  CONSTRAINT `fk__class_res_uuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* CONTACTS TABLES */
DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `con_id` int NOT NULL AUTO_INCREMENT,
  `con_uuid` uuid NOT NULL DEFAULT (uuid()),
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `con_history`;

CREATE TABLE `con_history` (
  `con_hist_id` int NOT NULL AUTO_INCREMENT,
  `con_uuid` uuid NOT NULL,
  `phone_1` varchar(25) DEFAULT NULL,
  `phone_2` varchar(25) DEFAULT NULL,
  `phone_tty` varchar(25) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `modified` datetime DEFAULT (now()),
  `modified_by` varchar(50) NOT NULL,
  PRIMARY KEY (`con_hist_id`),
  KEY `fk__conhist_con_uuid__contact_uuid` (`con_uuid`),
  CONSTRAINT `fk__conhist_con_uuid__contact_uuid` FOREIGN KEY (`con_uuid`) REFERENCES `contact` (`con_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* DETAIL TABLES */
DROP TABLE IF EXISTS `detail`;

CREATE TABLE `detail` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `res_uuid` uuid NOT NULL,
  `addr_uuid` uuid DEFAULT NULL,
  `con_uuid` uuid DEFAULT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `fk__det_res_uuid__res_uuid` (`res_uuid`),
  KEY `fk__det_addr_uuid__addr_uuid` (`addr_uuid`),
  KEY `fk__det_con_uuid__contact_uuid` (`con_uuid`),
  CONSTRAINT `fk__det_addr_uuid__addr_uuid` FOREIGN KEY (`addr_uuid`) REFERENCES `address` (`addr_uuid`),
  CONSTRAINT `fk__det_con_uuid__contact_uuid` FOREIGN KEY (`con_uuid`) REFERENCES `contact` (`con_uuid`),
  CONSTRAINT `fk__det_res_uuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* USER TABLES */
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_uuid` uuid NOT NULL DEFAULT (uuid()),
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


/* EDIT TABLES */
DROP TABLE IF EXISTS `edit`;

CREATE TABLE `edit` (
  `edit_id` int NOT NULL AUTO_INCREMENT,
  `user_uuid` uuid NOT NULL,
  `res_uuid` uuid NOT NULL,
  PRIMARY KEY (`edit_id`),
  KEY `fk__edit_useruuid__user_uuid` (`user_uuid`),
  KEY `fk__edit_resuuid__res_uuid` (`res_uuid`),
  CONSTRAINT `fk__edit_resuuid__res_uuid` FOREIGN KEY (`res_uuid`) REFERENCES `resource` (`res_uuid`),
  CONSTRAINT `fk__edit_useruuid__user_uuid` FOREIGN KEY (`user_uuid`) REFERENCES `user` (`user_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



/* STORED PROCEDURES */

	/* Insert Resource */
DROP PROCEDURE IF EXISTS `minuchin`.`sp_insertResource`;

CREATE DEFINER=`root`@`%` PROCEDURE `minuchin`.`sp_insertResource`(
	IN createdBy varchar(50),
	IN rTitle varchar(100),
	IN rDesc varchar(2000),
	IN rUrl varchar(500),
	IN rIsParent bit,
	IN rParentUUID varchar(36),
	IN rIsStatewide bit,
	IN rKeyword varchar(100),
	IN aLine1 varchar(100),
	IN aLine2 varchar(100),
	IN aCity varchar(100),
	IN aCounty varchar(50),
	IN aState varchar(100),
	IN aPostalCode varchar(25),
	IN cPhone1 varchar(100),
	IN cPhone2 varchar(100),
	IN cPhonetty varchar(100),
	IN cFax varchar(100),
	IN cEmail varchar(100),
	IN categoryID int	
)
BEGIN
	DECLARE rUUID uuid DEFAULT null;
	DECLARE aUUID uuid DEFAULT null;
	DECLARE conUUID uuid DEFAULT null;
	DECLARE parentUUID varchar(36) DEFAULT null;

	IF rParentUUID = '' THEN
	   SET parentUUID = NULL;
	ELSE
	   SET parentUUID = rParentUUID;
	END IF;

	INSERT INTO minuchin.resource
		(res_title, res_desc, url, is_parent, parent_uuid, is_statewide, keyword, created_by)
	VALUES
		(rTitle, rDesc, rUrl, rIsParent, rParentUUID, rIsStatewide, rKeyword, createdBy);
	SET rUUID = ( SELECT r.res_uuid FROM minuchin.resource r WHERE r.res_id = LAST_INSERT_ID() );
	
	
	
	INSERT INTO minuchin.address
		(line_1, line_2, city, county, state, postal_code, created_by)
	VALUES
		(aLine1, aLine2, aCity, aCounty, aState, aPostalCode, createdBy);
	SET aUUID = ( SELECT a.addr_uuid FROM minuchin.address a WHERE a.addr_id = LAST_INSERT_ID() );
	
	
	INSERT INTO minuchin.contact
		(phone_1, phone_2, phone_tty, fax, email, created_by)
	VALUES
		(cPhone1, cPhone2, cPhonetty, cFax, cEmail, createdBy);
	SET conUUID = ( SELECT c.con_uuid FROM minuchin.contact c WHERE c.con_id = LAST_INSERT_ID() );
	
	
	INSERT INTO minuchin.detail
		(res_uuid, addr_uuid, con_uuid)
	VALUES
		(rUUID, aUUID, conUUID);
	
	INSERT INTO minuchin.classification
		(res_uuid, cat_id)
	VALUES
		(rUUID,categoryID);
	
	SELECT rUUID;
END;


	/* Search Resource Base */
DROP PROCEDURE IF EXISTS `minuchin`.`sp_searchResourceBase`;

CREATE DEFINER=`root`@`%` PROCEDURE `minuchin`.`sp_searchResourceBase`(
	IN isStatewide bit,
	IN county varchar(50),
	IN state varchar(100),
	IN categoryID int	
)

BEGIN	
	SELECT r.res_uuid, r.res_title, r.res_desc, r.url, a.addr_uuid, a.line_1, a.line_2, a.line_3, a.city, a.county, a.state, a.postal_code, c.con_uuid, c.phone_1, c.phone_2, c.phone_tty, c.fax, c.email
	  FROM minuchin.resource as r
		JOIN minuchin.detail as d on r.res_uuid = d.res_uuid
		JOIN minuchin.address as a on d.addr_uuid = a.addr_uuid
		JOIN minuchin.contact as c on d.con_uuid = c.con_uuid
		JOIN minuchin.classification as cl on r.res_uuid = cl.res_uuid
		RIGHT JOIN minuchin.category as ct on cl.cat_id = ct.cat_id AND ct.cat_id = categoryID
	 WHERE a.county = county
	   AND a.state = state
	   OR r.is_statewide = isStatewide;
END;


	/* Update Address */
DROP PROCEDURE IF EXISTS `minuchin`.`sp_updateAddress`;

CREATE DEFINER=`root`@`%` PROCEDURE `minuchin`.`sp_updateAddress`(
	IN addrUuid varchar(36),
	IN line1 varchar(100),
	IN line2 varchar(100),
	IN line3 varchar(100),
	IN city varchar(100),
	IN county varchar(100),
	IN state varchar(100),
	IN postalCode varchar(25),
	IN modified datetime,
	IN modifiedBy varchar(50)
)
BEGIN
	DECLARE changeMade datetime DEFAULT NOW();

	IF NOT ISNULL(modified) THEN
	   SET changeMade = modified;
	END IF;

	INSERT INTO minuchin.addr_history
	(
		addr_uuid,
		line_1,
		line_2,
		line_3,
		city,
		county,
		state,
		postal_code,
		modified,
		modified_by
	)
	SELECT 
		a.addr_uuid,
		a.line_1,
		a.line_3,
		a.line_2,
		a.city,
		a.county,
		a.state,
		a.postal_code,
		changeMade as modified,
		modifiedBy as modified_by 
	FROM minuchin.address a
	WHERE a.addr_uuid = addrUuid;


	UPDATE minuchin.address
	SET 
		line_1=line1, 
		line_2=line2, 
		line_3=line3, 
		city=city, 
		county=county, 
		state=state , 
		postal_code=postalCode,
		modified=changeMade, 
		modified_by=modifiedBy
	WHERE 
		addr_uuid = addrUuid;
END;


	/* Update Contact */
DROP PROCEDURE IF EXISTS `minuchin`.`sp_updateContact`;

CREATE DEFINER=`root`@`%` PROCEDURE `minuchin`.`sp_updateContact`(
	IN conUuid varchar(36),
	IN phone1 varchar(100),
	IN phone2 varchar(100),
	IN phoneTty varchar(100),
	IN fax varchar(100),
	IN email varchar(255),
	IN modified datetime,
	IN modifiedBy varchar(50)
)
BEGIN
	DECLARE changeMade datetime DEFAULT NOW();

	IF NOT ISNULL(modified) THEN
	   SET changeMade = modified;
	END IF;

	INSERT INTO minuchin.con_history
	(
		con_uuid,
		phone_1,
		phone_2,
		phone_tty,
		fax,
		email,
		modified,
		modified_by
	)
	SELECT 
		c.con_uuid,
		c.phone_1,
		c.phone_2,
		c.phone_tty,
		c.fax,
		c.email,
		changeMade as modified,
		modifiedBy as modified_by 
	FROM minuchin.contact c
	WHERE c.con_uuid = conUuid;


	UPDATE minuchin.contact
	SET 
		phone_1=phone1, 
		phone_2=phone2, 
		phone_tty=phoneTty, 
		fax=fax, 
		email=email,
		modified=changeMade, 
		modified_by=modifiedBy
	WHERE 
		con_uuid = conUuid;
END;


	/* Update Resource */
DROP PROCEDURE IF EXISTS `minuchin`.`sp_updateResource`;

CREATE DEFINER=`root`@`%` PROCEDURE `minuchin`.`sp_updateResource`(
	IN resUuid varchar(36),
	IN resTitle varchar(100),
	IN resDesc varchar(2000),
	IN url varchar(500),
	IN isParent bit(1),
	IN parentUuid varchar(36),
	IN isStatewide bit(1),
	IN isNationwide bit(1),
	IN keyword varchar(100),
	IN modified datetime,
	IN modifiedBy varchar(50)
)
BEGIN
	DECLARE changeMade datetime DEFAULT NOW();

	IF NOT ISNULL(modified) THEN
	   SET changeMade = modified;
	END IF;

	INSERT INTO minuchin.res_history 
	(
		res_uuid,
		res_hist_title,
		res_hist_desc,
		url,
		is_parent,
		parent_uuid,
		is_statewide,
		is_nationwide,
		modified,
		modified_by
	)
	SELECT 
		r.res_uuid,
		r.res_title,
		r.res_desc,
		r.url,
		r.is_parent,
		r.parent_uuid,
		r.is_statewide,
		r.is_nationwide,
		changeMade as modified,
		modifiedBy as modified_by 
	FROM minuchin.resource r
	WHERE r.res_uuid = resUuid;


	UPDATE minuchin.resource
	SET 
		res_title=resTitle, 
		res_desc =resDesc, 
		url=url, 
		is_parent=isParent, 
		parent_uuid=parentUuid,
		is_statewide=isStatewide,
		is_nationwide=isNationwide,
		modified=changeMade, 
		modified_by=modifiedBy
	WHERE 
		res_uuid = resUuid;
END;


	/* Update Resource Detail */
DROP PROCEDURE IF EXISTS `minuchin`.`sp_updateFullResource`;

CREATE DEFINER=`root`@`%` PROCEDURE `minuchin`.`sp_updateFullResource`(
	IN addrUuid varchar(36),
	IN line1 varchar(100),
	IN line2 varchar(100),
	IN line3 varchar(100),
	IN city varchar(100),
	IN county varchar(100),
	IN state varchar(100),
	IN postalCode varchar(25),
	IN conUuid varchar(36),
	IN phone1 varchar(100),
	IN phone2 varchar(100),
	IN phoneTty varchar(100),
	IN fax varchar(100),
	IN email varchar(255),
	IN resUuid varchar(36),
	IN resTitle varchar(100),
	IN resDesc varchar(2000),
	IN url varchar(500),
	IN isParent bit(1),
	IN parentUuid varchar(36),
	IN isStatewide bit(1),
	IN isNationwide bit(1),
	IN keyword varchar(100),
	IN modified datetime,
	IN modifiedBy varchar(50)
)
BEGIN
	DECLARE changeMade datetime DEFAULT NOW();

	IF NOT ISNULL(modified) THEN
	   SET changeMade = modified;
	END IF;

	CALL minuchin.sp_updateAddress(
		addrUuid,
		line1,
		line2,
		line3,
		city,
		county,
		state,
		postalCode,
		changeMade,
		modifiedBy
	);
	
	CALL minuchin.sp_updateContact(
		conUuid, 
		phone1, 
		phone2, 
		phoneTty, 
		fax, 
		email, 
		changeMade,
		modifiedBy
	);
	
	CALL minuchin.sp_updateResource(
		resUuid, 
		resTitle, 
		resDesc, 
		url, 
		isParent, 
		parentUuid, 
		isStatewide, 
		isNationwide, 
		keyword, 
		changeMade,
		modifiedBy
	);
END;
