% Run from the repository root:
% swipl -q -f tests/p2_tests.pl -g run_p2_tests -t halt

:- ensure_loaded('../code/41_q2.pl').

run_p2_tests :-
    p2_expect(assignment_examples, p2_assignment_examples),
    p2_expect(short_inputs, p2_short_inputs),
    p2_expect(repeated_operands, p2_repeated_operands),
    p2_expect(exact_division, p2_exact_division),
    p2_expect(negative_intermediate, p2_negative_intermediate),
    p2_expect(canonical_parentheses, p2_canonical_parentheses),
    p2_expect(subtraction_parentheses, p2_subtraction_parentheses),
    p2_expect(large_integer, p2_large_integer).

p2_expect(Label, Goal) :-
    (   call(Goal)
    ->  true
    ;   format(user_error, 'P2 check failed: ~w~n', [Label]),
        fail
    ).

p2_assignment_examples :-
    Numbers = [4,2,5,3],
    Equations = ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
                 "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"],
    all_equations(Numbers, Equations),
    once(generate_equation(Numbers, Equation)),
    memberchk(Equation, Equations),
    count_equations(Numbers, 7),
    \+ generate_equation([2,3,4], _),
    all_equations([2,3,4], []),
    count_equations([2,3,4], 0),
    all_equations([2,4,8], ["2*4=8"]).

p2_short_inputs :-
    forall(member(Numbers, [[],[7]]),
           ( \+ generate_equation(Numbers, _),
             all_equations(Numbers, []),
             count_equations(Numbers, 0)
           )),
    all_equations([7,7], ["7=7"]),
    all_equations([7,8], []).

p2_repeated_operands :-
    all_equations([1,1,1], ["1*1=1", "1/1=1", "1=1*1", "1=1/1"]),
    count_equations([1,1,1], 4),
    all_equations([0,0,0], ["0*0=0", "0+0=0", "0-0=0",
                             "0=0*0", "0=0+0", "0=0-0"]).

p2_exact_division :-
    generate_equation([0,3,0], "0/3=0"),
    \+ generate_equation([3,2,2,3], "3/2*2=3"),
    \+ generate_equation([4,2,2,0], "4/(2-2)=0"),
    apply_operation('/', -6, -3, 2),
    \+ apply_operation('/', -5, 2, _).

p2_negative_intermediate :-
    generate_equation([1,3,1,3,4], "(1-3)*(1-3)=4").

p2_canonical_parentheses :-
    all_equations([6,1,2,3], Equations),
    memberchk("6=1+2+3", Equations),
    memberchk("6=1+(2+3)", Equations),
    generate_equation([4,2,3,18], "(4+2)*3=18"),
    generate_equation([4,2,3,10], "4+2*3=10"),
    generate_equation([8,4,2,4], "8/4*2=4"),
    generate_equation([8,4,2,1], "8/(4*2)=1").

p2_subtraction_parentheses :-
    generate_equation([1,2,3,0,4], "1-2-3=0-4"),
    generate_equation([1,2,3,2], "1-(2-3)=2").

p2_large_integer :-
    generate_equation([100000000000000000000,2,50000000000000000000],
                      "100000000000000000000/2=50000000000000000000").
