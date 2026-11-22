---
name: p2-arithmetic-equations
description: Implement or review one unit of P2, the Prolog arithmetic equation generator in code/41_q2.pl.
---

# P2 Form a Valid Arithmetic Equation

Apply the [Prolog development skill](../prolog-dev/SKILL.md). Use [P2.md](../../prompts/P2.md) one block at a time and check the examples in [Assignment.pdf](../../Assignment.pdf).

- Split at each position that leaves both sides nonempty. Build expression trees over contiguous subsequences in input order, using every number exactly once. Each internal node uses one binary operator from `+`, `-`, `*`, and `/`.
- Carry integer values alongside trees. Check a division for a nonzero divisor and zero remainder before computing its quotient. Negative intermediate results are valid. Keep evaluation independent of string rendering.
- Render an SWI-Prolog string with decimal numbers, exactly one `=`, and no spaces. Give multiplication and division higher precedence than addition and subtraction. Parenthesize a left child only at lower precedence, and a right child at equal or lower precedence. Leave number leaves bare.
- `generate_equation/2` must fail finitely when there is no result, including on inputs shorter than two elements. Keep valid candidates available on backtracking so `all_equations/2` can collect them, deduplicate them, and order them with `sort/2`. `count_equations/2` returns the length of that list.

Before answering, check integer division at every node, SWI string type, and equal-precedence right operands. Use the PDF's seven-result example, a no-solution input, and inputs with zero or repeated numbers when reviewing the integrated generator.
