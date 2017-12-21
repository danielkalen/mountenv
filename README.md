# mountenv
[![Build Status](https://travis-ci.org/danielkalen/mountenv.svg?branch=master)](https://travis-ci.org/danielkalen/mountenv)
[![Code Climate](https://codeclimate.com/github/danielkalen/mountenv/badges/gpa.svg)](https://codeclimate.com/github/danielkalen/mountenv)
[![NPM](https://img.shields.io/npm/v/mountenv.svg)](https://npmjs.com/package/mountenv)

Features:
- extends [dotenv](https://npmjs.com/package/dotenv) functionality
- supports loading .env files under `CWD` or a specific directory
- auto loads `.env.dev` when `NODE_ENV === 'development'` (in addition)
- auto loads `.env.prod` when `NODE_ENV === 'production'` (in addition)
- auto loads `.env.test` when `NODE_ENV === 'test'` (in addition)


![preview](doc/preview.jpg?raw=true)
Note: this library is still under development stage and is being processed through heavy real-world battle testing. Full documentation will be released once this module is ready for alpha release.


### `mountenv.load([dir])`
Loads env files in the provided directory and extends current process environment. `dir` defaults to `process.cwd()`.

```javascript
require('mountenv').load()
```


### `mountenv.get([dir])`
Loads env files in the provided directory and returns the result object (does NOT extend current process environment). `dir` defaults to `process.cwd()`.

```javascript
var result = require('mountenv').get('./config/')
```


### `mountenv.getAll([dir])`
Loads env files in the provided directory and returns the result object including definitions from current `process.env` (does NOT extend current process environment). `dir` defaults to `process.cwd()`.

```javascript
var result = require('mountenv').get('./config/')
```


### `mountenv.parse(string)`
Parses the provided string as an env file and returns the result object.

```javascript
var env = `
    ABC=123
    DEF=456
`
var result = require('mountenv').parse(env)
```


## Syntax Rules
see [dotenv's rules section](https://www.npmjs.com/package/dotenv#rules).


## License
MIT © [Daniel Kalen](https://github.com/danielkalen)