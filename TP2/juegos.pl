
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
hypothesize(agregar).

/*hypothesize(penguin)
:- penguin, !.
hypothesize(albatross) :- albatross, !.
*/


/* no diagnosis */
/* games identification rules */
call_of_duty :- fps,
verify(action),online.

overwatch :- fps,
moba.

league_of_legends :- moba,
verify(stratefy). 

mass_effect :- verify(role),verify(science_fiction),verify(third_person),verify(action),verify(shooter).

the_witcher_3 :- 
verify(role),verify(fantasy),verify(action),verify(third_person).

dark_souls :-
verify(survival),verify(terror),verify(third_person).

minecraft :- verify(survival).

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
read(Att),
