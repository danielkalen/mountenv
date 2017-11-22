fs = require 'fs-jetpack'
extend = require 'extend'
Path = require 'path'

exports.get = (path)->
	path ?= process.cwd()
	baseEnv = Path.join(path, '.env')
	inProduction = process.env.NODE_ENV is 'production'
	files = []
	output = Object.create(null)
	
	files.push(baseEnv) if fs.exists(baseEnv)
	files.push("#{baseEnv}.prod") if fs.exists("#{baseEnv}.prod") and inProduction
	files.push("#{baseEnv}.dev") if fs.exists("#{baseEnv}.dev") and not inProduction

	for file in files
		extend output, exports.parse(fs.read file)

	return output


exports.load = (path)->
	output = Object.create(null)
	parsed = exports.get(path)
	
	return extend output, process.env, parsed


exports.parse = (content)->
	require('dotenv').parse content





