import React, { useState, useEffect } from "react";
import Dropdown from "react-bootstrap/Dropdown";
import Form from "react-bootstrap/Form";
import counties from "../assets/mi_counties.json"

const CountyDropdown = ({ label, onChoice }) => {
  // The forwardRef is important!!
  // Dropdown needs access to the DOM node in order to position the Menu
  const Toggle = React.forwardRef(({ children, onClick }, ref) => (
    <a
      className="btn btn_bowen"
      href=""
      ref={ref}
      onClick={(e) => {
        e.preventDefault();
        onClick(e);
      }}
    >
      {children}
      &#x25bc;
    </a>
  ));

  // forwardRef again here!
  // Dropdown needs access to the DOM of the Menu to measure it
  const Typeahead = React.forwardRef(
    ({ children, style, className, "aria-labelledby": labeledBy }, ref) => {
      const [value, setValue] = useState("");

      return (
        <div
          ref={ref}
          style={style}
          className={className}
          aria-labelledby={labeledBy}
        >
          <Form.Control
            autoFocus
            className="mx-3 my-2 w-auto"
            placeholder="Type to filter..."
            onChange={(e) => setValue(e.target.value)}
            value={value}
          />
          <ul className="list-unstyled">
            {React.Children.toArray(children).filter(
              (child) =>
                !value || child.props.children.toLowerCase().startsWith(value)
            )}
          </ul>
        </div>
      );
    }
  );

  return (
    <>
      <div className="row p-2">
        <div className="col text-center">
          <Dropdown id="countyDropdown">
            <Dropdown.Toggle as={Toggle} id="dropdown-counties">
              {label}
            </Dropdown.Toggle>

            <Dropdown.Menu as={Typeahead}>
              {counties.map((county) => (
                <Dropdown.Item
                  href="#"
                  id={`${county.id}_${county.name}`}
                  value={county.name}
                  key={county.id}
                  onClick={(e) => onChoice(e.target.text)}
                >
                  {county.name}
                </Dropdown.Item>
              ))}
            </Dropdown.Menu>
          </Dropdown>
        </div>
      </div>
    </>
  );
};

export default CountyDropdown;
