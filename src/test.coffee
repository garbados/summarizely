fs = require 'fs'
summarize = require './index'

content = fs.readFileSync('test.txt').toString()
sparknotes = (summarize content).join('\n')
ratio = ((1 - (sparknotes.length / content.length))*100).toFixed(2)

console.log sparknotes
console.log "\nText reduced #{ratio}%, from #{content.length} to #{sparknotes.length} characters"