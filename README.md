# Projet Suites logiques: Tests d'intelligence

## Groupe

* **AIDARA Sidi Mohamed** 
* **CUEDARI Imelda** 

## Professeur Encadrant

* **PUITG François** 



## Introduction

A l'issue de notre formation en L3_MIAGE, il nous a été demandé de mettre en place une forme d'Intelligence Artificielle capable de deviner la suite logique d'un ensemble de valeurs qui lui est passé en paramètres.

En espérant que notre modeste proposition de solution porte satisfaction à tout possesseur de ce rapport, bonne lecture.

## Perimetre de l'IA

Etant donné notre niveau de connaissance relativement moyen en Programmation Declarative, nous nous sommes permis un minimum de suppositions afin de pouvoir concrétiser nos propositions de solution à ce projet. 



## Réalisation

Notre approche est principalement axées sur les informations dont nous disposons de chaque suite. Chaque suite a tout naturellement un prédicat bien défini, prédicat lequel est considéré comme **pattern**. Nous avons donc une base de données en **patterns**.

L'utilisateur, après avoir renseigné sa suite en entrée, n'a plus qu'à attendre un résultat qu'il connait problablement (pour les premières valeurs de cette même suite). 

Notre IA va, elle, dériver cette suite donnée en entrée pour ensuite la comparer à l'ensemble des patterns-dérivées que nous lui avons fourni en dur et va donc avoir une réponse aiguillée en fonction des réponses à l'interrogation de notre base de données de patterns.

Une fois le bon pattern matché, il nous suffit juste d'appliquer l'agorithme correspondant et de le fournir en sortie.

Il serait intéressant de souligner que nous avons fait le choix d'utiliser le langage Prolog étant donné qu'il est plus à notre portée. Ce choix est aussi dû au fait que ce projet était une occasion idéale pour nous de pouvoir mettre en pratique nos connaissances Prolog.

## Informations importantes

*  **SWISH:** L'outil  (en ligne) utilisé pour coder les prédicatas
* [Code: https://swish.swi-prolog.org/p/%20Un%C3%AB_t%C3%AB_urrej.pl](https://swish.swi-prolog.org/p/%20Un%C3%AB_t%C3%AB_urrej.pl)- Lien donnant accès à notre projet SWISH.
* [Source/Réferences: https://oeis.org](https://oeis.org) - OEIS

## Remerciements

Nous tenons à remercier Monsieur Dennis BOUHINEAU (Professeur Cours Magistral) et Monsieur François PUITG (Encadrant et Professeur en TD) pour n'avoir ménagé aucun effort durant tout le long du semestre afin de répondre à nos questions.

## Annexe: Code Complet
### Calcul de dérivée d'une liste:
derivation_liste([],[]).

derivation_liste([_],[]).

derivation_liste([E,F|L],[N|R]):- N is F - E, derivation_liste([F|L],R).


```
derivation_liste([1,2,7,32],Res).
```

```
Res = [1, 5, 25]
```

### Extraction des n-elements d'une liste: 
extraire(N, _, Xs) :- N =< 0, !, N =:= 0, Xs = [].

extraire(_, [], []).

extraire(N, [X|Xs], [X|Ys]) :- M is N-1, extraire(M, Xs, Ys).

```
extraire(2,[1,2,7,32],Res).
```

```
Res = [1, 2]
```
### Egualité entre deux listes: 
identity_Pattern_Extrait([], []).

identity_Pattern_Extrait([H1|R1], [H2|R2]):- H1 = H2, identity_Pattern_Extrait(R1, R2).

```
identity_Pattern_Extrait([1,2,7,32],[1,2,7,32]). **true**
```

```
identity_Pattern_Extrait([1,2,3,4],[1,2,3]). **false**
```
### Concatenation de deux listes:
concatener([],X,X).

concatener([E|L],X, [E|R]):-concatener(L,X,R).

```
concatener([1,2,3],[7,32],Res).
```

```
Res = [1, 2, 3, 7, 32]
```

#### Position d'un élément
position(E,[E|_],0).

position(X,[E|L],N):-X\==E,position(X,L,N1),N is N1+1.
 
#### Puissance d'un nombre
pow2(X,Y,Z) :- Z is X**Y.

#### Dernier élément d'une liste
lastElement([X],X).
lastElement([_|L],X):- lastElement(L,X).

### Verification Fibonnaci:
isFibonaci([X,Y,Z],J):-Z is X+Y, J is Y+Z.
isFibonaci([X,Y,Z|L],J):- Z is X+Y, isFibonaci([Y,Z|L],J).

## Algorithme du test d'intelligence:

###Cas de la suite S1
**test_intelligence(L,W)**:- derivation_liste(L,LD), extraire(4,LD,LD1), 
    					identity_Pattern_Extrait(LD1,[1,2,1]),
    					lastElement(L,Last), position(Last,L,Pos), 
    					0 is Pos mod 2,
    					W1 is Last+1, 	
    					concatener(L,[W1],W).

**test_intelligence(L,W)**:- derivation_liste(L,LD), extraire(4,LD,LD1), identity_Pattern_Extrait(LD1,[1,2,1]),
    					lastElement(L,Last), position(Last,L,Pos), 1 is Pos mod 2,
    					W1 is Last+2, 
    					concatener(L,[W1],W).


###Cas de la suite S2
**test_intelligence(L,W)**:- derivation_liste(L,LD), extraire(4,LD,LD1), identity_Pattern_Extrait(LD1,[1,2,3]),
    					derivation_liste(LD1,LDS),identity_Pattern_Extrait(LDS,[1,1]),
    					lastElement(L,Last), position(Last,L,Pos), W1 is Last+Pos+1,
    					concatener(L,[W1],W),!.

###Cas de la suite S3
**test_intelligence(L,W)**:- derivation_liste(L,LD), extraire(4,LD,LD1), identity_Pattern_Extrait(LD1,[1,5,25]),
    					lastElement(L,Last), position(Last,L,Pos), pow2(5,Pos,P1),
    					W1 is Last+P1, concatener(L,[W1],W),!.

###Cas de la suite de Fibonacci
**test_intelligence(L,W)**:- isFibonaci(L,G),
    					concatener(L,[G],W),!.



### Série de test d'intelligence:

**Cas de la suite S1**

```
test_intelligence([1,2,4,5],Res).
```

```
Res = [1, 2, 4, 5, 7]
```

**Cas de la suite S2**

```
test_intelligence([1,2,7,32],Res).
```

```
Res = [1, 2, 7, 32, 157]
```


## Remarque:
Bien que nous n'ayons pas pu l'intégrer aux test d'intelligence, nous avons pu mettre en place un prédicat permettant de générer un nombre de la suite de Conway (si l'utilisateur renseigne la position de ce nombre de la suite).

###Suite de Conway

conwaySuivant([],[]).

conwaySuivant([E],[1,E]).

conwaySuivant([E,E|L],[M,E|R]) :- conwaySuivant([E|L],[N,E|R]), M is N+1.

conwaySuivant([E,F|L],[1,E|R]) :- dif(E,F), conwaySuivant([F|L],R). 
 
conway(0,[1]):-write("SUITE DE CONWAY").

conway(N,R):- N>0, M is N-1, conway(M,L), conwaySuivant(L,R).

```
conway(2,Res).
```

```
Res = [2, 1]
```
Effectivement, le deuxième nombre de la suite de Conway est 2,1.
