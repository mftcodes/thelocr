import { Routes, Route, Link } from "react-router-dom";
import About from "./views/About";
import Detail from "./views/Detail";
import Edit from "./views/Edit";
import Landing from "./views/Landing";
import Search from "./views/Search";
import Profile from "./views/Profile";
import history from "./utils/history";

// fontawesome
import initFontAwesome from "./utils/initFontAwesome";
initFontAwesome();

export default function Router() {
  return (
    <>
        <Routes history={history}>
            <Route path="/" exact element={<Landing />} />
            <Route path="about" exact element={<About />} />
            <Route path="search" element={<Search />} />
            <Route path="detail" element={<Detail />} />
            <Route path="/detail/:id" element={<Detail />} />
            <Route path="create" element={<Edit isCreate={true} />} />
            <Route path="edit" element={<Edit isCreate={false} />} />
            <Route path="profile" element={<Profile />} />

            {/* path="*"" matches anything, so acts as a
                catch for things we haven't setup */}
            <Route path="*" element={<NoMatch />} />
        </Routes>
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
