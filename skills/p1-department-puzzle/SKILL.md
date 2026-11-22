---
name: p1-department-puzzle
description: Implement or review one unit of P1, the Prolog department assignment puzzle in code/41_q1.pl.
---

# P1 Department Assignment Puzzle

Apply the [Prolog development skill](../prolog-dev/SKILL.md). Use P1 in [Assignment.pdf](../../Assignment.pdf) as the source for the numbered clues. Work from one block at a time in [P1.md](../../prompts/P1.md).

- Represent a solution as four `p(Name, Dept, Lang, Project)` terms ordered by `'Alex'`, `'Ben'`, `'Carla'`, `'Dana'`. Use each supplied value exactly once per attribute. Preserve the exact atoms, including `'c++'` and `'AI'`.
- Keep each clue as its own numbered `clue/2` clause. Apply the requested clues to ground candidate lists. Check the direction of each implication, especially the clues about testing, Java, and data.
- `main/0` prints one answer for clues 1 through 8. Match the four-line `Name = [dept, lang, project]` layout with unquoted display values. The PDF's sample assignment is a formatting example.
- `count_solutions(Active, N)` counts distinct candidates satisfying every clue in `Active`. Omitted clues impose no constraint. Use `findall/3` or `aggregate_all/3`. The baseline count and its meaning belong in `P1_REPORT.md`.
- For clue 9, compare the actual candidates for clues 1 through 8. Select an attribute-only condition true of exactly one candidate. Put the English condition in a comment beginning `% CLUE 9:` directly above its clause.

Before answering, check the requested clue or predicate against its contract. When reviewing the integrated puzzle, verify the baseline count, the repaired count of one, and the four output lines from `main/0` independently.
