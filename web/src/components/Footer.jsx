import React from "react";
import { useNavigate } from "react-router-dom";
import Container from "react-bootstrap/Container";
import Button from "../components/Button";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import Row from "react-bootstrap/esm/Row";
import Col from "react-bootstrap/esm/Col";

export const Footer = () => {
  let navigate = useNavigate();
  const goSearch = () => {
    navigate("/search");
  }
  const goAbout = () => {
    navigate("/about");
  }
  const goPrivacy = () => {
    navigate("/privacy");
  }

  const d = new Date();
  let year = d.getFullYear();

  return (
    <>
      <footer id="footer" className="text-center">
        <Container className="stage">
          <Row className="text-center">
            <Col> </Col>
            <Col><Button type="thelocr btn_thelocr__footer" doClick={() => goSearch()}>Search</Button></Col>
            <Col><Button type="thelocr btn_thelocr__footer" doClick={() => goPrivacy()}>Privacy Policy</Button></Col>
            <Col><Button type="thelocr btn_thelocr__footer" doClick={() => goAbout()}>About</Button></Col>
            <Col> </Col>
          </Row>
          <Row className="mt-1">
            <Col>Copyright <FontAwesomeIcon icon="copyright" /> {year} </Col>
          </Row>
        </Container>
      </footer>
    </>
  )
}
