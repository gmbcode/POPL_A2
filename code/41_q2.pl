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
