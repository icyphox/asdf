const Fuse = require('fuse.js');
const Cities = require('indian-cities-json')

let options = {
	keys: ["name"]
}

var fuse = new Fuse(Cities.cities, options);
var result = fuse.search("hyd");

console.log(result[0]['name']);
