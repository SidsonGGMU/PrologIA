% Calcul de dérivée d'une liste:
derivation_liste([],[]).
derivation_liste([_],[]).
derivation_liste([E,F|L],[N|R]):- N is F - E, derivation_liste([F|L],R).

% Extraction des n-elements d'une liste: 
extraire(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].
extraire(_, [], []).
extraire(N, [X|Xs], [X|Ys]) :- M is N-1, extraire(M, Xs, Ys).

% Egualité entre deux listes: 
identity_Pattern_Extrait([], []).
identity_Pattern_Extrait([H1|R1], [H2|R2]):- H1 = H2, identity_Pattern_Extrait(R1, R2).


% Concatenation:
concatener([],X,X).
concatener([E|L],X, [E|R]):-concatener(L,X,R).
 
% Position d'un élément
position(E,[E|_],0).
position(X,[E|L],N):-X\==E,position(X,L,N1),N is N1+1.
 
% Puissance d'un nombre
pow2(X,Y,Z) :- Z is X**Y.

% Dernier élément d'une liste
lastElement([X],X).
lastElement([_|L],X):- lastElement(L,X).

% Verification Fibonnaci:
isFibonaci([X,Y,Z],J):-Z is X+Y, J is Y+Z.
isFibonaci([X,Y,Z|L],J):- Z is X+Y, isFibonaci([Y,Z|L],J).

% Algorithme du test d'intelligence:

% Cas de la suite S1
test_intelligence(L,W):- derivation_liste(L,LD), extraire(4,LD,LD1), 
    					identity_Pattern_Extrait(LD1,[1,2,1]),
    					lastElement(L,Last), position(Last,L,Pos), 
    					0 is Pos mod 2,
    					W1 is Last+1, 	
    					concatener(L,[W1],W).

test_intelligence(L,W):- derivation_liste(L,LD), extraire(4,LD,LD1), identity_Pattern_Extrait(LD1,[1,2,1]),
    					lastElement(L,Last), position(Last,L,Pos), 1 is Pos mod 2,
    					W1 is Last+2, 
    					concatener(L,[W1],W).


% Cas de la suite S2
test_intelligence(L,W):- derivation_liste(L,LD), extraire(4,LD,LD1), identity_Pattern_Extrait(LD1,[1,2,3]),
    					derivation_liste(LD1,LDS),identity_Pattern_Extrait(LDS,[1,1]),
    					lastElement(L,Last), position(Last,L,Pos), W1 is Last+Pos+1,
    					concatener(L,[W1],W),!.

% Cas de la suite S3
test_intelligence(L,W):- derivation_liste(L,LD), extraire(4,LD,LD1), identity_Pattern_Extrait(LD1,[1,5,25]),
    					lastElement(L,Last), position(Last,L,Pos), pow2(5,Pos,P1),
    					W1 is Last+P1, concatener(L,[W1],W),!.

% Cas de la suite de Fibonacci
test_intelligence(L,W):- isFibonaci(L,G),
    					concatener(L,[G],W),!.

% Suite de Conway
conwaySuivant([],[]).
conwaySuivant([E],[1,E]).
conwaySuivant([E,E|L],[M,E|R]) :- conwaySuivant([E|L],[N,E|R]), M is N+1.
conwaySuivant([E,F|L],[1,E|R]) :- dif(E,F), conwaySuivant([F|L],R).  
conway(0,[1]):-write("SUITE DE CONWAY").
conway(N,R):- N>0, M is N-1, conway(M,L), conwaySuivant(L,R).

    					