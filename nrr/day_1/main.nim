import strutils
import strformat
import math

let input_lines = readFile("input.txt.secret").strip().splitLines()
var dir_num = newSeq[(char,int)]()
for line in input_lines:
  dir_num.add((line[0], parseInt(line[1..high(line)])))

# Return new position on dial + number of times landed on 0
proc rotate(cur_pos:int, dir:char, steps:int): (int, int) =
  let new_pos = block:
    if dir == 'R':
      cur_pos + steps
    else:
      cur_pos - steps
  
  let new_pos_norm = euclMod(new_pos, 100)
  var revolutions = abs new_pos div 100

  if cur_pos != 0 and new_pos <= 0:
    revolutions += 1

  return (new_pos_norm, revolutions)

proc main() =
   var
       dial_pos: int = 50
       times_stopped_on_zero: int = 0
       times_passed_zero: int = 0

   for (dir, steps) in dir_num:
     let (new_dial_pos, zero_pass_count) = rotate(dial_pos, dir, steps)

     if new_dial_pos == 0:
       times_stopped_on_zero += 1
        
     times_passed_zero += zero_pass_count
     dial_pos = new_dial_pos
   

   echo "=== AoC Day 1 Part 1 ==="
   echo "Final Zero Counts: ", times_stopped_on_zero

   echo "\n=== AoC Day 1 Part 2 ==="
   echo "Final Zero Counts: ", times_passed_zero

proc test() =
   # Sample Tests
   assert rotate(50, 'L', 68) == (82,1) 
   assert rotate(82, 'L', 30) == (52,0)
   assert rotate(52, 'R', 48) == (0,1)
   assert rotate(0, 'L', 5) == (95,0)
   assert rotate(95, 'R', 60) == (55,1)
   assert rotate(55,'L',55) == (0,1)
   assert rotate(0,'L',1) == (99,0)
   assert rotate(99,'L',99) == (0,1)
   assert rotate(0,'R',14) == (14,0)
   assert rotate(14,'L',82) == (32,1)

   # Input Tests
   assert rotate(50,'R',980) == (30,10), fmt "{rotate(50,'R',980)}" 
   assert rotate(50,'R',449) == (99,4), fmt "{rotate(50,'R',449)}" 
   assert rotate(50,'R',795) == (45,8), fmt "{rotate(50,'R',795)}" 
   assert rotate(50,'L',781) == (69,8), fmt "{rotate(50,'L',781)}" 

test()
main()
