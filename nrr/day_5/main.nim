import strutils
import algorithm

type FreshRange = (int,int)
type IngredientList = seq[int]

let 
  input_lines = readFile("input.txt.secret").strip().splitLines()

  (input_ranges, input_ingredients) = block:
    var split = 0
    for l in input_lines.pairs:
      if l[1] == "": 
        split = l[0]
        break
    (input_lines[0..split-1], input_lines[split+1..len(input_lines)-1])

var 
  fresh_ranges = block:
    var ranges = newSeq[FreshRange]()
    for line in input_ranges:
      let split = line.split('-')
      ranges.add (parseInt(split[0]), parseInt(split[1]))
    ranges

  ingredients = block:
    var ids: IngredientList = @[]
    for line in input_ingredients:
      ids.add parseInt(line)
    ids

proc is_ingredient_fresh(ranges:seq[FreshRange], id:int): bool =
  for (a,b) in ranges:
    if id <= b and id >= a: return true

proc main() =
  # Pt 1 Logic
  let result: int = block:
    var fresh = 0
    for i in ingredients:
      if is_ingredient_fresh(fresh_ranges, i): fresh += 1
    fresh
        
  # Pt 2 Logic
  let result2: int = block:
    let ranges = fresh_ranges.sortedByIt(it[0])
    var 
      ids = 0
      (last_a,last_b) = (ranges[0][0], ranges[0][1])

    for (a,b) in ranges[1..len(ranges)-1]:
      if b <= last_b:
        continue
      elif a > last_b:
        ids += (last_b-last_a)+1
        (last_a, last_b) = (a,b)
      elif a <= last_b:
        last_b = b

    ids += (last_b - last_a) + 1
    ids

  echo "=== AoC Day 5 Part 1 ==="
  echo "Final Result: ", result
  echo "=== AoC Day 5 Part 2 ==="
  echo "Final Result: ", result2


main()
