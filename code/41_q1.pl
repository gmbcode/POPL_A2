% Generate a complete assignment that satisfies every active clue.
puzzle_solution(Active, Solution) :-
    Solution = [p('Alex', AlexDept, AlexLang, AlexProject),
                p('Ben', BenDept, BenLang, BenProject),
                p('Carla', CarlaDept, CarlaLang, CarlaProject),
                p('Dana', DanaDept, DanaLang, DanaProject)],
    permutation([research, development, design, testing],
                [AlexDept, BenDept, CarlaDept, DanaDept]),
    permutation([python, java, 'c++', javascript],
                [AlexLang, BenLang, CarlaLang, DanaLang]),
    permutation(['AI', web, embedded, data],
                [AlexProject, BenProject, CarlaProject, DanaProject]),
    forall(member(Number, Active), clue(Number, Solution)).

% The AI project is neither in research nor preferred by Dana.
clue(1, Solution) :-
    memberchk(p(Name, Department, _, 'AI'), Solution),
    Department \= research,
    Name \= 'Dana'.

% Alex works outside development and favors a language other than C++.
clue(2, Solution) :-
    memberchk(p('Alex', Department, Language, _), Solution),
    Department \= development,
    Language \= 'c++'.

% The friend in testing favors Python.
clue(3, Solution) :-
    memberchk(p(_, testing, python, _), Solution).

% Ben prefers web and works outside testing.
clue(4, Solution) :-
    memberchk(p('Ben', Department, _, web), Solution),
    Department \= testing.

% The friend who favors Java works in design.
clue(5, Solution) :-
    memberchk(p(_, design, java, _), Solution).

% Carla works outside development and prefers a project other than embedded.
clue(6, Solution) :-
    memberchk(p('Carla', Department, _, Project), Solution),
    Department \= development,
    Project \= embedded.

% Dana works in research or testing and favors a language other than Java.
clue(7, Solution) :-
    memberchk(p('Dana', Department, Language, _), Solution),
    Language \= java,
    memberchk(Department, [research, testing]).

% The friend who prefers data works in research and does not favor JavaScript.
clue(8, Solution) :-
    memberchk(p(_, research, Language, data), Solution),
    Language \= javascript.

% Print one assignment for the eight original clues.
main :-
    once(puzzle_solution([1,2,3,4,5,6,7,8], Solution)),
    forall(member(p(Name, Department, Language, Project), Solution),
           format('~a = [~a, ~a, ~a]~n', [Name, Department, Language, Project])).

% Count complete assignments for the selected set of clues.
count_solutions(Active, Count) :-
    aggregate_all(count, puzzle_solution(Active, _), Count).
