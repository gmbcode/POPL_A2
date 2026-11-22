% Evaluate a binary operator on integer operands.
apply_operation('+', Left, Right, Value) :-
    Value is Left + Right.
apply_operation('-', Left, Right, Value) :-
    Value is Left - Right.
apply_operation('*', Left, Right, Value) :-
    Value is Left * Right.
apply_operation('/', Left, Right, Value) :-
    Right =\= 0,
    0 is Left mod Right,
    Value is Left // Right.

% Enumerate trees over a nonempty list of numbers and their integer values.
arithmetic_expression([Number], num(Number), Number).
arithmetic_expression(Numbers, bin(Op, LeftTree, RightTree), Value) :-
    append(LeftNumbers, RightNumbers, Numbers),
    LeftNumbers = [_|_],
    RightNumbers = [_|_],
    arithmetic_expression(LeftNumbers, LeftTree, LeftValue),
    arithmetic_expression(RightNumbers, RightTree, RightValue),
    apply_operation(Op, LeftValue, RightValue, Value).

operator_precedence('+', 1).
operator_precedence('-', 1).
operator_precedence('*', 2).
operator_precedence('/', 2).

% Render a tree, preserving how its operators associate with its parent.
expression_text(num(Number), _, _, Text) :-
    number_string(Number, Text).
expression_text(bin(Op, Left, Right), ParentPrecedence, Side, Text) :-
    operator_precedence(Op, Precedence),
    expression_text(Left, Precedence, left, LeftText),
    expression_text(Right, Precedence, right, RightText),
    format(string(Body), '~s~a~s', [LeftText, Op, RightText]),
    (   ( Precedence < ParentPrecedence
        ; Side == right, Precedence =:= ParentPrecedence
        )
    ->  format(string(Text), '(~s)', [Body])
    ;   Text = Body
    ).

% Render a matching pair of integer-valued trees at each equation split.
generate_equation(Numbers, Equation) :-
    append(LeftNumbers, RightNumbers, Numbers),
    LeftNumbers = [_|_],
    RightNumbers = [_|_],
    arithmetic_expression(LeftNumbers, LeftTree, Value),
    arithmetic_expression(RightNumbers, RightTree, Value),
    expression_text(LeftTree, 0, root, LeftText),
    expression_text(RightTree, 0, root, RightText),
    format(string(Equation), '~s=~s', [LeftText, RightText]).

% Collect every equation in standard term order, removing duplicates.
all_equations(Numbers, Equations) :-
    findall(Equation, generate_equation(Numbers, Equation), Generated),
    sort(Generated, Equations).

% Count the distinct canonical equations for the given input.
count_equations(Numbers, Count) :-
    all_equations(Numbers, Equations),
    length(Equations, Count).
