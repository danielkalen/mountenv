fs = require 'fs-jetpack'
extend = require 'extend'
expand = require './expand'
Path = require 'path'
defaults = require './defaults'

exports.get = (path, conf)->
	conf = resolveConf(conf)
	path ?= process.cwd()
	baseEnv = Path.join(path, conf.basename)
	files = []
	output = Object.create(null)
	
	files.push(baseEnv) if fs.exists(baseEnv)
	switch process.env.NODE_ENV
		when 'development'
			files.push("#{baseEnv}.dev") if fs.exists("#{baseEnv}.dev")
		when 'production'
			files.push("#{baseEnv}.prod") if fs.exists("#{baseEnv}.prod")
		when 'staging'
			files.push("#{baseEnv}.staging") if fs.exists("#{baseEnv}.staging")
		when 'test'
			files.push("#{baseEnv}.test") if fs.exists("#{baseEnv}.test")

	for file in files
		extend output, exports.parse(fs.read file)

	return if conf.expand then expand(output) else output

exports.getAll = (path, conf)->
	current = extend {}, process.env
	return extend exports.get(path, conf), current

exports.load = (path, conf)->
	exports.origEnv ?= extend {}, process.env
	return extend process.env, exports.getAll(path, conf)


exports.parse = (content)->
	require('dotenv').parse content

exports.origEnv = undefined

resolveConf = (conf)->
	extend {}, defaults, conf


