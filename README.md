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

Note: this library is still under development stage and is being processed through heavy real-world battle testing. Full documentation will be released once this module is ready for alpha release.

## Syntax Rules
see [dotenv's rules section](https://www.npmjs.com/package/dotenv#rules).


## License
MIT © [Daniel Kalen](https://github.com/danielkalen)