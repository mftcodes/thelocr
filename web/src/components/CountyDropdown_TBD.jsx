import { useState, useEffect } from "react";
import Button from "react-bootstrap/Button";
import ButtonGroup from "react-bootstrap/ButtonGroup";
import Dropdown from "react-bootstrap/Dropdown";

const CountyDropdown = () => {
  const uri = "https://data.michigan.gov/resource/v9jc-jc8d.json";
  const [counties, setCounties] = useState([]);
  useEffect(() => {
    fetch(uri)
      .then((res) => {
        return res.json();
      })
      .then((data) => {
        setCounties(data);
      });
  }, []);

  return (
    <>
      <div className="row">
        <div className="col text-center">
          <Dropdown as={ButtonGroup}>
            <Button variant="primary">Select County</Button>
            <Dropdown.Toggle
              split
              variant="primary"
              id="dropdown-split-basic"
            />
            <Dropdown.Menu>
              {counties.map((county) => (
                <Dropdown.Item
                  href="#"
                  id={`${county.id}_${county.name}`}
                  value={county.name}
                  key={county.id}
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
