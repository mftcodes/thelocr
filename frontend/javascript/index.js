const apiUri = "http://127.0.0.1:8080/api/";
const counties = document.getElementById('county');
const categories = document.getElementById('category');
const searchBtn = document.getElementById('searchBtn');
const resContainer = document.getElementById('res-container');

searchBtn.addEventListener("click", search);

function init() {
    getCategories();
    getMICounties();
}

function search() {
    let cat = Number(categories.value);
    let county = counties.value;

    searchByCategory(true, county, "MI", cat);
}