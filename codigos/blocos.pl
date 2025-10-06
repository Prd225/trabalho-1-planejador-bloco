%fatos sobre blocos
bloco(a,1).
bloco(b,1).
bloco(c,2).
bloco(d,3).

%fatos sobre a mesa
mesa(1).
mesa(2).
mesa(3).
mesa(4).
mesa(5).
mesa(6).

%fatos sobre as posicoes dos blocos em S0
s1_state0([
		pos(a,mesa(4)),
		pos(b,mesa(6)),
		pos(c,mesa(0)),
		pos(d,on(a)),
		pos(d,on(b)),
		livre(c),
		livre(d)
]).

%Situacao 1
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
		pos(a, mesa(3)),
		pos(b, mesa(6)),
		pos(d, on(c)),
		pos(d, on(a)),
		livre(b),
		livre(d)
]).

s1_statef4([
		pos(c, mesa(0)),
		pos(d, mesa(3)),
		pos(b, mesa(6)),
		pos(a, on(c)),
		livre(a),
		livre(b),
		livre(d)
]).

%Situacao 2
s2_state0([
		pos(c, mesa(0)),
		pos(d, mesa(4)),
		pos(a, on(c)),
		pos(b, on(c)),
		livre(a),
		livre(b),
		livre(d)
]).

s2_state1([
		pos(c, mesa(0)),
		pos(b, mesa(3)),
		pos(d, mesa(4)),
		pos(a, on(c)),
		livre(a),
		livre(b),
		livre(d)
]).

s2_state2([
		pos(c, mesa(0)),
		pos(b, mesa(3)),
		pos(d, mesa(4)),
		pos(a, on(b)),
		livre(c),
		livre(a),
		livre(d)
]).

s2_state3([
		pos(b, mesa(3)),
		pos(d, mesa(4)),
		pos(a, on(b)),
		pos(c, on(d)),
		livre(a),
		livre(c)
]).

s2_state4([
		pos(b, mesa(3)),
		pos(d, mesa(4)),
		pos(c, on(d)),
		pos(a, on(c)),
		livre(b),
		livre(a)
]).

s2_state5([
		pos(d, mesa(4)),
		pos(c, on(d)),
		pos(a, on(c)),
		pos(b, on(c)),
		livre(a),
		livre(b)
]).

%Situacao 3
s3_state0([
        pos(a,mesa(4)),
        pos(b,mesa(6)),
        pos(c,mesa(0)),
        pos(d,on(a)),
        pos(d,on(b)),
        livre(c),
        livre(d)
]).

s3_state1([
        pos(a,mesa(4)),
        pos(b,mesa(6)),
        pos(c,mesa(0)),
        pos(d,on(c)),
        livre(d),
        livre(a),
		livre(b)
]).

s3_state2([
		pos(a, on(b)),
		pos(b,mesa(6)),
        pos(c,mesa(0)),
        pos(d,on(c)),
		livre(d),
		livre(a)
]).

s3_state3([
		pos(c, mesa(0)),
		pos(d, mesa(3)),
		pos(b, mesa(6)),
		pos(a, on(b)),
		livre(c),
		livre(d),
		livre(a)
]).

s3_state4([
        pos(c, mesa(0)),
        pos(d, mesa(3)),
        pos(b, mesa(6)),
        pos(a, on(c)),
		livre(a),
		livre(b),
		livre(d)
]).

s3_state5([
        pos(c, mesa(0)),
        pos(d, mesa(4)),
        pos(a, on(c)),
        pos(b, on(c)),
        livre(a),
        livre(b),
        livre(d)
]).

s3_state6([
    	pos(c, mesa(0)),
        pos(d, mesa(4)),
        pos(a, on(c)),
        pos(b, on(c)),
        livre(a),
        livre(b),
        livre(d)
]).

s3_state7([
        pos(c, mesa(0)),
        pos(d, mesa(5)),
        pos(a, on(c)),
        pos(b, on(c)),
        livre(a),
        livre(b),
        livre(d)
]).
