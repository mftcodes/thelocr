import { Routes, Route, Link } from "react-router-dom";
import Container from "react-bootstrap/Container";
import { NavMenu } from "./components/NavMenu";
import { Footer } from "./components/Footer";
import Detail from "./views/Detail";
import Edit from "./views/Edit";
import Landing from "./views/Landing";
import Search from "./views/Search";
import Profile from "./views/Profile";
import { useAuth0 } from "@auth0/auth0-react";
import Loading from "./components/Loading";
import history from "./utils/history";
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
            <Routes history={history}>
              <Route path="/" exact element={<Landing />} />
              <Route path="search" element={<Search />} />
              <Route path="detail" element={<Detail />} />
              <Route path="edit" element={<Edit />} />
              <Route path="profile" element={<Profile />} />

              {/* path="*"" matches anything, so acts as a 
                  catch for things we haven't setup */}
              <Route path="*" element={<NoMatch />} />
            </Routes>
          </Container>
          <Footer />
      </div>
    </>
  );
}

function NoMatch() {
  return (
    <div>
      <h2>That page does not exists</h2>
      <p>
        <Link to="/">Go to the home page</Link>
      </p>
    </div>
  );
}
