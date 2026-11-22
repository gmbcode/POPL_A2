---
name: s2-nested-list-insertion
description: Implement or review one unit of S2, the Scheme nested-list insertion in code/41_q4.rkt.
---

# S2 Conditionally Insert into a Nested List

Apply the [Scheme development skill](../scheme-dev/SKILL.md). Use [S2.md](../../prompts/S2.md) one block at a time and consult the S2 examples in [Assignment.pdf](../../Assignment.pdf).

- Measure each original list's top-level length. Transform sublists at every level, including empty sublists, and treat the root list the same way. Preserve atoms and element order. Detect list-valued elements with `null?` and `pair?`.
- Implement `my-length` and `my-map` from the allowlist. In the final source, the single `insert-if-short` definition uses `make-inserter` with the test that length is strictly less than `n`.
- `make-inserter` captures the atom and the length predicate and returns a unary function on lists. Use the supplied predicate for each original list, including when it accepts zero or an exact length.
- `print-insert-result` reads `x`, `lst`, and `n` in that order using `read`, then displays the result and a newline. Read only during the call and emit no prompt.

Before answering, check an empty root, nested empty lists, a list whose length equals the threshold, and a test predicate other than less-than. Review for repeated scans within the same flat list and check the PDF's depth-100 and 10,000-element cases when reviewing the integrated implementation.
