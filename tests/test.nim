import unittest, macros
import defAliases

suite "test":
  test "macro alias":
    macro sample(s: typed): untyped {.aliases: [hey].} =
      quote:
        $ `s`

    check sample(2) == "2"
    check hey(false) == "false"

  # test "template alias": # isn't ready yet
  #   template print(): untyped {.aliases: [ali].} =
  #     echo "print"

  #   ali()
  
  test "proc alias":
    proc sample(arg1: int, arg2 = false): string {.aliases: [stick, `&**`].} =
      $arg1 & $arg2
    
    check sample(2, false) == "2false"
    check (1 &** true) == "1true"
    check (1.stick true) == "1true"

  test "func alias":
    func sample(arg1: int, arg2 = false): string {.aliases: [stick, `&**`].} =
      $arg1 & $arg2

    check sample(2, false) == "2false"
    check (1 &** true) == "1true"
    check (1.stick true) == "1true"
