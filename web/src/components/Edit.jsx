import { useState } from "react";
import { useLocation } from "react-router-dom";
import Button from "./Button";
import CountyDropdown from "./CountyDropdown";
import CategoryDropdown from "./CategoryDropdown";
import Form from "react-bootstrap/Form";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";
import Row from "react-bootstrap/Row";

export default function Edit() {
  const location = useLocation();
  const originalRes = location.state;
  const [county, setCounty] = useState(originalRes.County.String);
  const [countySelected, setCountySelected] = useState(false);
  const [category, setCategory] = useState("Make Selection");
  const [categorySelected, setCategorySelected] = useState(false);
  const [categoryId, setCategoryId] = useState(originalRes.Category_id);
  /*
		res.Created_by,
		res.Res_title, res.Res_desc, res.Url, isParent, res.Parent_uuid, isStatewide, res.Keyword,
		res.Line_1, res.Line_2, res.City, res.County, res.State, res.Postal_code,
		res.Phone_1, res.Phone_2, res.Phone_tty, res.Fax, res.Email,
		res.Category_id)
    */
  const [modifiedRes, setModRef] = useState({
    createdBy: "",
    resUuid: originalRes.Res_uuid,
    title: originalRes.Res_title.String,
    desc: originalRes.Res_desc.String,
    url: originalRes.Url.String,
    // placeholders, will be adding these to the model
    isParent: "",
    parentUuid: "",
    isStatewide: "",
    keyword: "",
    addrUuid: originalRes.Addr_uuid,
    line1: originalRes.Line_1.String,
    line2: originalRes.Line_2.String,
    city: originalRes.City.String,
    county: originalRes.County.String,
    state: originalRes.State.String,
    postalCode: originalRes.Postal_code.String,
    conUuid: originalRes.Con_uuid,
    phone1: originalRes.Phone_1.String,
    phone2: originalRes.Phone_2.String,
    phoneTty: originalRes.Phone_tty.String,
    f1ax: originalRes.Fax.String,
    email: originalRes.Email.String,
  });
  const updateModRef = (e) => {
    const { name, value } = e.target;
    setModRef((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  return (
    <>
      <h2 className="text-center search pb-3">Edit Community Resources</h2>
      <Container>
        <Form>
          {/* *** RESOURCE NAME/TITLE *** */}
          <Form.Group as={Row} className="mb-3" controlId="formTitle">
            <Form.Label column sm={2}>
              Organization Name
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                type="text"
                placeholder="Org. Name"
                value={modifiedRes.title}
                onChange={updateModRef}
                name="title"
              />
            </Col>
          </Form.Group>

          {/* *** ISPARENT / IS HEADQUARTERS *** */}
          <Form.Group as={Row} className="mb-3" controlId="formIsParent">
            <Form.Label column sm={2}></Form.Label>{" "}
            {/* *** Need add to search SProc *** */}
            <Col sm={10}>
              {/* <Form.Check
                type="checkbox"
                label="Headquarters office?"
                value={modifiedRes.isParent}
                onChange={updateModRef}
                name="isParent"
              /> */}
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

          {/* *** RESOURCE DESCRIPTION *** */}
          <Form.Group as={Row} className="mb-3" controlId="formDesc">
            <Form.Label column sm={2}>
              Description
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                as="textarea"
                placeholder="Description"
                value={modifiedRes.desc}
                onChange={updateModRef}
                name="desc"
              />
              <Form.Text className="text-muted">
                Description of services offered.
              </Form.Text>
            </Col>
          </Form.Group>

          {/* *** RESOURCE WEBSITE *** */}
          <Form.Group as={Row} className="mb-3" controlId="formUrl">
            <Form.Label column sm={2}>
              Website
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                type="text"
                placeholder="Webiste"
                value={modifiedRes.url}
                onChange={updateModRef}
                name="url"
              />
              <Form.Text className="text-muted">
                (e.g. www.CommunityHelpers.org).
              </Form.Text>
            </Col>
          </Form.Group>

          {/* *** RESOURCE CATEGORY *** */}
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

          {/* *** RESOURCE ADDRESS LINE 1 *** */}
          <h5 className="pt-4">Organization Address</h5>
          <Form.Group as={Row} className="mb-3" controlId="formLine1">
            <Form.Label column sm={2}>
              Address
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                placeholder="1234 Main St"
                value={modifiedRes.line1}
                onChange={updateModRef}
                name="line1"
              />
            </Col>
          </Form.Group>

          {/* *** RESOURCE ADDRESS LINE 2 *** */}
          <Form.Group as={Row} className="mb-3" controlId="formLine2">
            <Form.Label column sm={2}>
              Address 2
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                placeholder="Apt. #, Suite #, etc."
                value={modifiedRes.line2}
                onChange={updateModRef}
                name="line2"
              />
            </Col>
          </Form.Group>

          {/* *** RESOURCE CITY *** */}
          <Row className="mb-3">
            <Form.Group as={Col} controlId="formCity">
              <Form.Label>City</Form.Label>
              <Form.Control
                placeholder="city"
                value={modifiedRes.city}
                onChange={updateModRef}
                name="city"
              />
            </Form.Group>

            {/* *** RESOURCE COUNTY *** */}
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

          {/* *** RESOURCE STATE (disabled) *** */}
          <Row>
            <Form.Group as={Col} controlId="formState">
              <Form.Label>State</Form.Label>
              <Form.Select
                // defaultValue="Choose..."
                value={modifiedRes.state}
                onChange={updateModRef}
                name="state"
                disabled
              >
                <option>Choose...</option>
                <option value="MI">MI</option>
                <option>...</option>
              </Form.Select>
            </Form.Group>

            {/* *** RESOURCE ZIP/POSTAL CODE *** */}
            <Form.Group as={Col} controlId="formGridZip">
              <Form.Label>Zip</Form.Label>
              <Form.Control
                type="text"
                placeholder="00012"
                value={modifiedRes.postalCode}
                onChange={updateModRef}
                name="postalCode"
              />
            </Form.Group>
            <p>
              <em>
                &nbsp;&nbsp;* Will need to do a search for county to verify, or
                trust the users with dropdown?
              </em>
            </p>
          </Row>

          {/* *** RESOURCE PHONE 1 or MAIN *** */}
          <h5 className="pt-4">Organization Contacts</h5>
          <Form.Group as={Row} className="mb-3" controlId="formPhone1">
            <Form.Label column sm={2}>
              Main Phone
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                placeholder="(888) 555 1234"
                value={modifiedRes.phone1}
                onChange={updateModRef}
                name="phone1"
              />
            </Col>
          </Form.Group>

          {/* *** RESOURCE PHONE 2 or ALT *** */}
          <Form.Group as={Row} className="mb-3" controlId="formPhone2">
            <Form.Label column sm={2}>
              Alternative Phone
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                placeholder="(888) 555 1234"
                value={modifiedRes.phone2}
                onChange={updateModRef}
                name="phone2"
              />
            </Col>
          </Form.Group>

          {/* *** RESOURCE PHONE TTY *** */}
          <Form.Group as={Row} className="mb-3" controlId="formPhoneTTY">
            <Form.Label column sm={2}>
              TTY Phone
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                placeholder="(888) 555 1234"
                value={modifiedRes.phoneTty}
                onChange={updateModRef}
                name="phoneTty"
              />
            </Col>
          </Form.Group>

          {/* *** RESOURCE FAX *** */}
          <Form.Group as={Row} className="mb-3" controlId="formFax">
            <Form.Label column sm={2}>
              Fax
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                placeholder="(888) 555 1234"
                value={modifiedRes.fax}
                onChange={updateModRef}
                name="fax"
              />
            </Col>
          </Form.Group>

          {/* *** RESOURCE EMAIL *** */}
          <Form.Group as={Row} className="mb-3" controlId="formEmail">
            <Form.Label column sm={2}>
              Email
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                placeholder="contact@email.org"
                value={modifiedRes.email}
                onChange={updateModRef}
                name="email"
              />
            </Col>
          </Form.Group>

          {/* *** RESOURCE KEYWORDS *** */}
          <h5 className="pt-4">Search Helpers</h5>
          <Form.Group as={Row} className="mb-3" controlId="formKeyword">
            <Form.Label column sm={2}>
              Keywords (comma separated)
            </Form.Label>
            <Col sm={10}>
              {/* <Form.Control 
                type="text" 
                placeholder="Keywords" 
                value={modifiedRes.keyword} 
                onChange={updateModRef}
              /> */}
              <Form.Control type="text" placeholder="Keywords" />
            </Col>
            <Form.Text className="text-muted">
              Keywords to help with search (e.g. "Food insecurity, housing",
              "legal aid, immigration"). <em>*Not currently implemented</em>
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
