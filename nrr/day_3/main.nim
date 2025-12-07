import strutils
import strformat
import std/tables
import std/sequtils
import std/algorithm

let input_lines = readFile("input.txt.secret").strip().splitLines()

var banks = newSeq[seq[int]]()
for line in input_lines:
  var b = newSeq[int]()
  for d in line:
    b.add(parseInt("" & d))
  banks.add(b)


proc find_highest_joltage(subset:seq[int], digits: int): int =
  assert len(subset) >= digits

  var pivot = (0,0)
  for bank in subset[0..len(subset) - digits].pairs:
    for n in countdown(9,1):
      if bank[1] > pivot[1]: pivot = bank
      if pivot[1] >= n: break

  if len(subset) == 1 or digits == 1:
    return pivot[1]

  let num = find_highest_joltage(subset[pivot[0]+1..len(subset)-1], digits-1)
  return parseInt(fmt "{pivot[1]}{num}")
  

proc main() =

  # Pt 1 Logic
  var result: int = block:
    var res = 0
    for b in banks:
      res += find_highest_joltage(b,2)
    res

  # Pt 2 Logic
  var result2: int = block:
    var res = 0
    for b in banks:
      res += find_highest_joltage(b,12)
    res


  echo "=== AoC Day 2 Part 1 ==="
  echo "Final Result: ", result
  echo "=== AoC Day 2 Part 2 ==="
  echo "Final Result: ", result2


proc test() =
  var t1:int = find_highest_joltage(@[1,2,3,4,5], 2)
  assert t1 == 45, fmt "{t1}"
  var t2:int = find_highest_joltage(@[9,2,3,4,5], 2)
  assert t2 == 95, fmt "{t2}"
  var t3:int = find_highest_joltage(@[1,2,8,4,5], 2)
  assert t3 == 85, fmt "{t3}"
  var t4:int = find_highest_joltage(@[1,8,8,4,5], 2)
  assert t4 == 88, fmt "{t4}"
  var t5:int = find_highest_joltage(@[1,8,2,8,5], 2)
  assert t5 == 88, fmt "{t5}"
  var t6:int = find_highest_joltage(@[1,8,2,8,5], 3)
  assert t6 == 885, fmt "{t6}"


test()
main()
