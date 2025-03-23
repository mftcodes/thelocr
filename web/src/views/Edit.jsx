import { useState } from "react";
import { useLocation } from "react-router-dom";
import Button from "../components/Button";
import CountyDropdown from "../components/CountyDropdown";
import CategoryDropdown from "../components/CategoryDropdown";
import Form from "react-bootstrap/Form";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";
import Row from "react-bootstrap/Row";
import Loading from "../components/Loading";
import { useAuth0, withAuthenticationRequired } from "@auth0/auth0-react";

export const Edit = () => {

  const { user } = useAuth0();
  
  const location = useLocation();
  const originalRes = location.state;
  const uri = "http://localhost:8080/api/resource/update";
  const [county, setCounty] = useState(originalRes.County.String);
  const [countySelected, setCountySelected] = useState(false);
  const [category, setCategory] = useState("Make Selection");
  const [categorySelected, setCategorySelected] = useState(false);
  const [categoryId, setCategoryId] = useState(originalRes.Cat_id);
  const [modifiedRes, setModRef] = useState({
    createdBy: "",
    Res_uuid: originalRes.Res_uuid,
    Res_title: originalRes.Res_title.String,
    Res_desc: originalRes.Res_desc.String,
    Url: originalRes.Url.String,
    // placeholders, will be adding these to the model
    isParent: "",
    parentUuid: "",
    isStatewide: "",
    keyword: "",
    Addr_uuid: originalRes.Addr_uuid,
    Line_1: originalRes.Line_1.String,
    Line_2: originalRes.Line_2.String,
    City: originalRes.City.String,
    County: originalRes.County.String,
    State: originalRes.State.String,
    Postal_code: originalRes.Postal_code.String,
    Con_uuid: originalRes.Con_uuid,
    Phone_1: originalRes.Phone_1.String,
    Phone_2: originalRes.Phone_2.String,
    Phone_tty: originalRes.Phone_tty.String,
    Fax: originalRes.Fax.String,
    Email: originalRes.Email.String,
  });
  const updateModRef = (e) => {
    const { name, value } = e.target;
    setModRef((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  async function update() {
    const payload = setPayload();
    try {
      const [resp] = await Promise.all([
        (
          await fetch(uri, {
            method: "POST",
            headers: {
              Accept: "application/json",
              "Content-Type": "application/json",
            },
            body: JSON.stringify(payload),
          })
        ).json(),
      ]);
      if (!resp) {
        console.log("Need to log this error, or do something.");
        return;
      } else {
        // Success, need to go back to detail and refresh with saved data
      }
    } catch (error) {
      console.log(error);
    }
  }

  function setPayload() {
    return {
      Address: {
        Addr_uuid: modifiedRes.Addr_uuid,
        Line_1: toSqlNullStr(modifiedRes.Line_1),
        Line_2: toSqlNullStr(modifiedRes.Line_2),
        City: toSqlNullStr(modifiedRes.City),
        County: toSqlNullStr(modifiedRes.County),
        State: toSqlNullStr(modifiedRes.State),
        Postal_code: toSqlNullStr(modifiedRes.Postal_code),
      },
      Contact: {
        Con_uuid: modifiedRes.Con_uuid,
        Phone_1: toSqlNullStr(modifiedRes.Phone_1),
        Phone_2: toSqlNullStr(modifiedRes.Phone_2),
        Phone_tty: toSqlNullStr(modifiedRes.Phone_tty),
        Fax: toSqlNullStr(modifiedRes.Fax),
        Email: toSqlNullStr(modifiedRes.Email),
      },
      Resource: {
        Res_uuid: modifiedRes.Res_uuid,
        Res_title: toSqlNullStr(modifiedRes.Res_title),
        Res_desc: toSqlNullStr(modifiedRes.Res_desc),
        Url: toSqlNullStr(modifiedRes.Url),
        isParent: "",
        parentUuid: "",
        isStatewide: "",
        keyword: toSqlNullStr(""),
      },
    };
  }

  function toSqlNullStr(s) {
    if (s == "") {
      return { String: "", Valid: false };
    } else {
      return { String: s, Valid: true };
    }
  }

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
                value={modifiedRes.Res_title}
                onChange={updateModRef}
                name="Res_title"
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
                value={modifiedRes.Res_desc}
                onChange={updateModRef}
                name="Res_desc"
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
                value={modifiedRes.Url}
                onChange={updateModRef}
                name="Url"
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
                value={modifiedRes.Line_1}
                onChange={updateModRef}
                name="Line_1"
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
                value={modifiedRes.Line_2}
                onChange={updateModRef}
                name="Line_2"
              />
            </Col>
          </Form.Group>

          {/* *** RESOURCE CITY *** */}
          <Row className="mb-3">
            <Form.Group as={Col} controlId="formCity">
              <Form.Label>City</Form.Label>
              <Form.Control
                placeholder="City"
                value={modifiedRes.City}
                onChange={updateModRef}
                name="City"
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
                value={modifiedRes.State}
                onChange={updateModRef}
                name="State"
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
                value={modifiedRes.Postal_code}
                onChange={updateModRef}
                name="Postal_code"
              />
            </Form.Group>
            <p>
              <em>
                &nbsp;&nbsp;* Will need to do a search for County to verify, or
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
                value={modifiedRes.Phone_1}
                onChange={updateModRef}
                name="Phone_1"
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
                value={modifiedRes.Phone_2}
                onChange={updateModRef}
                name="Phone_2"
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
                value={modifiedRes.Phone_tty}
                onChange={updateModRef}
                name="Phone_tty"
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
                value={modifiedRes.Fax}
                onChange={updateModRef}
                name="Fax"
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
                placeholder="contact@Email.org"
                value={modifiedRes.Email}
                onChange={updateModRef}
                name="Email"
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

          <Button type="bowen" doClick={() => update()}>
            Submit
          </Button>
        </Form>
      </Container>
    </>
  );
};

export default withAuthenticationRequired(Edit, {
  onRedirecting: () => <Loading />,
});

