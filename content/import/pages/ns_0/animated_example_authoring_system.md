---
title: "Animated Example Authoring System"
source_namespace: "ns_0"
source_filename: "Animated_Example_Authoring_System.md"
---

Animated Examples can be created using a tool called [Jsvee
transpiler](http://acos.cs.hut.fi/jsvee-transpiler-python) from [ACOS
Content Server](http://acos.cs.hut.fi/).

This tool transpiles the
given Python code into form that Jsvee understands and can execute. Not
all Python language features are supported. Arithmetical operations,
assignments, while loops, for loops to iterate a list, functions, lists,
dictionaries and simple classes are available. The only built-in
functions available are: float, input, int, len, list.append and print.
You will get an error if the code contains language features which are
not available.

Here is a brief introduction of how to use this
[tool:
#](tool:
#) Type some Python code.

# Transpile the code by

pressing the button below.

# Check that the animation works.

# Copy

the transpiled code in the textbox and save it as JSON file that is
available online.

# The created animation can be launched with URL such

as:
[http://acos.cs.hut.fi/html/jsvee/jsvee-python-json/transpiler?url=http://www.cs.hut.fi/~ttsirkia/transp/animation.json

In](http://acos.cs.hut.fi/html/jsvee/jsvee-python-json/transpiler?url=http://www.cs.hut.fi/~ttsirkia/transp/animation.json

In)
this case, animation.json contains the transpiled code.

You could
change "html" in the URL by your specific requirement to support your
launching mechanism but then you should be able to add that one extra
GET parameter. Another option is to clone the server architecture from
GitHub and inject the transpiled code to this
[file:
https://github.com/acos-server/acos-jsvee-python/blob/master/static/JSVEE-content-min.js


Furthermore](file:
https://github.com/acos-server/acos-jsvee-python/blob/master/static/JSVEE-content-min.js


Furthermore),
we can create annotations for the animated examples using another tool
called [Annotation editor](http://acos.cs.hut.fi/kelmu-editor) from
[ACOS Content Server](http://acos.cs.hut.fi/).
