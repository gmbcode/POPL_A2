# P1 solution count

The query

```prolog
?- count_solutions([1,2,3,4,5,6,7,8], N).
N = 3.
```

finds three complete assignments. The eight original clues leave the puzzle underdetermined because they allow more than one assignment of departments, languages, and projects to the four friends.
