import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";
import Row from "react-bootstrap/Row";

const Detail = (resource) => {
  resource = JSON.parse(`{
    "Res_uuid": "6e488845-83db-11ee-b608-0242ac120002",
    "Res_title": {
        "String": "Be Well Services (Main Office)",
        "Valid": true
    },
    "Res_desc": {
        "String": "Therapy, psychiatry, SUD, testing, chilren, families... you name it, we got it covered!",
        "Valid": true
    },
    "Url": {
        "String": "www.bewellflint.org",
        "Valid": true
    },
    "Addr_uuid": "6e4a13d1-83db-11ee-b608-0242ac120002",
    "Line_1": {
        "String": "9887 Saginaw St",
        "Valid": true
    },
    "Line_2": {
        "String": "Suite 402",
        "Valid": true
    },
    "Line_3": {
        "String": "Fourth Floor",
        "Valid": true
    },
    "City": {
        "String": "Flint",
        "Valid": true
    },
    "County": {
        "String": "Genesee",
        "Valid": true
    },
    "State": {
        "String": "MI",
        "Valid": true
    },
    "Postal_code": {
        "String": "48503",
        "Valid": true
    },
    "Con_uuid": "6e4b53c5-83db-11ee-b608-0242ac120002",
    "Phone_1": {
        "String": "810.555.3444",
        "Valid": true
    },
    "Phone_2": {
        "String": "810.555.9088",
        "Valid": true
    },
    "Phone_tty": {
        "String": "810.555.3455",
        "Valid": true
    },
    "Fax": {
        "String": "810.555.3449",
        "Valid": true
    },
    "Email": {
        "String": "info@bewellflint.org",
        "Valid": true
    }
}`);
  const address = `${resource.Line_1.String}, ${resource.City.String}, ${resource.State.String} ${resource.Postal_code.String}`;
  const addrLines =
    resource.Line_2.Valid && resource.Line_3.Valid
      ? JSON.parse(`{
        "String": "${resource.Line_2.String}, ${resource.Line_3.String}",
        "Valid": true
      }`)
      : resource.Line_2.Valid
      ? JSON.parse(`{
        "String": "${resource.Line_2.String}",
        "Valid": true
      }`)
      : JSON.parse(`{
        "String": "",
        "Valid": false
      }`);

  return (
    <>
      <h2 className="text-center search pb-3 pt-2">
        {resource.Res_title.String}
      </h2>
      <Container>
        <h3>Description</h3>
        <hr />
        <p className="pb-3">{resource.Res_desc.String}</p>
        <h3>Address</h3>
        <hr />
        <div className="pb-3">
          <Row>
            <a
              href={"https://maps.google.com/?q=" + address}
              target="_blank"
              rel="noreferrer"
            >
              {address}
            </a>
          </Row>
          {addrLines.Valid && (
            <Row className="pt-2">
              <Col sm={2}>
                <strong>Office/Suite:</strong>
              </Col>
              <Col sm={10}>{addrLines.String}</Col>
            </Row>
          )}
        </div>
        <h3>Contact</h3>
        <hr />
        <div>
          <Row>
            <Col sm={2}>Website:</Col>
            <Col sm={10}>
              <a
                href={"https://" + resource.Url.String}
                target="_blank"
                rel="noreferrer"
              >
                {resource.Url.String}
              </a>
            </Col>
          </Row>
          <Row>
            <Col sm={2}>Phone 1:</Col>
            <Col sm={10}>
              <a href={"tel:" + resource.Phone_1.String}>
                {resource.Phone_1.String}
              </a>
            </Col>
          </Row>
          <Row>
            <Col sm={2}>Phone Alt:</Col>
            <Col sm={10}>
              <a href={"tel:" + resource.Phone_2.String}>
                {resource.Phone_2.String}
              </a>
            </Col>
          </Row>
          <Row>
            <Col sm={2}>Phone TTY:</Col>
            <Col sm={10}>
              <a href={"tel:" + resource.Phone_tty.String}>
                {resource.Phone_tty.String}
              </a>
            </Col>
          </Row>
          <Row>
            <Col sm={2}>Fax:</Col>
            <Col sm={10}>{resource.Fax.String}</Col>
          </Row>
          <Row>
            <Col sm={2}>Email:</Col>
            <Col sm={10}>
              <a href={"mailto:" + resource.Email.String}>
                {resource.Email.String}
              </a>
            </Col>
          </Row>
        </div>
      </Container>
    </>
  );
};

export default Detail;
