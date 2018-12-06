# mountenv
[![Build Status](https://travis-ci.org/danielkalen/mountenv.svg?branch=master)](https://travis-ci.org/danielkalen/mountenv)
[![Code Climate](https://codeclimate.com/github/danielkalen/mountenv/badges/gpa.svg)](https://codeclimate.com/github/danielkalen/mountenv)
[![NPM](https://img.shields.io/npm/v/mountenv.svg)](https://npmjs.com/package/mountenv)

Features:
- extends [dotenv](https://npmjs.com/package/dotenv) functionality
- supports loading .env files under `CWD` or a specific directory
- auto loads `.env.dev` when `NODE_ENV === 'development'` (in addition)
- auto loads `.env.prod` when `NODE_ENV === 'production'` (in addition)
- auto loads `.env.staging` when `NODE_ENV === 'staging'` (in addition)
- auto loads `.env.test` when `NODE_ENV === 'test'` (in addition)


![preview](doc/preview.jpg?raw=true)


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


## Custom env file name
By default, `mountenv` looks for files starting with `.env` in the `cwd`:
```
├── .env
├── .env.dev
└── .env.prod
└── .env.test
```

If you want `mountenv` to look for files with a different prefix, pass `{basename:'mycustomname'}` as the 2nd argument for any of the above mentioned methods:
```javascript
require('mountenv').load(null, {basename:'.myenv'})
```


## Variable expansion
By default variable expansion is turned on so if you want `mountenv` to resolve nested variables pass `{expand:true}` as the 2nd argument for any of the above mentioned methods:
```javascript
require('mountenv').parse(`
    PROJECT_DIR=$HOME/this-project
`, {expand:true}) //-> {PROJECT_DIR: 'Users/thisuser/this-project'}
```


## Syntax Rules
see [dotenv's rules section](https://www.npmjs.com/package/dotenv#rules).


## License
MIT © [Daniel Kalen](https://github.com/danielkalen)