fs = require 'fs-jetpack'
mountenv = require '../'
{expect} = require 'chai'
SAMPLE = './test/sample'


suite "mountenv", ()->
	suiteTeardown ()->
		fs.remove SAMPLE
		fs.remove '.env'
	
	setup ()->
		delete process.env.ABC
		delete process.env.DEF
		delete process.env.GHI
		fs.dir SAMPLE, empty:true
		fs.write "#{SAMPLE}/.env", """
			ABC=111
			DEF=222
			GHI=333
		"""


	suite ".get()", ()->
		test "loads .env file and returns js object", ()->
			expect(process.env.ABC).to.equal undefined
			expect(mountenv.get(SAMPLE)).to.eql {ABC:'111', DEF:'222', GHI:'333'}

		test "will not extend process env", ()->
			expect(process.env.ABC).to.equal undefined
			result = mountenv.get(SAMPLE)
			expect(process.env.ABC).to.equal undefined

		test "will return an empty object if provided dir doesn't exist or .env files don't exist", ()->
			expect(mountenv.get('./nonexistent')).to.eql {}
		
		test "will default path to cwd", ()->
			expect(mountenv.get()).to.eql {}
			fs.write ".env", "ABC=123"
			expect(mountenv.get()).to.eql {ABC:'123'}

		test "auto loads .env.dev when NODE_ENV === 'development'", ()->
			fs.write "#{SAMPLE}/.env.dev", "ABC=444"
			process.env.NODE_ENV = 'development'
			expect(mountenv.get(SAMPLE)).to.eql {ABC:'444', DEF:'222', GHI:'333'}

		test "auto loads .env.prod when NODE_ENV === 'production'", ()->
			fs.write "#{SAMPLE}/.env.prod", "DEF=555"
			process.env.NODE_ENV = 'production'
			expect(mountenv.get(SAMPLE)).to.eql {ABC:'111', DEF:'555', GHI:'333'}

		test "auto loads .env.test when NODE_ENV === 'test'", ()->
			fs.write "#{SAMPLE}/.env.test", "GHI=666"
			process.env.NODE_ENV = 'test'
			expect(mountenv.get(SAMPLE)).to.eql {ABC:'111', DEF:'222', GHI:'666'}


	suite ".load()", ()->
		test "loads .env file from given path and extends process env", ()->
			expect(process.env.ABC).to.equal undefined
			expect(process.env.DEF).to.equal undefined
			expect(process.env.GHI).to.equal undefined
			expect(mountenv.load(SAMPLE)).to.equal process.env
			expect(process.env.ABC).to.equal '111'
			expect(process.env.DEF).to.equal '222'
			expect(process.env.GHI).to.equal '333'

	
	suite ".parse()", ()->
		test "parses provided string as env file and returns object", ()->
			contents = fs.read "#{SAMPLE}/.env"
			expect(mountenv.parse(contents)).to.eql {ABC:'111', DEF:'222', GHI:'333'}



