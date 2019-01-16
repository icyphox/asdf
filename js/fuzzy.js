const FuzzySearch = require('fuzzy-search');

let cities = [
	"Bangalore",
	"Chennai",
	"Delhi",
	"Mumbai"
]

const s = new FuzzySearch(cities, {caseSensitive: false});
const result = s.search('bang');

console.log(result[0]);
