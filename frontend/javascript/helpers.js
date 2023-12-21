
function getCategories() {
    let catUri = `${apiUri}category`;
    fetch(catUri)
        .then((response) => {
            if (!response.ok) {
                throw new Error(`HTTP error: ${response.status}`);
            }
            return response.json();
        })
        .then((data) => {
          let cats = data;

          var opt = null;

          for(i = 0; i < cats.length; i++) {
            opt = document.createElement('option');
            opt.value = cats[i].Cat_id;
            opt.innerHTML = cats[i].Cat_title;
            categories.appendChild(opt);
          }
        })
        .catch((err) => console.error(`Fetch problem: ${err.message}`));
}

function getMICounties() {
  let uri = "https://data.michigan.gov/resource/v9jc-jc8d.json";
  (async () => {
    const rawResponse = await fetch(uri, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'X-App-Token': 'REPLACE_ME_PROBABLY_SEND_THIS_TO_API_OR_SAVE_DATA_IN_DB_AND_CHECK_WEEKLY_FOR_UPDATE'
      }
    });
    const results = await rawResponse.json();

    var opt = null;

    for(i = 0; i < results.length; i++) {
      opt = document.createElement('option');
      opt.value = results[i].name;
      opt.innerHTML = results[i].name;
      counties.appendChild(opt);
    }

  })();
}

function searchByCategory(isStateWide, county, state, cat_id) {
  let searchUri = `${apiUri}resource/search`;
  const payload = {
    "Is_statewide": isStateWide,
    "County": county,
    "State": state,
    "Category_id": cat_id
  };

  (async () => {
    const rawResponse = await fetch(searchUri, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(payload)
    });
    const content = await rawResponse.json();
  
    // console.log(content);
    console.log(`dafuq is this?: ${typeof content}`);

    var opt = null;
    content.forEach(resource => {
      opt = document.createElement('div');
      // opt.innerHTML = `<resource-component resource="${resource}"></resource-component>`;
      opt.innerHTML = `
      <div class="resCard center row pb">
          <h3 id="title_${resource.Res_uuid}" class="row">${resource.Res_title.String}</h3>
              <div class="row pt">
                  <span id="addr1_${resource.Res_uuid}" class="row pt">${resource.Line_1.String}</span>
                  <span id="addr2_${resource.Res_uuid}" class="row pt">${resource.Line_2.String}</span>
                  <span id="cityStZip_${resource.Res_uuid}" class="row pt">${resource.City.String}, ${resource.State.String} ${resource.Postal_code.String}</span>
              </div>
              <div class="row pt">
                  <label for="phone1_${resource.Res_uuid}">Ph: </label>
                  <span name="phone1_${resource.Res_uuid}" id="phone1_${resource.Res_uuid}">${resource.Phone_1.String}</span>
              </div>
              <div class="row pt">
                  <label for="phone2_${resource.Res_uuid}">Ph Alt: </label>
                  <span name="phone2_${resource.Res_uuid}" id="phone2_${resource.Res_uuid}">${resource.Phone_2.String}</span>
              </div>
              <div class="row pt">
                  <label for="phonetty_${resource.Res_uuid}">Ph TTY: </label>
                  <span name="phonetty_${resource.Res_uuid}" id="phonetty_${resource.Res_uuid}">${resource.Phone_tty.String}</span>
              </div>
              <div class="row pt">
                  <label for="fax_${resource.Res_uuid}">Fax: </label>
                  <span name="fax_${resource.Res_uuid}" id="fax_${resource.Res_uuid}">${resource.Fax.String}</span>
              </div>
              <div class="row pt">
                  <label for="email_${resource.Res_uuid}">Email: </label>
                  <span name="email_${resource.Res_uuid}" id="email_${resource.Res_uuid}">${resource.Email.String}</span>
              </div>
      </div>
      `;
      resContainer.appendChild(opt);
    });

    
  })();
}




class Resource {
  constructor(Res_uuid, Res_title, Res_desc, Url,
      Addr_uuid, Line_1, Line_2, Line_3, City, County, State, Postal_code, 
      Con_uuid, Phone_1, Phone_2, Phone_tty, Fax, Email) {
      this.Res_uuid = Res_uuid;
      this.Res_title = Res_title;
      this.Res_desc = Res_desc;
      this.Url = Url;
      this.Addr_uuid = Addr_uuid;
      this.Line_1 = Line_1;
      this.Line_2 = Line_2;
      this.Line_3 = Line_3;
      this.City = City;
      this.County = County;
      this.State = State;
      this.Postal_code = Postal_code;
      this.Con_uuid = Con_uuid;
      this.Phone_1 = Phone_1;
      this.Phone_2 = Phone_2;
      this.Phone_tty = Phone_tty;
      this.Fax = Fax;
      this.Email = Email;
  }
}