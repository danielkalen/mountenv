fs = require 'fs-jetpack'
extend = require 'extend'
Path = require 'path'

exports.get = (path)->
	path ?= process.cwd()
	baseEnv = Path.join(path, '.env')
	files = []
	output = Object.create(null)
	
	files.push(baseEnv) if fs.exists(baseEnv)
	switch process.env.NODE_ENV
		when 'development'
			files.push("#{baseEnv}.dev") if fs.exists("#{baseEnv}.dev")
		when 'production'
			files.push("#{baseEnv}.prod") if fs.exists("#{baseEnv}.prod")
		when 'test'
			files.push("#{baseEnv}.test") if fs.exists("#{baseEnv}.test")

	for file in files
		extend output, exports.parse(fs.read file)

	return output


exports.load = (path)->	
	current = extend {}, process.env
	return extend process.env, exports.get(path), current


exports.parse = (content)->
	require('dotenv').parse content





