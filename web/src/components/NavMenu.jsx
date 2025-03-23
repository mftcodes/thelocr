import Container from "react-bootstrap/Container";
import Nav from "react-bootstrap/Nav";
import Navbar from "react-bootstrap/Navbar";
import { useAuth0 } from "@auth0/auth0-react";

export const NavMenu = () => {

  const {
    isAuthenticated,
    loginWithRedirect,
    logout,
  } = useAuth0();

  const logoutWithRedirect = () =>
    logout({
        logoutParams: {
          returnTo: window.location.origin,
        }
    });

  return (
    <Navbar
      id="header"
      expand="lg"
      data-bs-theme="dark"
      className="text-center pt-3 pb-2"
    >
      <Container>
        <Navbar.Brand href="/">
          <h1>Project Bowen</h1>
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link href="/">Home</Nav.Link>
            <Nav.Link href="/search">Search</Nav.Link>
            {!isAuthenticated && (
              <Nav.Link onClick={() => loginWithRedirect({})}>Login</Nav.Link>
            )}
            {isAuthenticated && (
              <Nav.Link onClick={() => logoutWithRedirect({})}>Logout</Nav.Link>
            )}
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
};
