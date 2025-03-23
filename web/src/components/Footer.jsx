import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

export const Footer = () => {

  const d = new Date();
  let year = d.getFullYear();

  return (
    <>
      <footer id="footer">
        <div className="logo" />
        <p>
          Copyright <FontAwesomeIcon icon="copyright" className="mr-2" /> {year} 
        </p>
      </footer>
    </>
  )
}
