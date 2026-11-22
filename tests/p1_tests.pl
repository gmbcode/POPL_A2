% Run from the repository root:
% swipl -q -f tests/p1_tests.pl -g run_p1_tests -t halt

:- ensure_loaded('../code/41_q1.pl').

run_p1_tests :-
    p1_expect(numbered_clues, p1_check_numbered_clues),
    p1_expect(no_active_clues, count_solutions([], 13824)),
    p1_expect(active_subset, count_solutions([1,3], 1944)),
    p1_expect(repeated_active_clue, count_solutions([3,1,3], 1944)),
    p1_expect(original_count, count_solutions([1,2,3,4,5,6,7,8], 3)),
    p1_expect(repaired_solution, p1_check_repair),
    p1_expect(main_output, p1_check_main_output).

% Identify a failed check and propagate failure to the shell.
p1_expect(Label, Goal) :-
    (   call(Goal)
    ->  true
    ;   format(user_error, 'P1 check failed: ~w~n', [Label]),
        fail
    ).

% Check every numbered clue against ground candidates with known outcomes.
p1_check_numbered_clues :-
    forall(p1_clue_case(Solution, Expected),
           findall(Number, (between(1, 9, Number), clue(Number, Solution)), Expected)).

p1_clue_case(
    [p('Alex', research, python, 'AI'),
     p('Ben', development, java, web),
     p('Carla', design, 'c++', embedded),
     p('Dana', testing, javascript, data)],
    [2,4,7]).
p1_clue_case(
    [p('Alex', development, 'c++', embedded),
     p('Ben', testing, python, 'AI'),
     p('Carla', research, javascript, data),
     p('Dana', design, java, web)],
    [1,3,5,6,9]).
p1_clue_case(
    [p('Alex', design, java, 'AI'),
     p('Ben', development, javascript, web),
     p('Carla', research, 'c++', data),
     p('Dana', testing, python, embedded)],
    [1,2,3,4,5,6,7,8]).

% The ninth clue selects one of the independently enumerated assignments.
p1_check_repair :-
    Active = [1,2,3,4,5,6,7,8,9],
    count_solutions(Active, 1),
    findall(Solution, puzzle_solution(Active, Solution),
            [[p('Alex', design, java, embedded),
              p('Ben', development, javascript, web),
              p('Carla', testing, python, 'AI'),
              p('Dana', research, 'c++', data)]]).

% Accept any original solution with exactly four lines and a final newline.
p1_check_main_output :-
    with_output_to(string(Output), findall(done, main, [done])),
    split_string(Output, "\n", "", [Alex, Ben, Carla, Dana, ""]),
    Ben = "Ben = [development, javascript, web]",
    p1_original_lines(Alex, Carla, Dana).

p1_original_lines("Alex = [design, java, AI]",
                  "Carla = [research, c++, data]",
                  "Dana = [testing, python, embedded]").
p1_original_lines("Alex = [design, java, embedded]",
                  "Carla = [testing, python, AI]",
                  "Dana = [research, c++, data]").
p1_original_lines("Alex = [testing, python, embedded]",
                  "Carla = [design, java, AI]",
                  "Dana = [research, c++, data]").
