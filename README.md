# CS F301 Principles of Programming Languages — Assignment 2

This is Group 41's repository for the logic and functional programming assignment. The first two problems use Prolog to search for solutions. The next two use recursive list processing in Scheme. Each problem has its own solution, test file, and prompt record.

| Problem | Solution | Tests | What it does |
| --- | --- | --- | --- |
| P1 · Department Assignment Puzzle | [41_q1.pl](code/41_q1.pl) | [p1_tests.pl](tests/p1_tests.pl) | Solves a logic puzzle, counts assignments for a selected set of clues, and adds a ninth clue to make the solution unique. |
| P2 · Form a Valid Arithmetic Equation | [41_q2.pl](code/41_q2.pl) | [p2_tests.pl](tests/p2_tests.pl) | Builds equations from an ordered list of integers and returns canonical, distinct equation strings. |
| S1 · Binary Tree Traversals | [41_q3.rkt](code/41_q3.rkt) | [s1_tests.rkt](tests/s1_tests.rkt) | Prints inorder, preorder, and postorder traversals, as well as the tree's height and leaf count. |
| S2 · Conditionally Insert into a Nested List | [41_q4.rkt](code/41_q4.rkt) | [s2_tests.rkt](tests/s2_tests.rkt) | Inserts an atom into each list whose original top-level length passes a test, including the outer list and empty sublists. |

## Member details

| Group No | Member Name | Member ID |
| --- | --- | --- |
| 41 | Bhavya Rakesh Shah | 2024A7PS0139H |

## Environment

The assignment calls for **SWI-Prolog 9.x** and **Racket 8.x**. This repository was tested on Windows with **SWI-Prolog 9.2.9 (x64-win64)** and **Racket 8.18 [cs]**. The Scheme solutions use `#lang racket/base` and the built-ins allowed by the handout.

From the repository root, check that both executables are on your path.

```text
swipl --version
racket --version
```

The original instructions are in the course handout, `Assignment.pdf`. The file is listed in [.gitignore](.gitignore), so you will need your course copy to open it from a fresh clone.

## Run the Prolog solutions

The grader loads a file with `-f`, runs the goal supplied with `-g`, and exits with `-t halt`. The files have no initialization directives and load silently. P2 predicates return values through their arguments, so the example goals use `writeln/1` or `writeq/1` to show those values at the terminal.

### P1 · Department Assignment Puzzle

`main/0` prints one assignment satisfying the eight original clues, one line per person in Alex, Ben, Carla, and Dana order. `count_solutions(Active, N)` applies only the clue numbers in `Active`. The original puzzle has **three solutions**. Adding clue 9, which places the friend who prefers the AI project in testing, leaves **one solution**. See [P1_REPORT.md](P1_REPORT.md) for the baseline count and its interpretation.

```text
swipl -q -f code/41_q1.pl -g main -t halt
swipl -q -f code/41_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8], N), writeln(N)" -t halt
swipl -q -f code/41_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8,9], N), writeln(N)" -t halt
```

### P2 · Arithmetic equations

`generate_equation/2` finds a valid equation and can enumerate others on backtracking. `all_equations/2` returns the sorted, duplicate-free list, and `count_equations/2` returns its length. Each equation uses the supplied integers in order. Every division must have a nonzero divisor and produce an integer result. The renderer preserves distinct expression trees, so `1+(2+3)` and `1+2+3` remain distinct.

```text
swipl -q -f code/41_q2.pl -g "generate_equation([4,2,5,3], Equation), writeln(Equation)" -t halt
swipl -q -f code/41_q2.pl -g "all_equations([4,2,5,3], Equations), writeq(Equations), nl" -t halt
swipl -q -f code/41_q2.pl -g "count_equations([4,2,5,3], N), writeln(N)" -t halt
```

The first command prints one equation and the count command prints `7`. For an input with no solutions, such as `[2,3,4]`, `generate_equation/2` fails and `all_equations/2` returns `[]`.

## Run the Scheme solutions

Run these commands to check that the files load. Both are expected to exit silently. The grader appends its own calls to the definitions before running the files.

