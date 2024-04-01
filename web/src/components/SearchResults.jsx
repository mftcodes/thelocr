import { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import Button from "./Button";
import Card from "react-bootstrap/Card";
import Col from "react-bootstrap/Col";
import Row from "react-bootstrap/Row";

const SearchResults = (payload) => {
  const uri = "http://localhost:8080/api/resource/search";
  const [resources, setResources] = useState([]);

  async function getData() {
    try {
      const [resp] = await Promise.all([
        (
          await fetch(uri, {
            method: "POST",
            headers: {
              Accept: "application/json",
              "Content-Type": "application/json",
            },
            body: JSON.stringify(payload.payload),
          })
        ).json(),
      ]);
      if (!resp) {
        console.log("Need to log this error, or do something.");
      } else if (resp.length > 0) {
        setResources(resp);
      } else {
        console.log("Need to log this error, too.");
      }
    } catch (error) {
      console.log(error);
    }
  }

  useEffect(() => {
    getData();
  }, []);

  function setAddressText(resource) {
    return `${resource.Line_1.String}, ${resource.City.String}, ${resource.State.String} ${resource.Postal_code.String}`;
  }

  function setAddressLine2(resource) {
    return resource.Line_2.Valid && resource.Line_3.Valid
      ? `${resource.Line_2.String}, ${resource.Line_3.String}`
      : resource.Line_2.Valid
      ? `${resource.Line_2.String}`
      : "";
  }

  return (
    <>
      <h2 className="text-center">Results</h2>

      <Row xs={1} md={2} lg={3} className="g-3">
        {resources.map((resource, idx) => (
          <Col key={idx}>
            <Card style={{ minHeight: "18.5rem" }} className="card_bg">
              <Card.Body>
                <Card.Title>
                  <h4 className="card-title text-center">
                    {resource.Res_title.String}
                  </h4>
                </Card.Title>
                <Card.Text>
                  <Row className="text-center pb-2">
                    <a
                      href={
                        "https://maps.google.com/?q=" + setAddressText(resource)
                      }
                      target="_blank"
                      rel="noreferrer"
                    >
                      {setAddressText(resource)}
                    </a>
                    {resource.Line_2.Valid && (
                      <span id={`addr2_${resource.Res_uuid}`}>
                        <strong>Suite/Office&nbsp;</strong>
                        {setAddressLine2(resource)}
                      </span>
                    )}
                  </Row>
                  {resource.Url.Valid && (
                    <Row className="text-center pb-2">
                      <a
                        href={"https://" + resource.Url.String}
                        target="_blank"
                        rel="noreferrer"
                      >
                        {resource.Url.String}
                      </a>
                    </Row>
                  )}
                  {resource.Phone_1.Valid && (
                    <Row className="text-center">
                      <Col xs={4} className="text-end px-1 m-0 fw-semibold">
                        Main Ph #
                      </Col>
                      <Col xs={8} className="px-1 m-0">
                        <a href={"tel:" + resource.Phone_1.String}>
                          {resource.Phone_1.String}
                        </a>
                      </Col>
                    </Row>
                  )}
                  {resource.Email.Valid && (
                    <Row className="text-center">
                      <Col xs={4} className="text-end px-1 m-0 fw-semibold">
                        Email
                      </Col>
                      <Col xs={8} className="px-1 m-0">
                        <a href={"mailto:" + resource.Email.String}>
                          {resource.Email.String}
                        </a>
                      </Col>
                    </Row>
                  )}
                </Card.Text>
              </Card.Body>
              <Card.Footer>
                <Row className="text-center">
                  <Link to={"/detail"} state={resource}>
                    <Button type="bowen__alt">Get More Details</Button>
                  </Link>
                </Row>
              </Card.Footer>
            </Card>
          </Col>
        ))}
      </Row>
    </>
  );
};

export default SearchResults;
