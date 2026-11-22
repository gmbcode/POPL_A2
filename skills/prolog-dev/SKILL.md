---
name: prolog-dev
description: Develop or review SWI-Prolog 9.x predicates for P1 and P2 of CS F301 Assignment 2.
---

# Prolog development

Use SWI-Prolog 9.x. Read the relevant section of [Assignment.pdf](../../Assignment.pdf) and follow the guidance for [P1](../p1-department-puzzle/SKILL.md) or [P2](../p2-arithmetic-equations/SKILL.md).

- Work on the single predicate, test file, or review requested in the current prompt. Treat the blocks in the corresponding prompt file as separate requests.
- Use lowercase snake_case for predicate names, descriptive uppercase variables, and short comments that explain when each predicate succeeds or how its output relates to its inputs.
- Keep source files loadable without side effects. The permitted libraries are `lists`, `apply`, `yall`, and `aggregate`. Avoid `assert`, `retract`, global state such as `b_setval` and `nb_setval`, initialization directives, and calls to `halt/0` in source.
- Run P1's entry point with `swipl -q -f code/41_q1.pl -g main -t halt`. Run a predicate check with `swipl -q -f code/41_q1.pl -g "<goal>" -t halt`, using `code/41_q2.pl` for P2. Run each problem's test file in a separate SWI-Prolog process.

## Known AI failure modes

- **Implicit library dependencies.** Generated predicates may work only because SWI-Prolog autoloads a library. Import each required predicate explicitly from an allowed library.
- **Pruning valid solutions.** A cut or `once/1` in a generator can silently discard answers. Check all answers for an input with multiple solutions. Use `once/1` where the caller needs a single answer, such as P1's `main/0`.
- **Testing variables before they are bound.** Arithmetic on an unbound operand raises an error, and negation as failure on a partially instantiated candidate can reject valid solutions. Ground puzzle candidates before testing clues and evaluate arithmetic only after both operands have values.
- **Accepting invalid division.** Integer division alone can truncate a non-exact quotient. At every division node, check for a nonzero divisor and a zero remainder before computing the quotient.
- **Losing expression structure.** Omitting parentheses around a right child of equal precedence can merge distinct trees. Check that `1+2+3` and `1+(2+3)` render differently.

## Self-review

- Check predicate names, arities, argument order, and whether each supported goal should succeed, fail, or enumerate further answers.
- Verify required output exactly, including the absence of load-time output and any unintended quoting, spaces, or extra lines.
- Report which queries were run and which behaviors remain unverified.
