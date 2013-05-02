fs = require 'fs'
summarize = require './index'

content = fs.readFileSync('test.txt').toString()

console.log (summarize content).join('\n')