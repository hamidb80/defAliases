import
  macros,
  sequtils, strformat

import strutils # for debug

macro aliases*(symbols: untyped, body: untyped): untyped =
  doAssert symbols.kind == nnkBracket

  let targetDef =
    if body.kind == nnkStmtList: body[0]
    else: body

  result = newStmtList()
  result.add targetDef

  if targetDef.kind in {nnkProcDef, nnkFuncDef, nnkMacroDef, nnkTemplateDef}:
    for smb in symbols:
      var als = quote:
        template `smb`(): untyped = discard

      als[3] = targetDef[3].copy # formalParams
      als[3][0] = ident"untyped" # return type
      als[6] = block: # body
        var cl = newCall(targetDef[0]) # proc name

        cl.add als[3][1..^1].mapIt(
          if it.kind == nnkIdentDefs: it[0]
          else: it)

        cl

      result.add als

  elif true: #TODO: get definiation of var, proc, ...
    discard

  else:
    error fmt"nnk '{body.kind}' can't be uses with aliases macro"

  debugEcho "-----------RESULT---------\n", (result.mapIt it.repr).join '\n'.repeat 2
  return result


# proc testFunc(str= "hey", num = 2): int {.aliases: [ttn, `ttq`].} =
#   num

# echo testFunc("wow", 3)
# echo ttn()
# echo `ttq`("so far, so good")

# macro print(s: typed): untyped {.aliases: [hey].} =
#   quote:
#     echo `s`

template print(): untyped {.aliases: [ali].} =
  echo "print"
  
ali()
