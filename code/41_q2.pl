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
