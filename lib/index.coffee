fs = require 'fs-jetpack'
extend = require 'extend'
Path = require 'path'

exports.get = (path, basename)->
	path ?= process.cwd()
	baseEnv = Path.join(path, basename or '.env')
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

exports.getAll = (path, basename)->
	current = extend {}, process.env
	return extend exports.get(path, basename), current

exports.load = (path, basename)->	
	return extend process.env, exports.getAll(path, basename)


exports.parse = (content)->
	require('dotenv').parse content





