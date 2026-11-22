---
name: scheme-dev
description: Develop or review Racket 8.x Scheme functions for S1 and S2 of CS F301 Assignment 2.
---

# Scheme development

Use Racket 8.x and start each source file with `#lang racket/base`. Read the relevant section of [Assignment.pdf](../../Assignment.pdf) and follow the guidance for [S1](../s1-tree-traversals/SKILL.md) or [S2](../s2-nested-list-insertion/SKILL.md).

- Work on the single function, test file, or review requested in the current prompt. Use lowercase hyphenated names, question marks for Boolean predicates, and concise comments that state recursive cases or accumulator invariants.
- The source allowlist is `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` with `else`, `and`, `or`, `not`, `begin`, `quote` written as `'`, `cons`, `car`, `cdr`, `list`, all `car`/`cdr` compositions up to four levels, `null?`, `pair?`, `eq?`, `assq`, `assoc`, `+`, `-`, `*`, `<`, `>`, `<=`, `>=`, `=`, `max`, `display`, and `newline`. S2 also permits `read`.
- Keep source files definition-only after the language line. Pass state through arguments and use recursion.
- Check that `racket code/41_q3.rkt` and `racket code/41_q4.rkt` load silently once implemented. To test entry points as the grader does, run a temporary copy with test calls appended. Supply standard input for S2's print entry point.

## Known AI failure modes

- **Using built-ins outside the allowlist.** Generated Racket code often reaches for `set!`, `list?`, `length`, `map`, `append`, or `reverse`. Audit the solution source and use recursive helpers where needed.
- **Mishandling empty lists.** Accessing a tree's fields before checking for `()` raises an error. Using only `pair?` to identify S2 sublists skips `()` and misses eligible insertions.
- **Reversing traversal order.** Accumulating with `cons` reverses the visit order. Check that the result restores the intended order and visits each left subtree before its right sibling.
- **Miscounting tree height or leaves.** A node with one child is an internal node. Check a skewed tree and a tree with two nonempty subtrees of unequal height to verify the leaf test and the use of the larger subtree height.
- **Measuring the wrong list.** The insertion predicate uses each original list's top-level length, counting a sublist as one element. Apply the same rule to the outer list and every nested list, including empty ones.

## Self-review

- Check every form and built-in in the changed source against the allowlist.
- Check the empty case and the recursive step, especially visit order, accumulator order, and how `null?` differs from `pair?`.
- Confirm that only the print entry points emit output and that each displayed line ends with one newline.
- Report which calls were run and which behaviors remain unverified.
