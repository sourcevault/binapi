
![](https://raw.githubusercontent.com/sourcevault/binapi/readme/logo.jpg)

```js
npm install binapi
// github        much install     |
npm install sourcevault/binapi#dist
```

[![Build Status](https://travis-ci.org/sourcevault/binapi.svg?branch=dev)](https://travis-ci.org/sourcevault/binapi)

.. **Basic Example**

```js
var binapi = require ("binapi")

var main = function (flags,args)
{

	var a = args[0]
	var b = args[1]

	if (flags.flip) // flip arguments
	{
			var temporary = a
			a = b
			b = temporary
	}

	var output = a - b

	if (flags.abs) // output only absolute value
	{
			return Math.abs (output)
	}


	return output

}

var subtract = binapi(main)

subtract(10,5) // 5

subtract.flip(10,5) // - -5

subtract.flip.abs(10,5) //  5

subtract.abs.flip(10,5) //  5

// last two operations are doing the same thing


```

As shown in the above listing, we are using object properties as switches to turn "ON" certain flags in `main` above.

It's a pattern that can be used in situations where there is a need for module consumers to start with sane defaults and then play around with module flags to customize functionality, instead of embedding them in an object and passing it as an extra argument  - which can be a hassle.

[colors](https://www.npmjs.com/package/colors) is a good example of module that follows this pattern.

`binapi` is a shorthand for binary APIs.

.. **Features**

 - functions are built lazily, if you have 100 flags and use only 3 functions that use *n* flag combination - then only 3 functions are created.

 - The first argument `flags` referred in the above code points to an [seamless-immutable](https://github.com/rtfeldman/seamless-immutable) object that can be used to query what flags the user has enabled.

.. **List**

In the above example we used a flat object where there is loss of information regarding order. In case order matters then use `binapi.list`( default is `binapi.obj` ) :

```js

var binapi = require ("binapi")

folks =
{
	charles:{age:null},
	henry:{age:null}
}

var main = function (flags,args)
{
	name = flags[0]

	folks[name] = args[0]
}

var setAge = binapi.list(main)

setAge.charles(32)

setAge.henry(29)

console.log(folks.charles) // 32

console.log(folks.henry) //29

```

.. **Type consistency for `binapi.obj`**

Its best to pass all possible flags the program accepts while generating the public function. Using `subtract` from the basic example above :

```js
var binapi = require ("binapi")

flags = ["flip","abs"]

var sub = binapi(subtract,flags)

```

 Now within `subtract` we get a more consistant type.

```js
var subtract = function (flags)
{
	if (flags.flip) // false instead of undefined
	{
			// ... //
	}
	// ... //
	if (flags.abs) // false instead of undefined
	{
			// ... //
	}
	// ... //
}
```

.. **Custom Logging**

Interally `binapi` uses ES6 proxies allowing us to bind custom log functions - making it possible to provide better object information when `console.log` ing the object :

A custom logger can be passed either using `util.inspect.custom` or `log` key attached to the the main function :

```js

var binapi = require ("binapi")

main = function (){}

main.log = function(path)
{
	var chain = ""path.join(' | ')

	console.log ( "( " + chain + " )")
}
test = binapi.list(main)

tsf = test.sync.flip

console.log (tsf) // ( sync | flip )

```

#### .. passing state

Sometimes some state has to be present in your function, this is especially useful for nested proxies.

```js
var binapi = require("binapi");

var main = function(path, args, state){

		var number = args[0];

		if (path.length === 0) {

			return binapi.list(main, number);

		} else if (path.length === 1) {

			type = path[0];

			if (type === "add") {

				return binapi.list(main, state + number);

			} else if (type === "multiply") {

				return binapi.list(main, state*number);

			} else if (type === "ret") {

				return state;

			}
		} else {

			return console.log("Error !");

		}

	};

var compute = binapi.list(main);

var out = compute(5)
.add(5)
.multiply(10)
.ret();

console.log(out);
```

## Update and API change

- `0.0.4` major change in API, does not use `this` but uses argument to pass `path` and `state`.

## LICENCE

- Code released under MIT Licence, see [LICENSE](https://github.com/sourcevault/binapi/blob/dist/LICENCE) for details.

- Documentation and Images released under CC-BY-4.0 see [LICENSE](https://github.com/sourcevault/binapi/blob/dev/LICENCE1) for details.
