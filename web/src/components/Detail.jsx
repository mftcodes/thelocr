import { useLocation, Link } from "react-router-dom";
import Button from "./Button";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";
import Row from "react-bootstrap/Row";

export default function Detail() {
  const location = useLocation();
  const resource = location.state;

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
      <Container style={{ maxWidth: "50rem" }}>
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
                <strong>Office/Suite</strong>
              </Col>
              <Col sm={10}>{addrLines.String}</Col>
            </Row>
          )}
        </div>
        <h3>Contact</h3>
        <hr />
        <div>
          {resource.Url.Valid && (
            <Row>
              <Col sm={2}>
                <strong>Website</strong>
              </Col>
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
          )}
          {resource.Phone_1.Valid && (
            <Row>
              <Col sm={2}>
                <strong>Main Phone #</strong>
              </Col>
              <Col sm={10}>
                <a href={"tel:" + resource.Phone_1.String}>
                  {resource.Phone_1.String}
                </a>
              </Col>
            </Row>
          )}
          {resource.Phone_2.Valid && (
            <Row>
              <Col sm={2}>
                <strong>Alternate Phone #</strong>
              </Col>
              <Col sm={10}>
                <a href={"tel:" + resource.Phone_2.String}>
                  {resource.Phone_2.String}
                </a>
              </Col>
            </Row>
          )}
          {resource.Phone_tty.Valid && (
            <Row>
              <Col sm={2}>
                <strong>TTY Phone #</strong>
              </Col>
              <Col sm={10}>
                <a href={"tel:" + resource.Phone_tty.String}>
                  {resource.Phone_tty.String}
                </a>
              </Col>
            </Row>
          )}
          {resource.Fax.Valid && (
            <Row>
              <Col sm={2}>
                <strong>Fax:</strong>
              </Col>
              <Col sm={10}>{resource.Fax.String}</Col>
            </Row>
          )}
          {resource.Email.Valid && (
            <Row>
              <Col sm={2}>
                <strong>Email</strong>
              </Col>
              <Col sm={10}>
                <a href={"mailto:" + resource.Email.String}>
                  {resource.Email.String}
                </a>
              </Col>
            </Row>
          )}
        </div>

        <Row className="pt-4 text-center">
          <Link to={"/edit"} state={resource}>
            <Button type="bowen__alt">Edit</Button>
          </Link>
        </Row>
      </Container>
    </>
  );
}
