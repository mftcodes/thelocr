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
	DECLARE rUUID binary(16) DEFAULT '';
	DECLARE aUUID binary(16) DEFAULT '';
	DECLARE conUUID binary(16) DEFAULT '';
	DECLARE parentUUID varchar(36) DEFAULT null;

	IF rParentUUID = '' THEN
	   SET parentUUID = NULL;
	ELSE
	   SET parentUUID = uuid_to_bin(rParentUUID);
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


END;


CREATE DEFINER=`root`@`%` PROCEDURE `minuchin`.`sp_searchResourceBase`(
	IN isStatewide bit,
	IN county varchar(50),
	IN state varchar(100),
	IN categoryID int	
)
BEGIN
	
	SELECT BIN_TO_UUID(r.res_uuid) as res_uuid, r.res_title, r.res_desc, r.url, BIN_TO_UUID(a.addr_uuid) as addr_uuid, a.line_1, a.line_2, a.line_3, a.city, a.county, a.state, a.postal_code, BIN_TO_UUID(c.con_uuid) as con_uuid, c.phone_1, c.phone_2, c.phone_tty, c.fax, c.email
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
	WHERE a.addr_uuid = UUID_TO_BIN(addrUuid);


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
		addr_uuid = uuid_to_bin(addrUuid);
END;


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
	WHERE c.con_uuid = UUID_TO_BIN(conUuid);


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
		con_uuid = uuid_to_bin(conUuid);
END;


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
	WHERE r.res_uuid = UUID_TO_BIN(resUuid);


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
		res_uuid = uuid_to_bin(resUuid);
END;
