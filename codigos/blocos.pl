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
    forall(Bloco(B, X),
           (\+ (member(pos(B, _), State),
                busy_slots(B, State, BusySlots),
                member(Slot, BusySlots)))).

can(move(Bloco, mesa(X))) :-
		bloco(Bloco, tamanho),
		mesa_comprimento(W),
    	X_end is X + W - 1,
		X_end < W,
	    findall(S, between(X, X_end, S), RequiredSlots),
		forall(member(Slot, RequiredSlots), is_free(Slot, State)).

estabilidade(Bloco, BlocoAlvo, Offset) :-
		bloco(Bloco, tamanho1),
		bloco(Bloco, tamanho2),
		diferenca is tamanho1 - tamanho2,
		diferenca is <= 1. %1 de diferenca e o limite

can(move(Bloco, on(BlocoAlvo, Offset))) :-
		livre(Bloco),
		livre(BlocoAlvo),
		Bloco \= BlocoAlvo,
		estabilidade(Bloco, BlocoAlvo, Offset).

%Add-list


%Delete-list


%Pergunta para solucionar (substituir X pelo numero da situacao):
%sX_state0(S0), sX_statef(G), plan(S0, G, Plano).