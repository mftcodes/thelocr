USE minuchin;

DROP TEMPORARY TABLE IF EXISTS NewResources;

-- Setup temporary table to insert new resources into
CREATE TEMPORARY TABLE NewResources (
	title VARCHAR(100),
    rdesc VARCHAR(2000),
    url VARCHAR(500),
    isParent BIT(1),
    parentUuid BINARY(16),
    isStatewide BIT(1),
    isNationwide BIT(1),
    line1 VARCHAR(100),
    line2 VARCHAR(100),
    city VARCHAR(100),
    county VARCHAR(50),
    state VARCHAR(100),
    postalCode VARCHAR(25),
    phone1 VARCHAR(25),
    phone2 VARCHAR(25),
    phoneTty VARCHAR(25),
    fax VARCHAR(25),
    email VARCHAR(255),
    categoryID INT
);


-- Insert New Resoureces into Temp Table, will loop through these.
INSERT INTO NewResources (title, rdesc, url, isParent, parentUuid, isStatewide, isNationwide, line1, line2, city, state, county, postalCode, phone1, phone2, phoneTty, fax, email, categoryID)
VALUES
    ('TitleHere', 'DescHere', 'UrlHere', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'CityHere', 'County', 'StateHere', 'PostalCodeHere', 'Phone1Here', 'Phone2Here', 'PhoneTtyHere', 'FaxHere', 'EmailHere', 23),
    ('TitleHere', 'DescHere', 'UrlHere', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'CityHere', 'County', 'StateHere', 'PostalCodeHere', 'Phone1Here', 'Phone2Here', 'PhoneTtyHere', 'FaxHere', 'EmailHere', 23);

-- More Local Variables to help us
-- DECLARE CreatedBy varchar(50) DEFAULT 'jeffcodes';
SET @Created := 'jeffcodes';

-- Loop through each entry in the table variable
DROP PROCEDURE IF EXISTS ImportResources;

DELIMITER $$

CREATE PROCEDURE ImportResources()
BEGIN
    DECLARE done INT DEFAULT FALSE;
	DECLARE v_title VARCHAR(100);
    DECLARE v_rdesc VARCHAR(2000);
    DECLARE v_url VARCHAR(500);
    DECLARE v_isParent BIT(1);
    DECLARE v_parentUuid BINARY(16);
    DECLARE v_isStatewide BIT(1);
    DECLARE v_isNationwide BIT(1);
    DECLARE v_line1 VARCHAR(100);
    DECLARE v_line2 VARCHAR(100);
    DECLARE v_city VARCHAR(100);
    DECLARE v_county VARCHAR(50);
    DECLARE v_state VARCHAR(100);
    DECLARE v_postalCode VARCHAR(25);
    DECLARE v_phone1 VARCHAR(25);
    DECLARE v_phone2 VARCHAR(25);
    DECLARE v_phoneTty VARCHAR(25);
    DECLARE v_fax VARCHAR(25);
    DECLARE v_email VARCHAR(255);
    DECLARE v_categoryID INT;

    DECLARE user_cursor CURSOR FOR
        SELECT title, rdesc, url, isParent, parentUuid, isStatewide, isNationwide, line1, line2, city, state, county, postalCode, phone1, phone2, phoneTty, fax, email, categoryID FROM NewResources;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN user_cursor;

    read_loop: LOOP
        FETCH user_cursor INTO v_title, v_rdesc, v_url, v_isParent, v_parentUuid, v_isStatewide, v_isNationwide, v_line1, v_line2, v_city, v_county, v_state, v_postalCode, v_phone1, v_phone2, v_phoneTty, v_fax, v_email, v_categoryID;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Insert with SProc
        CALL minuchin.sp_insertResource(@Created, v_title, v_rdesc, v_url, v_isParent, v_parentUuid, v_isStatewide, v_isNationwide, v_line1, v_line2, v_city, v_county, v_state, v_postalCode, v_phone1, v_phone2, v_phoneTty, v_fax, v_email, v_categoryID);
    END LOOP;

    CLOSE user_cursor;
END$$

DELIMITER ;

-- Call new procedure
CALL ImportResources();

-- Clean up
DROP PROCEDURE IF EXISTS ImportResources;
DROP TEMPORARY TABLE IF EXISTS NewResources;
