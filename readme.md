![](https://raw.githubusercontent.com/sourcevault/binapi/dev/logo.jpg)

<!-- ![](./logo.jpg) -->

```js
npm install binapi
// github        much install     |
npm install sourcevault/binapi#dist
```

[![Build Status](https://travis-ci.org/sourcevault/binapi.svg?branch=dev)](https://travis-ci.org/sourcevault/binapi)

🟡 *.. quick Example 1 ..*

```js
var binapi = require ("binapi")

var main = function (state,args)
{

  var a = args[0]
  var b = args[1]

  if (state.flip) // flip arguments
  {
      var temporary = a
      a = b
      b = temporary
  }

  var output = a - b

  if (state.abs) // output only absolute value
  {
      return Math.abs(output)
  }

  return output

}

getter = function(state,key) {
  state[key] = true
  return state;
}

var subtract = binapi(main,getter,{})

subtract(10,5) // 5

subtract.flip(10,5) // - -5

subtract.flip.abs(10,5) //  5

subtract.abs.flip(10,5) //  5

// last two operations are doing the same thing

```

As shown above, we are using object properties as switches to turn "ON" certain flags in `main`.

[colors](https://www.npmjs.com/package/colors) is a good example of module that follows this pattern.

`binapi` is a shorthand for binary APIs.

.. **Features**

 - functions are built lazily, if you have 100 methods but the user only uses 3 functions - then only 3 objects are created.

`binapi` requires 2 functions to initialize :

- *application function* - it is run whenever there is a call from the user.
- *getter function* - it is used to resolve `.` operations issued by the user.


🟡 *...Example 2...*

```js

var binapi = require ("binapi")

folks =
{
  charles:{age:null},
  henry:{age:null}
}

var main = function(key,args)
{

  folks[key] = args[0]
}

var getter = function(state,key) {return key}

var setAge = binapi(main,getter)

setAge.charles(32)

setAge.henry(29)

console.log(folks.charles) // 32

console.log(folks.henry) //29

```

#### ..using state variable

Sometimes some state has to be present in your function, this is especially useful for nested `binapi`s.

🟡 *..Example 3 - adding state variable as second argument..*

```js
var binapi = require("binapi");

var main,getter;

var loop = (state) => binapi(main,getter,state);

var get = ([num],key) => [num,key];

var F6 = ([x,key],args) =>

  var y = args[0]

  switch (key) {
  case "init":
    return loop([y]);
  case "add":
    return loop([x + y]);
  case "multiply":
    return loop([x * y]);
  case "ret":
    return x;
  default:
    return fail(6);

var compute = lopo(["init"])

var out = compute(5)
.add(5)
.multiply(10)
.ret!
```

#### Custom Logger

Internally `binapi` uses ES6 proxies allowing binding of custom log functions - providing us with the option of providing better object information when using `console.log`, custom log function is added as the 4rth argument.


🟡 *..Example 4 - custom logger provided as third argument..*

```js
var binapi = require ("binapi")

var main = function (){}

var getter = function(state,key) {return state.concat(key);}

var log = function(state)
{
  var chain = state.join(' | ')

  console.log ("( " + chain + " )")
}
test = binapi(main,getter,[],log)

tsf = test.sync.flip

console.log (tsf) // ( sync | flip )
```

#### Update and API change

- `0.1.0` major change in API, support for `binapi.obj` dropped.

- `0.0.8` major change in API, default `binapi` is list.

- `0.0.4` major change in API, does not use `this` but uses argument to pass `path` and `state`.

#### LICENCE

- Code released under MIT Licence, see [LICENSE](https://github.com/sourcevault/binapi/blob/dist/LICENCE) for details.

- Documentation and image released under CC-BY-4.0 see [LICENSE](https://github.com/sourcevault/binapi/blob/dev/LICENCE1) for details.
