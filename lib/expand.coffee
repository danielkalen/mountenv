ESCAPE_CHAR = '\\'
REGEX = 
	hasVars: /\$/
	variable: /(?:\\)?(?:\$([a-zA-Z0-9_]+)|\${([a-zA-Z0-9_]+)})/g


interpolate = (env, value)->	
	value.replace REGEX.variable, (match, key1, key2, index)->
		key = key1 or key2
		
		if match[0] is ESCAPE_CHAR
			return match.slice(1)
		else
			replacement = process.env[key] or env[key] or ''
			replacement = interpolate(env, replacement) if replacement
			return replacement


module.exports = (env)->
	for key in Object.keys(env)
		value = env[key]
		env[key] = interpolate(env, value) if REGEX.hasVars.test(value)

	return env



