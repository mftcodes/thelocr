import { useState, useEffect } from "react";
import { useLocation, useParams, Link } from "react-router-dom";
import Button from "../components/Button";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";
import Row from "react-bootstrap/Row";
import { useAuth0 } from "@auth0/auth0-react";
import logger from "../utils/logger";

export default function Detail() {
  const { isAuthenticated } = useAuth0();
  const id = useParams();
  const hasId = Object.keys(id).length !== 0;
  const uri = hasId ? `${import.meta.env.VITE_API_URI}/api/resource/${id.id}` : "";
  const location = useLocation();
  const locState = location.state != 0 ? location.state : {};
  let [resource, setResource] = useState({
      "Res_uuid": "00000000-0000-0000-0000-000000000000",
      "Res_title": {"String": "","Valid": false},
      "Res_desc": {"String": "","Valid": false},
      "Url": {"String": "","Valid": false},
      "Addr_uuid": "00000000-0000-0000-0000-000000000000",
      "Line_1": {"String": "","Valid": false},
      "Line_2": {"String": "","Valid": false},
      "Line_3": {"String": "","Valid": false},
      "City": {"String": "","Valid": false},
      "County": {"String": "","Valid": false},
      "State": {"String": "","Valid": false},
      "Postal_code": {"String": "","Valid": false},
      "Con_uuid": "00000000-0000-0000-0000-000000000000",
      "Phone_1": {"String": "","Valid": false},
      "Phone_2": {"String": "","Valid": false},
      "Phone_tty": {"String": "","Valid": false},
      "Fax": {"String": "","Valid": false},
      "Email": {"String": "","Valid": false}
    }
  );
  const [address, setAddress] = useState({"String": "","Valid": false});
  const [addrLines, setAddrLines] = useState({"String": "","Valid": false});

  async function getData() {
    try {
      if (hasId) {
        await Promise.all([
          (
              await fetch(uri).then((res) => {
                if (!res.ok) {
                  throw new Error(`HTTP error: ${res.status}`);
                }
                return res.json();
              }).then((data) => {
                setResource(data);
                setAddressInfo(data);
              })
          ),
        ]);
      } else {
        setResource(locState);
        setAddressInfo(locState);
      }
    } catch (error) {
      logger.error(`Details.jsx: Error fetching resource ById - ${error}`);
    }
  }

  useEffect(() => {
    getData();
  }, []);

  function setAddressInfo(tempRes) {
    if (tempRes.Line_1.Valid) {
      setAddress({"String": `${tempRes.Line_1.String}, ${tempRes.City.String}, ${tempRes.State.String} ${tempRes.Postal_code.String}`,"Valid": true});
    }

    if (tempRes.Line_2.Valid && tempRes.Line_3.Valid) {
      setAddrLines({"String": `${tempRes.Line_2.String}, ${tempRes.Line_3.String}`,"Valid": true});
    } else if (tempRes.Line_2.Valid) {
      setAddrLines({"String": `${tempRes.Line_2.String}`,"Valid": true});
    } else {
      setAddrLines({"String": "","Valid": false});
    }
  }

  return (
    <>
      {!resource.Res_title.Valid && (
        <h1 className="text-center search pb-3 pt-2">
          Loading...
        </h1>
      )}
      {resource.Res_title.Valid && (
        <Container>
          <h1 className="text-center">
            {resource.Res_title.String}
          </h1>
          <h3>Description</h3>
          <hr />
          <p className="pb-3">{resource.Res_desc.String}</p>
          <h3>Address</h3>
          <hr />
          <div className="pb-3">
            {address.Valid && (
              <Row>
                <a
                  href={"https://maps.google.com/?q=" + address.String}
                  target="_blank"
                  rel="noreferrer"
                >
                  {address.String}
                </a>
              </Row>
            )}
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

          {isAuthenticated &&
            <Row className="pt-4 text-center">
              <Link to={"/edit"} state={resource}>
                <Button type="thelocr__alt">Edit</Button>
              </Link>
            </Row>
          }
        </Container>
      )}
    </>
  );
}
