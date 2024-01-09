import { useState } from "react";
import { Header } from "./components/Header";
import Search from "./components/Search";
import SearchResults from "./components/SearchResults";
import "./App.css";

function App() {
  const [searchPayload, setSearchPayload] = useState({});
  const [resultsReady, setResultsReady] = useState(false);

  return (
    <>
      <div>
        <div className="pb-2">
          <Header />
        </div>
        <div className="container">
          <Search
            onSearch={(pl) => {
              setSearchPayload(pl);
              setResultsReady(true);
            }}
          />
        </div>
        <div className="container pt-5 results">
          {resultsReady && (
            <SearchResults payload={searchPayload}></SearchResults>
          )}
        </div>
      </div>
    </>
  );
}

export default App;
