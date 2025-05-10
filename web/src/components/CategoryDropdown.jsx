import React, { useState, useEffect } from "react";
import Dropdown from "react-bootstrap/Dropdown";
import Form from "react-bootstrap/Form";

const CategoryDropdown = ({ label, onChoice }) => {
  const uri = `${import.meta.env.VITE_API_URI}/api/category`;
  const [categories, setCategories] = useState([]);
  useEffect(() => {
    fetch(uri)
      .then((res) => {
        if (!res.ok) {
          throw new Error(`HTTP error: ${res.status}`);
        }
        return res.json();
      })
      .then((data) => {
        setCategories(data);
      });
  }, []);

  const Toggle = React.forwardRef(({ children, onClick }, ref) => (
    <a
      className="btn btn_thelocr"
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
          <Dropdown id="categoriesDropdown">
            <Dropdown.Toggle as={Toggle} id="dropdown-categories">
              {label}
            </Dropdown.Toggle>

            <Dropdown.Menu as={Typeahead}>
              {categories.map((category) => (
                <Dropdown.Item
                  href="#"
                  id={`${category.Cat_id}`}
                  value={category.Cat_id}
                  key={category.Cat_id}
                  onClick={(e) => {
                    onChoice(e.target.text, e.target.id);
                  }}
                >
                  {category.Cat_title}
                </Dropdown.Item>
              ))}
            </Dropdown.Menu>
          </Dropdown>
        </div>
      </div>
    </>
  );
};

export default CategoryDropdown;
