import strutils
import strformat
import std/tables
import std/sequtils
import std/algorithm



let input_lines = readFile("input.txt.secret").strip().split(',')
var id_pairs = newSeq[(int,int)]()
for line in input_lines:
  let pair = line.split('-')
  id_pairs.add((parseInt(pair[0]), parseInt(pair[1])))



proc main() =
  var matches_pt1: Table[int,int]
  var matches_pt2: Table[int,int]

  # Pt 1 Logic
  for (start,stop) in id_pairs:
    for i in start .. stop:
      if matches_pt1.contains(i):
        matches_pt1[i] += 1
        continue

      let str = fmt "{i}"

      if len(str) < 2:
        continue
      
      if len(str) mod 2 != 0:
        continue

      if all(str, proc (x: char): bool = x == str[0]):
        matches_pt1[i] = 1
        continue

      let half_point = len(str) div 2
      if str[0..half_point-1] == str[half_point..len(str)-1]:
        matches_pt1[i] = 1
        continue

  # Pt 2 Logic
  for (start,stop) in id_pairs:
    for i in start .. stop:
      if matches_pt2.contains(i):
        matches_pt2[i] += 1

      let str = fmt "{i}"

      if len(str) < 2:
        continue

      if len(str) mod 2 != 0 and all(str, proc (x: char): bool = x == str[0]):
        matches_pt2[i] = 1
        continue
      
      let half_point = len(str) div 2
      if str[0..half_point-1] == str[half_point..len(str)-1]:
        matches_pt2[i] = 1
        continue

      var size = half_point - 1
      while size >= 2:
        if len(str) mod size != 0:
          size -= 1
          continue

        var all_matching = true
        for ind in countup(0+size, len(str)-1, size):
          if str[ind..ind+size-1] == str[0..size-1]:
            continue
          else:
            all_matching = false
            break

        
        if all_matching:
          matches_pt2[i] = 1
          break

        size -= 1

  var result: int = 0
  for (k,v) in matches_pt1.pairs:
    result += v*k
  var result2: int = 0
  for (k,v) in matches_pt2.pairs:
    result2 += v*k

  echo "=== AoC Day 2 Part 1 ==="
  echo "Final Result: ", result
  echo "=== AoC Day 2 Part 2 ==="
  echo "Final Result: ", result2


proc test() =
  let t1 = "999"
  assert all(t1, proc (x: char): bool = x == t1[0])
  
  let t2 = "121212"
  var half_point = len(t2) div 2
  assert half_point == 3 
  assert t2[0..half_point-1] == "121"
  assert t2[half_point..len(t2)-1] == "212"
  half_point = half_point-1
  assert t2[0..half_point-1] == "12"

  let t3 = "123123123"
  half_point = len(t3) div 2
  assert half_point == 4
  assert t3[0..half_point-1] == "1231"
  assert t3[half_point..len(t3)-1] == "23123"
  half_point = half_point-1
  assert t3[0..half_point-1] == "123"

  let t4 = "1188511880"
  half_point = len(t4) div 2
  assert half_point == 5
  assert len(t4) mod half_point == 0
  half_point -= 1
  assert len(t4) mod half_point > 0


test()
main()
