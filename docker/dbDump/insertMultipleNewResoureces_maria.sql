USE minuchin;

DROP TEMPORARY TABLE IF EXISTS NewResources;

-- Setup temporary table to insert new resources into
CREATE TEMPORARY TABLE NewResources (
	title VARCHAR(100),
    rdesc VARCHAR(2000),
    url VARCHAR(500),
    isParent BIT(1),
    parentUuid UUID,
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
    ('TitleHere', 'DescHere', 'UrlHere', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'CityHere', 'County', 'StateHere', 'PostalCodeHere', 'Phone1Here', 'Phone2Here', 'PhoneTtyHere', 'FaxHere', 'EmailHere', 23);	
    ('Network180', 'Network180 is the Kent County Community Mental Health Authority. We provide help to adults, youth, and families who need help with mental health, substance use or intellectual & developmental disabilities. Our Access Center is available 8:00 a.m.-8:00 p.m., Monday-Friday.', 'https://www.network180.org/', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'Grand Rapids', 'Kent', 'MI', '49503', '(616) 336-3909', '(800) 749-7720', '(800) 649-3777', 'FaxHere', 'EmailHere', 23),
    ('Heart of West Michigan United Way', 'A diverse network of local agencies and by collaborating with the local business community, we work to improve educational outcomes, address food insecurity, enable housing solutions, and support job training simultaneously.', 'https://www.hwmuw.org/211', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'Grand Rapids', 'Kent', 'MI', '49503', '211', '(616) 459-6281', 'PhoneTtyHere', 'FaxHere', 'EmailHere', 23);
    ('The Salvation Army Social Services-Housing Assessment Program', 'HAP is a community-driven resource rooted in a Housing First, strength-based approach (see our Housing Services Philosophy). We are here to connect people who are literally homeless or at imminent risk of homelessness to the best available housing resource in the community. We do this by completing assessments to better understand the needs of each person or family and then pair them with a housing service provider from the community, known as Housing Resource Specialists.', 'https://centralusa.salvationarmy.org/kentcounty/provide-housing/', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'Grand Rapids', 'Kent', 'MI', '49503', '(616)454-5840', 'Phone2Here', 'PhoneTtyHere', 'FaxHere', 'matt.adams@usc.salvationarmy.org', 23);	
    ('Dégagé Ministries', 'DescHere', 'https://degageministries.org/', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'Grand Rapids', 'Kent', 'MI', '49503', '(616) 454-1661', 'Phone2Here', 'PhoneTtyHere', 'FaxHere', 'info@degageministries.org', 23);	
    ('YWCA West Central Michigan', 'YWCA West Central Michigan is dedicated to eliminating racism, empowering women and girls, and promoting peace, justice, freedom, and dignity for all.', 'UrlHere', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'Grand Rapids', 'Kent', 'MI', '49503', '(616) 459-4681', 'Phone2Here', 'PhoneTtyHere', 'FaxHere', 'info@ywcawcmi.org', 23);	
    ('Center For Women In Transition', 'The Center''s mission is to respond to, reduce, and prevent domestic and sexual violence against women through education, collaboration, and advocacy.', 'UrlHere', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'Allegan', 'Allegan', 'MI', '49010', '(269) 673-2299', 'Phone2Here', 'PhoneTtyHere', 'FaxHere', 'EmailHere', 23);	
    ('Every Womans Place Inc', 'Every Woman''s Place provides services for victims and survivors of domestic violence, sexual assault, and sex trafficking.', 'https://everywomansplace.org/', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'Muskegon', 'Muskegon', 'MI', '49441', '(231) 722-3333', 'Phone2Here', 'PhoneTtyHere', 'FaxHere', 'EmailHere', 23);	
    ('AYA Youth Collective', 'We recognize there are gaps and barriers in our community that prevent youth from accessing and fully taking advantage of opportunities. This is where our resources meet them. ', 'https://ayayouth.org/', 1, 'ParentUuidHere', 0, 0, 'Line1Here', 'Line2Here', 'Grand Rapids', 'Kent', 'MI', '49503', '(616) 406-3945', 'Phone2Here', 'PhoneTtyHere', 'FaxHere', 'info@ayayouth.org', 23);	


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
    DECLARE v_parentUuid UUID;
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
