
/* games.pro
digital games identification game.
start with ?- go.
*/
go :- hypothesize(Game),
write('I guess that the game is: '),
write(Game),
nl,
undo.

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

/*hypothesize(penguin)
:- penguin, !.
hypothesize(albatross) :- albatross, !.
hypothesize(unknown).
*/

/* no diagnosis */
/* games identification rules */
call_of_duty :- fps,
verify(action),verify(online).

overwatch :- fps,
verify(moba),verify(online).

league_of_legends :- verify(moba),
verify(online),verify(stratefy). 

the_witcher_3 :- 
verify(roll),verify(fantasy),verify(action),verify(third_person).

dark_souls :-
verify(survival),verify(terror),verify(third_person).

fps :- verify(first_person),verify(shooter)
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