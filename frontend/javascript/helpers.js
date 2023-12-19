// function Category(id, title, desc, created, createdBy, modified, modifiedBy) {
//     this.id = id;
//     this.title = title;
//     this.desc = desc;
//     this.created = created;
//     this.createdBy = createdBy;
//     this.modified = modified;
//     this.modifiedBy = modifiedBy;
// }

function getCategories() {
    catUri = `${apiUri}category`;
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
    
        //   cats.map((cat) => {
        //     console.log(cat);
        //   });
        })
        .catch((err) => console.error(`Fetch problem: ${err.message}`));
}
