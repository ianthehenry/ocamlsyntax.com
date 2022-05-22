---
title: "OCaml Signatures"
---

Annotated return type:

```ocaml
val succ : int -> int

let succ x : int = x + 1
```

Annotated positional argument:

```ocaml
val succ : int -> int

let succ (x : int) = x + 1
```

Annotated return type and positional argument:

```ocaml
val succ : int -> int

let succ (x : int) : int = x + 1
```

Named argument:

```ocaml
val succ : x:int -> int

let succ ~x = x + 1
```

Renamed argument:

```ocaml
val succ : x:int -> int

let succ ~x:y = y + 1
```

Named argument with annotated return type:

```ocaml
val succ : x:int -> int

let succ ~x : int = x + 1
```

Note that the space between the identifier and the colon is significant to
disambiguate this from a renamed argument.

Renamed argument with annotated return type:

```ocaml
val succ : x:int -> int

let succ ~x:y : int = y + 1
```

The space between the identifier and the second colon is no longer required, as
there is no more ambiguity.

Annotated named argument:

```ocaml
val succ : x:int -> int

let succ ~(x : int) = x + 1
```

Annotated renamed argument:

```ocaml
val succ : x:int -> int

let succ ~x:(y : int) = y + 1
```

Optional argument:

```ocaml
val succ : ?x:int -> unit -> int option

let succ ?x () = x + 1
```

Note that optional arguments without subsequent positional arguments will generate a compiler warning, so we add a final unit argument to get around that. [See here for more information.][warning-16]

<aside>

For functions that take optional arguments without defaulting them, we will assume that `(+)` has been redefined like so:

```ocaml
let (+) x y = Option.map (fun x -> x + y) x;;
```

Or, using the `Option` module from `Core`:

```ocaml
let (+) x y = Option.map ~f:(fun x -> x + y) x;;
```

</aside>

Optional argument with a default value:

```ocaml
val succ : ?x:int -> unit -> int

let succ ?(x = 0) () = x + 1
```

Annotated optional argument:

```ocaml
val succ : ?x:int -> unit -> int option

let succ ?(x : int) () = x + 1
```

Annotated optional argument with a default value:

```ocaml
val succ : ?x:int -> unit -> int

let succ ?(x : int = 0) () = x + 1
```

Renamed annotated optional argument with a default value:

```ocaml
val succ : ?x:int -> unit -> int

let succ ?x:(y : int = 0) () = y + 1
```

Locally abstract type (monomorphic):

```ocaml
val foo : 'a -> unit

let foo (type a) (x : a) = ignore x
```

You will often see type variables introduced like this so that a GADT's phantom
can vary over different branches of a match statement:

```ocaml
val foo : 'a My_gadt.t -> unit

let foo (type a) (x : a My_gadt.t) = ignore x
```

[See here for more information.][monomorphic]

Locally abstract type (polymorphic):

```ocaml
val foo : 'a My_gadt.t -> unit

let foo : type a. a My_gadt.t -> unit =
  fun x -> ignore x
```

This is useful when you have a recursive GADT where the components of a value
have a different phantom type than the value
itself. [See here for more information.][polymorphic]

[warning-16]: https://ocaml.org/learn/tutorials/labels.html#quot-Warning-This-optional-argument-cannot-be-erased-quot
[monomorphic]: https://ocaml.org/manual/locallyabstract.html
[polymorphic]: https://ocaml.org/manual/gadts.html
