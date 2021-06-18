## Idea:

we are gonna take this:

```nim
proc sample(arg1: int, arg2 = false): string {.aliases: [stick, `&**`].} =
  $arg1 & $arg2
```

and turn it into this:
```nim
proc sample(arg1: int, arg2 = false): string =
  $arg1 & $arg2

template stick(arg1: int, arg2 = false): untyped =
  sample(arg1, arg2)

template `&**`(arg1: int, arg2 = false): untyped =
  sample(arg1, arg2)
```

**then you can use it with either it's aliases or it's real name:**
```nim
1 &** true         # :: "1true"
1.stick true       # :: "1true"
1.sample true      # :: "1true"
```

isn't it interesting?

## limitations:
you can't use it with temaplate [because of this bug [link](https://github.com/nim-lang/Nim/issues/18212)] but `proc`s, `func`s, `macro`s are supported


## TODO
- publish it in nimble