```text
racket code/41_q3.rkt
racket code/41_q4.rkt
```

For S1, the entry points are `print-inorder`, `print-all-traversals`, and `print-height-and-leaves`. They take a tree written as `(value left right)`, with `()` for an empty subtree. For S2, `insert-if-short` returns the transformed list and is built on the higher-order function `make-inserter`. The `print-insert-result` entry point reads the atom, the list, and the threshold from standard input in that order.

To try the same setup by hand in PowerShell, append the calls to a temporary file. The first example prints the three traversals of a symbolic tree, followed by `(2 2)` for height and leaf count. The second prints `((42 1 2) (3 4 5) (42 6) (42))`.

```powershell
$example = New-TemporaryFile
try {
    Copy-Item code/41_q3.rkt -Destination $example.FullName
    Add-Content -LiteralPath $example.FullName -Value @(
        "(print-all-traversals '(a (b () ()) (c () ())))"
        "(print-height-and-leaves '(a (b () ()) (c () ())))"
    )
    racket $example.FullName

    Copy-Item code/41_q4.rkt -Destination $example.FullName
    Add-Content -LiteralPath $example.FullName -Value '(print-insert-result)'
    '42 ((1 2) (3 4 5) (6) ()) 3' | racket $example.FullName
} finally {
    Remove-Item -LiteralPath $example.FullName
}
```

## Run all four test suites

Run each command from the repository root. The Prolog checks exit silently on success and name a failed check if one fails. The Racket test files use RackUnit and append calls to temporary copies of the solutions, as the grader does.

```text
swipl -q -f tests/p1_tests.pl -g run_p1_tests -t halt
swipl -q -f tests/p2_tests.pl -g run_p2_tests -t halt
racket tests/s1_tests.rkt
racket tests/s2_tests.rkt
```

- **P1** checks the numbered clues, selected clue sets, the original and repaired counts, and the exact layout of `main/0` output.
- **P2** checks the handout examples, short and unsatisfiable inputs, exact division, large integers, and parentheses that distinguish different expression trees.
- **S1** checks silent loading and exact output on balanced, right-skewed, symbolic, empty, and single-node trees.
- **S2** checks the four standard-input examples, an exact-length predicate, thresholds at the boundary, empty sublists, nesting depth 100, and a 10,000-element list.

## Skills, prompts, and report

The assignment breaks AI-assisted work into small units, such as a single predicate, function, test file, or review. The prompt records show those units and the commit history shows how they were grouped.

- **Shared skills.** [prolog-dev](skills/prolog-dev/SKILL.md) and [scheme-dev](skills/scheme-dev/SKILL.md) capture the language, coding, and testing rules. The problem skills apply them to [P1](skills/p1-department-puzzle/SKILL.md), [P2](skills/p2-arithmetic-equations/SKILL.md), [S1](skills/s1-tree-traversals/SKILL.md), and [S2](skills/s2-nested-list-insertion/SKILL.md).
- **Prompt records.** The separate files are [P1.md](prompts/P1.md), [P2.md](prompts/P2.md), [S1.md](prompts/S1.md), and [S2.md](prompts/S2.md). [Prompts.md](Prompts.md) collects the prompts verbatim in one table with the problem number and the recorded model label, `GPT-6.2-Sol`.
- **P1 report.** [P1_REPORT.md](P1_REPORT.md) records the query for clues 1 through 8 and explains what the result says about the puzzle.

## Test results

All four suites passed on November 22, 2026, using SWI-Prolog 9.2.9 and Racket 8.18 [cs].

| Suite | Result | Checks passed |
| --- | --- | --- |
| P1 · Department assignment | Pass | 7 of 7 |
| P2 · Arithmetic equations | Pass | 7 of 7 |
| S1 · Binary tree traversals | Pass | 6 of 6 |
| S2 · Nested list insertion | Pass | 10 of 10 |

The Prolog runners exited silently with status zero. RackUnit reported zero failures and zero errors for both Scheme suites.

This repository is available under the [MIT License](LICENSE).
