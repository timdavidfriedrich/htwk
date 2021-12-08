import networkx as nx
from networkx.algorithms import isomorphism
from networkx.algorithms.isomorphism.vf2userfunc import GraphMatcher


# INPUT
knoten_G = "1, 2, 3, 4, 5, 6"
kanten_G = "kante 1 2, kante 1 4, kante 1 6, kante 2 5, kante 2 6, kante 3 4, kante 3 5, kante 3 6, kante 4 5"

kanten_G = kanten_G.replace("kante ", "(")
kanten_G = kanten_G.replace(", ", "),")
kanten_G = kanten_G.replace(" ", ",") + ")"

print(kanten_G)

print(list(map(int, knoten_G.split(","))))
print(list(map(int, kanten_G.split("),("))))

G = nx.Graph()

G.add_nodes_from( list(map(int, knoten_G.split(","))) ) 
G.add_edges_from( [ (1,2), (1,3), (1,4), (1,6), (2,5), (2,6), (2,7), (3,4), (3,5), (3,7), (4,6), (4,7), (5,6), (5,7)] )

H = nx.Graph()
H.add_nodes_from( [ 1, 2, 3, 4, 5, 6, 7] )
H.add_edges_from( [ (1,2), (1,4), (1,5), (1,7), (2,3), (2,4), (2,6), (3,4), (3,6), (3,7), (4,5), (5,6), (5,7), (6,7)] )

GH = isomorphism.GraphMatcher(G,H)
GH.is_isomorphic()


# OUTPUT (mit Formatierung)
print("\nlistToFM [", end=" ")
for i in range(len(GH.mapping.keys())):
    print("(", end="")
    print(list(GH.mapping.keys())[i], end=", ")
    print(list(GH.mapping.values())[i], end="), ")
print("]\n")

