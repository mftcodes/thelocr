import { useState } from "react";
import Button from "./Button";
import Form from "react-bootstrap/Form";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";
import Row from "react-bootstrap/Row";

export default function CreateUser() {
  const uri = "http://localhost:8080/api/user/create";
  const [user, setUser] = useState({
    Email: "",
    Username: "",
    First_name: "",
    Last_name: "",
    Password: "",
  });
  const updateUser = (e) => {
    const { name, value } = e.target;
    setUser((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  async function createNewUser() {
    const payload = setPayload();
    try {
      const [resp] = await Promise.all([
        (
          await fetch(uri, {
            method: "PUT",
            headers: {
              Accept: "application/json",
              "Content-Type": "application/json",
            },
            body: JSON.stringify(user),
          })
        ).json(),
      ]);
      if (!resp) {
        console.log("Need to log this error, or do something.");
        return;
      } else {
        // Success do something else. User profile probably. 
      }
    } catch (error) {
      console.log(error);
    }
  }

  function setPayload() {
    return {
    //   User: {
        Email: user.Email.String,
        Username: user.Username.String,
        First_name: user.First_name.String,
        Last_name: user.Last_name.String,
        Password: user.Password.String,
        // Can_edit: user.Can_Edit),
        // Created: user.Created),
        // Modified: user.Modified),
        // Modifeid_by: user.Modified_by)
    //   }
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
      <h2 className="text-center search pb-3">Create New User</h2>
      <Container>
        <Form>
          {/* *** First and Last Name *** */}
          <Form.Group as={Row} className="mb-3" controlId="formTitle">
            <Form.Label column sm={2}>
              First Name
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                type="text"
                placeholder="First Name"
                value={user.First_name.String}
                onChange={updateUser}
                name="First_name"
              />
            </Col>
          </Form.Group>
          <Form.Group as={Row} className="mb-3" controlId="formTitle">
            <Form.Label column sm={2}>
              Last Name
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                type="text"
                placeholder="Last Name"
                value={user.Last_name.String}
                onChange={updateUser}
                name="Last_name"
              />
            </Col>
          </Form.Group>

          {/* *** Email & Uername *** */}
          <Form.Group as={Row} className="mb-3" controlId="formTitle">
            <Form.Label column sm={2}>
              Email
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                type="text"
                placeholder="email@domain.net"
                value={user.Email.String}
                onChange={updateUser}
                name="Email"
              />
            </Col>
          </Form.Group>
          <Form.Group as={Row} className="mb-3" controlId="formTitle">
            <Form.Label column sm={2}>
              Username
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                type="text"
                placeholder="Username"
                value={user.Username.String}
                onChange={updateUser}
                name="Username"
              />
            </Col>
          </Form.Group>

          {/* *** Password *** */}
          <Form.Group as={Row} className="mb-3" controlId="formDesc">
            <Form.Label column sm={2}>
              Password
            </Form.Label>
            <Col sm={10}>
              <Form.Control
                type="text"
                placeholder="Not 'password1234!'"
                value={user.Password.String}
                onChange={updateUser}
                name="Password"
              />
              <Form.Text className="text-muted">
                Description of services offered.
              </Form.Text>
            </Col>
          </Form.Group>

          <Button type="bowen" doClick={() => createNewUser()}>
            Submit
          </Button>
        </Form>
      </Container>
    </>
  );
}
