import React from "react";
import Container from "react-bootstrap/Container";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

export const Footer = () => {

  const d = new Date();
  let year = d.getFullYear();

  return (
    <>
      <footer id="footer" className="text-center">
        <Container className="stage">
          <p>
            Copyright <FontAwesomeIcon icon="copyright" className="mr-2" /> {year} 
          </p>
        </Container>
      </footer>
    </>
  )
}
