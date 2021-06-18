import unittest, macros
import macros
import aliases

macro print(s: typed): untyped {.aliases: [hey].} =
  quote:
    echo `s`

print "s"
hey 2


# proc testFunc(str= "hey", num = 2): int {.aliases: [ttn, `ttq`].} =
#   num

# echo testFunc("wow", 3)
# echo ttn()
# echo `ttq`("so far, so good")

# macro print(s: typed): untyped {.aliases: [hey].} =
#   quote:
#     echo `s`

# template print(): untyped {.aliases: [ali].} =
#   echo "print"
  
# ali()