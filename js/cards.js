#!/usr/bin/env node

'use strict'

const fs = require('fs');
let rawdata = fs.readFileSync('cards.json');
let cards = JSON.parse(rawdata);
console.log(cards['name'])
