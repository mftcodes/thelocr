import { useState } from "react";
import Button from "../components/Button";
import Form from "react-bootstrap/Form";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";
import Row from "react-bootstrap/Row";
import logger from "../utils/logger";

export default function CreateUser() {
  const uri = `${import.meta.env.VITE_API_URI}/api/user/create`;
  const [user, setUser] = useState({
    User_email: "",
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
        logger.debug(`CreateUser.jsx: Failed to create user, result emtpy.`);
        return;
      } else {
        logger.info(`GreatUser.jsx: New User Created.`)
        // Success do something else. User profile probably. 
      }
    } catch (error) {
      logger.error(`CreateUser.jsx: Error creating user = ${error}`)
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
                type="email"
                placeholder="email@domain.net"
                value={user.User_email.String}
                onChange={updateUser}
                name="User_email"
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
                Minimum of 12 characters, must contain one number and a special character.
              </Form.Text>
            </Col>
          </Form.Group>

          <Button type="thelocr" doClick={() => createNewUser()}>
            Submit
          </Button>
        </Form>
      </Container>
    </>
  );
}
