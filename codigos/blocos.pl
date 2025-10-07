%fatos sobre blocos
bloco(a,1).
bloco(b,1).
bloco(c,2).
bloco(d,3).

%fatos sobre a mesa
mesa(0).
mesa(1).
mesa(2).
mesa(3).
mesa(4).
mesa(5).
mesa(5).
mesa_comprimento(7).

%Situacao 1
s1_state0([
		pos(a,mesa(3)),
		pos(b,mesa(5)),
		pos(c,mesa(0)),
		pos(d,on(a)),
		pos(d,on(b)),
		livre(c),
		livre(d)
]).

s1_statef1([
		pos(d, mesa(4)),
		pos(a, on(d)),
		pos(b, on(d)),
		pos(c, on(a)),
		pos(c, on(b)),
		livre(c)
]).

s1_statef2([
		pos(d, mesa(4)),
		pos(c, on(d)),
		pos(a, on(c)),
		pos(b, on(c)),
		livre(a),
		livre(b)
]).

s1_statef3([
		pos(c, mesa(0)),
		pos(a, mesa(2)),
		pos(b, mesa(5)),
		pos(d, on(c)),
		pos(d, on(a)),
		livre(b),
		livre(d)
]).

s1_statef4([
		pos(c, mesa(0)),
		pos(d, mesa(2)),
		pos(b, mesa(5)),
		pos(a, on(c)),
		livre(a),
		livre(b),
		livre(d)
]).

%Situacao 2
s2_state0([
		pos(c, mesa(0)),
		pos(d, mesa(3)),
		pos(a, on(c)),
		pos(b, on(c)),
		livre(a),
		livre(b),
		livre(d)
]).

s2_statef([
		pos(d, mesa(3)),
		pos(c, on(d)),
		pos(a, on(c)),
		pos(b, on(c)),
		livre(a),
		livre(b)
]).

%Situacao 3
s3_state0([
		pos(a,mesa(3)),
		pos(b,mesa(5)),
		pos(c,mesa(0)),
		pos(d,on(a)),
		pos(d,on(b)),
		livre(c),
		livre(d)
]).

s3_statef([
		pos(c, mesa(0)),
		pos(d, mesa(3)),
		pos(a, on(c)),
		pos(b, on(c)),
		livre(a),
		livre(b),
		livre(d)
]).

%Pre-condicoes
absolute_pos(Bloco, State, X) :- 
    member(pos(Bloco, mesa(X)), State).

absolute_pos(Bloco, State, X) :-
    member(pos(Bloco, on(BlocoAlvo, Offset)), State),
    absolute_pos(BlocoAlvo, State, X_Alvo),
    X is X_Alvo + Offset.

busy_slots(Bloco, State, Slots) :-
    absolute_pos(Bloco, State, X),
    bloco(Bloco, W),
    X_end is X + W - 1,
    findall(S, between(X, X_end, S), Slots).

is_free(Slot, State) :-
    forall(bloco(B, _),
           (\+ (member(pos(B, _), State),
                busy_slots(B, State, BusySlots),
                member(Slot, BusySlots)))).

estabilidade(Bloco, _, _) :-
		bloco(Bloco, W1),
		bloco(Bloco, W2),
		Diferenca is W1 - W2,
		Diferenca < 2. %1 de diferenca e o limite

can(move(Bloco, mesa(X)), [
		bloco(Bloco, tamanho),
		mesa_comprimento(W),
    	X_end is X + W - 1,
		X_end < W,
	    findall(S, between(X, X_end, S), RequiredSlots),
		forall(member(Slot, RequiredSlots), is_free(Slot, _))
]).

can(move(Bloco, on(BlocoAlvo, Offset)), [
		livre(Bloco),
		livre(BlocoAlvo),
		Bloco \= BlocoAlvo,
		estabilidade(Bloco, BlocoAlvo, Offset)
]).

%Add-list
append([], L, L).
append([H|T], L, [H|R]) :- append(T, L, R).

apply(State, move(Bloco, X), NewState) :-
		member(pos(Bloco, PosAntiga), State),
		
		build_delete_list(move(Bloco, X), PosAntiga, DelList),
		delete_all(State, DelList, StateAfterDeletes),

		build_add_list(move(Bloco, X), PosAntiga, AddList),
		append(AddList, StateAfterDeletes, NewState).

%Delete-list

build_delete_list(move(Bloco, on(TargetBloco, _)), PosAntiga, [pos(Bloco, PosAntiga), livre(TargetBloco)]).
build_delete_list(move(Bloco, table(_)), PosAntiga, [pos(Bloco, PosAntiga)]).

build_add_list(move(Bloco, X), on(AlvoAntigo), [pos(Bloco, X), livre(Bloco), livre(AlvoAntigo)]).
build_add_list(move(Bloco, X), table(_), [pos(Bloco, X), livre(Bloco)]).

delete_all([], _, []).
delete_all([H|T], L2, R) :- member(H, L2), !, delete_all(T, L2, R).
delete_all([H|T], L2, [H|R]) :- delete_all(T, L2, R).

%O Plano
satizfaz(State, Metas) :-
    	subset(Metas, State).

select_goal(State, Metas, Meta) :-
		member(Meta, Metas),
		\+ member(Meta, State).

adds(move(Bloco, Alvo), [
	pos(Bloco, Alvo),
	livre(Bloco)
]).

achieves(Action, Meta) :-
		adds(Action, AddList),
		member(Meta, AddList).

possivel(State, Action) :-
		can(Action, Precondicoes),
		forall(member(P, Precondicoes), (member(P, State), possivel(State, P))).

plan(State, Metas, []) :-
		satizfaz(State, Metas).
plan(State, Metas, Plano) :-
		append(PrePlan, [Action], Plano),
		select_goal(State, Metas, Meta),
		achieves(Action, Meta),
		can(Action, Precondicoes),
		plan(State, Precondicoes, PrePlan),
		apply(State, PrePlan, MidState),
		possivel(Action, MidState),
		apply(MidState, [Action], FState),
		satizfaz(FState, Metas).

%Pergunta para solucionar (substituir X pelo numero da situacao):
%sX_state0(S0), sX_statef(G), plan(S0, G, Plano).