import { useState } from "react";
import Button from "./Button";
import CountyDropdown from "./CountyDropdown";
import CategoryDropdown from "./CategoryDropdown";
import Form from "react-bootstrap/Form";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";
import Row from "react-bootstrap/Row";

export default function Edit() {
  const [county, setCounty] = useState("Make Selection");
  const [countySelected, setCountySelected] = useState(false);
  const [category, setCategory] = useState("Make Selection");
  const [categorySelected, setCategorySelected] = useState(false);
  const [categoryId, setCategoryId] = useState(-1);
  const [value, setValue] = useState(),
    onInput = ({ target: { value } }) => setValue(value),
    onFormSubmit = (e) => {
      e.preventDefault();
      console.log(value);
      setValue();
    };
  /*
		res.Created_by,
		res.Res_title, res.Res_desc, res.Url, isParent, res.Parent_uuid, isStatewide, res.Keyword,
		res.Line_1, res.Line_2, res.City, res.County, res.State, res.Postal_code,
		res.Phone_1, res.Phone_2, res.Phone_tty, res.Fax, res.Email,
		res.Category_id)
    */
  return (
    <>
      <h2 className="text-center search pb-3">New Community Resources</h2>
      <Container>
        <Form>
          <Form.Group as={Row} className="mb-3" controlId="formTitle">
            <Form.Label column sm={2}>
              Organization Name
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                type="text"
                placeholder="Org. Name"
                onChange={onInput}
                value={value}
              />
            </Col>
          </Form.Group>

          <Form.Group as={Row} className="mb-3" controlId="formIsParent">
            <Form.Label column sm={2}></Form.Label>
            <Col sm={10}>
              <Form.Check type="checkbox" label="Headquarters office?" />
              <Form.Text className="text-muted">
                Is this the organations headquarters/main offices?
              </Form.Text>
              <p>
                <em>
                  &nbsp;&nbsp;* If not checked, need to search by name of parent
                </em>
              </p>
            </Col>
          </Form.Group>

          <Form.Group as={Row} className="mb-3" controlId="formDesc">
            <Form.Label column sm={2}>
              Description
            </Form.Label>
            <Col sm={10}>
              <Form.Control as="textarea" placeholder="Description" />
              <Form.Text className="text-muted">
                Description of services offered.
              </Form.Text>
            </Col>
          </Form.Group>

          <Form.Group as={Row} className="mb-3" controlId="formUrl">
            <Form.Label column sm={2}>
              Website
            </Form.Label>
            <Col sm={10}>
              <Form.Control type="text" placeholder="Webiste" />
              <Form.Text className="text-muted">
                (e.g. www.CommunityHelpers.org).
              </Form.Text>
            </Col>
          </Form.Group>
          <Form.Group as={Col} controlId="formCategory">
            <Form.Label>Category</Form.Label>
            <CategoryDropdown
              label={`Category: ${category}   `}
              onChoice={(choice, catId) => {
                setCategory(choice);
                setCategorySelected(true);
                setCategoryId(Number.parseInt(catId));
              }}
            />
          </Form.Group>

          <h5 className="pt-4">Organization Address</h5>
          <Form.Group as={Row} className="mb-3" controlId="formLine1">
            <Form.Label column sm={2}>
              Address
            </Form.Label>
            <Col sm={10}>
              <Form.Control placeholder="1234 Main St" />
            </Col>
          </Form.Group>

          <Form.Group as={Row} className="mb-3" controlId="formLine2">
            <Form.Label column sm={2}>
              Address 2
            </Form.Label>
            <Col sm={10}>
              <Form.Control placeholder="Apartment, studio, or floor" />
            </Col>
          </Form.Group>

          <Row className="mb-3">
            <Form.Group as={Col} controlId="formCity">
              <Form.Label>City</Form.Label>
              <Form.Control />
            </Form.Group>
            <Form.Group as={Col} controlId="formCounty">
              <Form.Label>County</Form.Label>
              <CountyDropdown
                label={`County: ${county}   `}
                onChoice={(choice) => {
                  setCounty(choice);
                  setCountySelected(true);
                }}
              />
            </Form.Group>
          </Row>

          <Row>
            <Form.Group as={Col} controlId="formState">
              <Form.Label>State</Form.Label>
              <Form.Select defaultValue="Choose...">
                <option>Choose...</option>
                <option>...</option>
              </Form.Select>
            </Form.Group>

            <Form.Group as={Col} controlId="formGridZip">
              <Form.Label>Zip</Form.Label>
              <Form.Control />
            </Form.Group>
            <p>
              <em>
                &nbsp;&nbsp;* Will need to do a search for county to verify, or
                trust the users with dropdown?
              </em>
            </p>
          </Row>

          <h5 className="pt-4">Organization Contacts</h5>
          <Form.Group as={Row} className="mb-3" controlId="formPhone1">
            <Form.Label column sm={2}>
              Main Phone
            </Form.Label>
            <Col sm={10}>
              <Form.Control placeholder="(888) 555 1234" />
            </Col>
          </Form.Group>
          <Form.Group as={Row} className="mb-3" controlId="formPhone2">
            <Form.Label column sm={2}>
              Alternative Phone
            </Form.Label>
            <Col sm={10}>
              <Form.Control placeholder="(888) 555 1234" />
            </Col>
          </Form.Group>
          <Form.Group as={Row} className="mb-3" controlId="formPhoneTTY">
            <Form.Label column sm={2}>
              TTY Phone
            </Form.Label>
            <Col sm={10}>
              <Form.Control placeholder="(888) 555 1234" />
            </Col>
          </Form.Group>
          <Form.Group as={Row} className="mb-3" controlId="formFax">
            <Form.Label column sm={2}>
              Fax
            </Form.Label>
            <Col sm={10}>
              <Form.Control placeholder="(888) 555 1234" />
            </Col>
          </Form.Group>
          <Form.Group as={Row} className="mb-3" controlId="formEmail">
            <Form.Label column sm={2}>
              Email
            </Form.Label>
            <Col sm={10}>
              <Form.Control placeholder="contact@email.org" />
            </Col>
          </Form.Group>

          <h5 className="pt-4">Search Helpers</h5>
          <Form.Group as={Row} className="mb-3" controlId="formKeyword">
            <Form.Label column sm={2}>
              Keywords (comma separated)
            </Form.Label>
            <Col sm={10}>
              <Form.Control type="text" placeholder="Keywords" />
            </Col>
            <Form.Text className="text-muted">
              Keywords to help with search (e.g. "Food insecurity, housing",
              "legal aid, immigration").
            </Form.Text>
          </Form.Group>

          {countySelected && categorySelected && (
            <Button
              type="bowen"
              doClick={() => {
                const payload = {
                  Title: formTitle,
                  Category_id: categoryId,
                };
              }}
            >
              Submit
            </Button>
          )}
        </Form>
      </Container>
    </>
  );
}
