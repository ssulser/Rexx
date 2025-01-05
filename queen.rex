/****************************************/
/* Regina REXX - N Queen Problem Solver */
/* v1.0 - Simon Sulser, 25.12.2024      */
/****************************************/

board. = 0
parse arg N .

if N < 4 | N > 23 then
do
  say 'The range has to be 4 - 23. Setting to default (=4) now.'
  N = 4
end

say 'Start calculating...'
call queen
exit 0


print_solution: procedure expose N board.
  call lineout ,copies('+---',N) || '+'
  do row=1 to N
    do col=1 to N
      call charout ,'| ' || translate(board.col.row,'-X','01') || ' '
    end col
    call lineout ,'|' || .ENDOFLINE || copies('+---',N) || '+'
  end row
  return


isSafe: procedure expose N board.
  parse arg col, row
  do x=1 to col                              /* check row on left is safe */
    if board.x.row = 1 then return 0
  end x
  x=col; y=row
  do while x>0 & y>0                         /* check left upper diagonal */
    if board.x.y = 1 then return 0
    x=x-1; y=y-1
  end
  x=col; y=row
  do while x>0 & y<=N                        /* check left lower diagonal */
    if board.x.y = 1 then return 0
    x=x-1; y=y+1
  end
  return 1                                   /* is safe */


place: procedure expose N board.
  parse arg col
  if col > N then return 1                   /* all queens placed */

  do row=1 to N
    if isSafe(col,row) then do
      board.col.row = 1
      if place(col+1) then return 1
      board.col.row = 0
    end /* if */
  end row
  return 0                                  /* no solutions found */


queen: procedure expose N board.
  if place(1) then       /* starting in colomn 1 */
    call print_solution
  else
    say 'No solution found.'
  return