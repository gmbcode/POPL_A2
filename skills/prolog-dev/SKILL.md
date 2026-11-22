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

## Self-review

- Check predicate names, arities, argument order, and whether each supported goal should succeed, fail, or enumerate further answers.
- Watch for accidental pruning with cut or `once/1`, unbound arithmetic operands, and negation-as-failure on variables that should be ground.
- Verify required output exactly, including the absence of load-time output and any unintended quoting, spaces, or extra lines.
- Report which queries were run and which behaviors remain unverified.
