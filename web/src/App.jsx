import Router from './Router';
import Container from "react-bootstrap/Container";
import { NavMenu } from "./components/NavMenu";
import { Footer } from "./components/Footer";
import { useAuth0 } from "@auth0/auth0-react";
import Loading from "./components/Loading";
import "./App.css";

// fontawesome
import initFontAwesome from "./utils/initFontAwesome";
initFontAwesome();

export default function App() {
  const { isLoading, error } = useAuth0();

  if (error) {
    return <div>Oops... {error.message}</div>;
  }

  if (isLoading) {
    return <Loading />;
  }

  return (
    <>
      <div id="app" className="d-flex flex-column h-100">
          <NavMenu />
            <Container className="flex-grow-1 mt-5">
              <Router />
            </Container>
          <Footer />
      </div>
    </>
  );
}
