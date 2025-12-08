import strutils
import algorithm

type Op = enum 
  unk = "",
  add = "+",
  mul = "*",

type Equation = tuple[vars: seq[int], op:Op]

proc run(eq:Equation): int =
  var res = eq.vars[0]
  for v in eq.vars[1..len(eq.vars)-1]:
    case eq.op:
      of Op.add:
        res = res + v
        # echo res+v
      of Op.mul:
        res = res * v
        # echo res * v
      of Op.unk:
        discard()
  # echo "===="
  res


let 
  input_lines = readFile("input.txt.secret").strip().splitLines()

var
  equations = block:
    var 
      eqs = newSeq[Equation]()
      e_ind = 0

    for line in input_lines:
      let values = line.split(' ')
      for v in values:
        if v.isEmptyOrWhitespace(): continue
        if len(eqs)-1 < e_ind:
          eqs.add((newSeq[int](), Op.unk))

        if not (v in @[Op.add.repr, Op.mul.repr]):
          eqs[e_ind].vars.add(parseInt(v))
        else:
          case v:
            of "+":
              eqs[e_ind].op = Op.add
            of "*":
              eqs[e_ind].op = Op.mul
              
        e_ind += 1
      e_ind = 0

      continue
    eqs 

proc main() =
  # echo input_lines
  # echo equations

  # Pt 1 Logic
  let result: int = block:
    var result = 0
    for e in equations:
      result += e.run()
      # echo result
    result
    
  # Pt 2 Logic
  let result2: int = 0
  echo "=== AoC Day 5 Part 1 ==="
  echo "Final Result: ", result
  echo "=== AoC Day 5 Part 2 ==="
  echo "Final Result: ", result2


main()
