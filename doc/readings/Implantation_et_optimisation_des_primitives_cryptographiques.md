Implantation et optimisation des primitives cryptographiques, chapitre 3 : Bitslice, Thomas Pornin, 2001
===

Dans ce chapitre, Pornin présente comment implémenter des algorithmes bitslice.  

Premièrement, les données doivent etre converties de leur représentation standart à une représentation bitslice (étape que Pornin appelle *orthogonalisation des données*). Ceci peut être fait en `4log(n)` opérations (pour `n*n` bits), grace à un algorithme de transposition de matrices de Knuth (The Art of Computer Programming, vol. 3).

Deuxièmement, les tables (S-box) doivent etre converties en circuits logiques. Pour ce faire, Pornin utilise des *Binary Decision Diagrams* (BDD), qui permettent de représenter les circuits génériques correspondant aux S-box, que l'on peut ensuite otpimiser. (technique proche de ce que Kwan et Biham présentent).  
Cependant, bien que cette technique permette de générer des circuits courts, elle ne génère pas les circuits optimaux à coup sûr.
*Note : je n'ai toujours pas bien compris comment ca marche. A revoir.*

Pornin présente ensuite *bcs*, un outil permettant d'écrire du code bitslicé qu'il a développé, y compris les diverses optimisations utilisées par celui-ci.  
Les codes C générés par *bsc* sont très long (quelques Mo pour un DES), et utilisent beaucoup de variables, ce qui est potentiellement mal optimisé par le compilateur. Introduire de nouvelles constructions au sein du language d'entrée de *bsc* pourrait corriger certains de ces problèmes.

Pour finir, Pornin décrit un nouvel algorithme, __FBC__, qui se veut très rapide, afin de chiffrer (et déchiffrer) des disques durs en temps réel.
