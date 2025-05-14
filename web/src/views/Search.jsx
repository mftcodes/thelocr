import { useState } from "react";
import Container from "react-bootstrap/esm/Container";
import Button from "../components/Button";
import CountyDropdown from "../components/CountyDropdown";
import CategoryDropdown from "../components/CategoryDropdown";
import SearchResults from "../components/SearchResults";

export default function Search() {
  const [countySelected, setCountySelected] = useState(false);
  const [county, setCounty] = useState("Make Selection");
  const [categorySelected, setCategorySelected] = useState(false);
  const [category, setCategory] = useState("Make Selection");
  const [categoryId, setCategoryId] = useState(-1);
  const [searchPayload, setSearchPayload] = useState({});
  const [resultsReady, setResultsReady] = useState(false);

  function resetSearchResults() {
    setSearchPayload({});
    setResultsReady(false);
  }

  return (
    <>
      <Container>
        <h1 className="text-center">Community Resources Search</h1>

        <CountyDropdown
          label={`County: ${county}   `}
          onChoice={(choice) => {
            resetSearchResults();
            setCounty(choice);
            setCountySelected(true);
          }}
        />
        <CategoryDropdown
          label={`Category: ${category}   `}
          onChoice={(choice, catId) => {
            resetSearchResults();
            setCategory(choice);
            setCategorySelected(true);
            setCategoryId(Number.parseInt(catId));
          }}
        />
        {countySelected && categorySelected && (
          <div className="text-center pt-4">
            <Button
              type="thelocr__alt"
              doClick={() => {
                const payload = {
                  Is_statewide: true,
                  County: county,
                  State: "MI",
                  Cat_id: categoryId,
                };
                setSearchPayload(payload);
                setResultsReady(true);
              }}
            >
              Search
            </Button>
          </div>
        )}
        <div className="container pt-5 results">
          {resultsReady && (
            <SearchResults payload={searchPayload}></SearchResults>
          )}
        </div>
      </Container>
    </>
  );
}
