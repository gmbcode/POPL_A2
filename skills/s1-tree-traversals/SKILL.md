---
name: s1-tree-traversals
description: Implement or review one unit of S1, the Scheme binary tree traversals in code/41_q3.rkt.
---

# S1 Binary Tree Traversals

Apply the [Scheme development skill](../scheme-dev/SKILL.md). Use [S1.md](../../prompts/S1.md) one block at a time and consult the S1 examples in [Assignment.pdf](../../Assignment.pdf).

- A tree is `'()` or `(value left right)`. Values are numbers or single-character symbols. Guard the empty case before selecting fields. Visit the left subtree before the right subtree.
- Inorder visits left, node, right. Preorder visits node, left, right. Postorder visits left, right, node. If collecting into a reverse-order accumulator, reverse the completed list once for display.
- `print-inorder` prints one list. `print-all-traversals` prints inorder, preorder, and postorder on separate lines in that order. `print-height-and-leaves` prints `(height leaf-count)`. Use `display` followed by `newline` for each line.
- Empty trees have height and leaf count zero. A node has height one plus the maximum subtree height. A leaf has two empty subtrees.

Before answering, use the balanced, right-skewed, symbolic, and empty PDF examples to check the affected output. A single-node tree has height and leaf count one.
