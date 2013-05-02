# SUMMARIZELY

A CoffeeScript implementation of Shlomi Babluki's [naive summary tool](https://gist.github.com/shlomibabluki/5473521). Works like this:

	summarize = require 'summarizely'
	content = "The complete contents of Moby Dick, in a single string"

	sparknotes = summarize content
	console.log sparknotes

You have now defeated English class.

## Install

	npm install git://github.com/garbados/summarizely.git

## How It Works

Shlomi goes into more detail, but here's the skinny:

* Breaks text into paragraphs
* Splits paragraphs into sentences
* For each paragraph, selects the best sentence
* Returns list of best sentences

...where "best" means "has most in common with other sentences in that paragraph."

## Tests

Run `npm test` to be treated to a summary of Paul Miller's ["I’m still here: back online after a year without the internet"](http://www.theverge.com/2013/5/1/4279674/im-still-here-back-online-after-a-year-without-the-internet)