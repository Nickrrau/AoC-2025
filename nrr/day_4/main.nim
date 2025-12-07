import strutils

type paper_roll = bool
type cell = (int,int)

let input_lines = readFile("input.txt.secret").strip().splitLines()

var grid = newSeq[seq[paper_roll]]()
for line in input_lines:
  var row = newSeq[paper_roll]()
  for d in line:
    if d == '@': row.add(true) else: row.add(false)
  grid.add(row)


proc locate_movable_rolls(g: seq[seq[paper_roll]]): seq[cell] = 
  var cells = newSeq[cell]()

  for (row_index, row) in g.pairs:
    for (cell_index,cell) in row.pairs:
      if not cell: continue

      var adjacent = 0

      for rd in [-1,0,1]:
        for cd in [-1,0,1]:
          let coord = (rd+row_index, cd+cell_index)

          if coord == (row_index,cell_index): continue

          if coord[0] >= len(g) or coord[0] < 0: continue

          if coord[1] >= len(g[coord[0]]) or coord[1] < 0: continue

          if g[coord[0]][coord[1]]: adjacent += 1

      if adjacent < 4:
        cells.add((row_index,cell_index))

  return cells

proc main() =
  # Pt 1 Logic
  let result: int = len(locate_movable_rolls(grid))
        
  # Pt 2 Logic
  var result2: int = 0 
  var grid_copy = grid
  while true:
    let target_cells = locate_movable_rolls(grid_copy)
    if len(target_cells) == 0: break
    result2 += len(target_cells)

    for (row_index, row) in grid_copy.mpairs:
      for (cell_index,cell) in row.mpairs:
        let coord = (row_index, cell_index)
        if coord in target_cells: cell = false



  echo "=== AoC Day 4 Part 1 ==="
  echo "Final Result: ", result
  echo "=== AoC Day 4 Part 2 ==="
  echo "Final Result: ", result2


main()
