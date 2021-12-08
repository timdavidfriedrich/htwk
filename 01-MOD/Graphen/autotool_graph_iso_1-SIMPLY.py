import networkx as nx
from networkx.algorithms import isomorphism


# INIT GRAPHEN
G = nx.Graph()
H = nx.Graph()

# INPUT G
G.add_nodes_from( [ 1, 2, 3, 4, 5, 6] ) 
G.add_edges_from( [ (1,2), (1,3), (1,4), (1,6), (2,5), (2,6), (2,7), (3,4), (3,5), (3,7), (4,6), (4,7), (5,6), (5,7)] )

# INPUT H
H.add_nodes_from( [ 1, 2, 3, 4, 5, 6, 7] )
H.add_edges_from( [ (1,2), (1,4), (1,5), (1,7), (2,3), (2,4), (2,6), (3,4), (3,6), (3,7), (4,5), (5,6), (5,7), (6,7)] )

# VERGLEICH VON G UND H
GH = isomorphism.GraphMatcher(G,H)
GH.is_isomorphic()


# OUTPUT (mit Formatierung)
print("\nlistToFM [", end=" ")
for i in range(len(GH.mapping.keys())):
    print("(", end="")
    print(list(GH.mapping.keys())[i], end=", ")
    print(list(GH.mapping.values())[i], end="), ")
print("]\n")


