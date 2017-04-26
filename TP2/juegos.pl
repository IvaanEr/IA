
/* juegos.pl
digital games identification game.
start with ?- go.
*/

go :- hypothesize(Game),
write('I guess that the game is: '),
write(Game),
nl.


/* hypotheses to be tested */
hypothesize(call_of_duty)
:- call_of_duty, !.
hypothesize(overwatch)
:- overwatch, !.
hypothesize(league_of_legends)
:- league_of_legends, !.
hypothesize(the_witcher_3)
:- the_witcher_3, !.
hypothesize(dark_souls)
:- dark_souls, !.
hypothesize(minecraft)
:- minecraft, !.
hypothesize(agregar) :- agregar,!.

/*hypothesize(penguin)
:- penguin, !.
hypothesize(albatross) :- albatross, !.
*/

append([fps(first_person,shooter),online(multiplayer),moba(battle_arena,has_minions,online),action,strategy,role,science_fiction,third_person,open_world,
terror,survival,fantasy ],[puzzle],Attributes).

attr([fps(first_person,shooter),online(multiplayer),moba(battle_arena,has_minions,online),action,strategy,role,science_fiction,third_person,open_world,
terror,survival,fantasy,puzzle]).
/* no diagnosis */
/* games identification rules */

call_of_duty :- fps,
verify(action),online.

overwatch :- fps,online.

league_of_legends :- moba,
verify(strategy). 

mass_effect :- verify(role),verify(science_fiction),verify(third_person),verify(open_world),verify(action),verify(shooter).

the_witcher_3 :- 
verify(role),verify(fantasy),verify(action),verify(third_person),verify(open_world).

dark_souls :-
verify(survival),verify(fantasy),verify(terror),verify(third_person).

minecraft :- verify(survival),verify(open_world).

devil_may_cry :- 
third_person, verify(action), verify(fantasy).

half_life :-
fps, verify(action), verify(science_fiction).

dead_space :-
verify(third_person),verify(shooter), verify(terror), verify(science_fiction), verify(survival).

gta :-
verify(third_person),verify(shooter), verify(open_world),verify(action).

portal :-
verify(first_person),verify(puzzle),verify(science_fiction).
assert(Game :- verify(Attr)),assert(Game :- verify(Attr1))

fps :- verify(first_person),verify(shooter).
online :- verify(online),verify(multiplayer).
moba :- online,verify(battle_arena),verify(has_minions).

/* how to ask questions */

ask(Question) :-
write('Does the game have the following attribute: '),
write(Question),
write('? '),
read(Response),
nl,
((Response == yes ; Response == y)->assert(yes(Question)); assert(no(Question)), fail).

:- dynamic yes/1,no/1.
/* How to verify something */
verify(S):-
(yes(S)-> true ; (no(S) -> fail ; ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.

agregar :-
write('Do you want to add the game you are looking for?'),
read(Response),nl,
((Response == yes ; Response == y)-> agregar_ok ; undo).

agregar_ok :-
write('The name of the game is: '),nl,
read(Game),
write('What attribute the game has?'),nl,
write('[fps(first_person,shooter),online(multiplayer),moba(battle_arena,has_minions,online),action,strategy,'),
write('role,science_fiction,third_person,open_world,terror,survival,fantasy,puzzle]'),nl.

write_list([]).
write_list([H|T]) :-
	write(H),nl,
	write_list(T).

read_list(List) :-
write('Attribute: '),
read(Att),
(Att == finish ; Att == f) -> List ; append(List,[Att],NewList),read_list(NewList).
