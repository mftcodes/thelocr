import { useState, useEffect } from "react";

const SearchResults = (payload) => {
  const uri = "http://localhost:8080/api/resource/search";
  const [resources, setResources] = useState([]);
  const [hasResults, setHasResults] = useState(false);
  async function getData() {
    try {
      const [resp] = await Promise.all([
        (
          await fetch(uri, {
            method: "POST",
            headers: {
              Accept: "application/json",
              "Content-Type": "application/json",
            },
            body: JSON.stringify(payload.payload),
          })
        ).json(),
      ]);
      if (!resp) {
        console.log("Farts");
      } else if (resp.length > 0) {
        console.log(`resp.length = ${resp.length}`);
        console.log("Success");
        setResources(resp);
        setHasResults(true);
      } else {
        console.log("oof");
      }
    } catch (error) {
      console.log(error);
    }
  }

  useEffect(() => {
    getData();
  }, []);

  return (
    <>
      <h2 className="text-center">Results</h2>

      {resources.map((resource) => (
        <div className="container pb-2" key={resource.Res_uuid}>
          <div className="card card_bg">
            <div className="card-body">
              <h4 className="card-title text-center">
                {resource.Res_title.String}
              </h4>
              <div className="row text-center pb-2 fw-bolder">
                <span id={`addr1_${resource.Res_uuid}`}>
                  {resource.Line_1.String}
                </span>
                <span id={`addr2_${resource.Res_uuid}`}>
                  {resource.Line_2.String}
                </span>
                <span id={`cityStZip_${resource.Res_uuid}`}>
                  {resource.City.String}, {resource.State.String}{" "}
                  {resource.Postal_code.String}
                </span>
              </div>
              <div className="row">
                <div className="col-6 text-end px-1 m-0 fw-semibold">
                  Phone:
                </div>
                <div className="col-6 px-1 m-0">{resource.Phone_1.String}</div>
              </div>
              <div className="row">
                <div className="col-6 text-end px-1 m-0 fw-semibold">
                  Phone Alt:
                </div>
                <div className="col-6 px-1 m-0">{resource.Phone_2.String}</div>
              </div>
              <div className="row">
                <div className="col-6 text-end px-1 m-0 fw-semibold">
                  Phone TTY:
                </div>
                <div className="col-6 px-1 m-0">
                  {resource.Phone_tty.String}
                </div>
              </div>
              <div className="row">
                <div className="col-6 text-end px-1 m-0 fw-semibold">Fax:</div>
                <div className="col-6 px-1 m-0">{resource.Fax.String}</div>
              </div>
              <div className="row">
                <div className="col-6 text-end px-1 m-0 fw-semibold">
                  Email:
                </div>
                <div className="col-6 px-1 m-0">{resource.Email.String}</div>
              </div>
            </div>
          </div>
        </div>
      ))}
    </>
  );
};

export default SearchResults;
