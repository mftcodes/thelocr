import { useState } from "react";
import CountyDropdown from "./CountyDropdown";
import CategoryDropdown from "./CategoryDropdown";

const Search = ({ onSearch }) => {
  const [county, setCounty] = useState("Make Selection");
  const [category, setCategory] = useState("Make Selection");

  return (
    <>
      <h2 className="text-center search">Community Resources Search</h2>

      <CountyDropdown
        label={`County: ${county}   `}
        onChoice={(choice) => {
          setCounty(choice);
          setCountySelected(true);
        }}
      />
      <CategoryDropdown
        label={`Category: ${category}   `}
        onChoice={(choice, catId) => {
          setCategory(choice);
          setCategorySelected(true);
          setCategoryId(Number.parseInt(catId));
        }}
      />
      <p>Temp page holder for edit resource page.</p>
    </>
  );
};

export default Search;
