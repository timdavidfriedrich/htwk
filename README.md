# HTWK
Tim Friedrich

import networkx as nx
from networkx.algorithms import isomorphism
from networkx.algorithms.isomorphism.vf2userfunc import GraphMatcher
from networkx.classes.function import nodes


# RAW INPUT
# (Paste the mkSets from Autotool without brackets)

nodes_first = input("\nKnoten von Graph 1 (OHNE KLAMMERN): \n>> ");
edges_first = input("\nKanten von Graph 1 (OHNE KLAMMERN & ZEILENUMBRÜCHE): \n>> ");
nodes_second = input("\nKnoten von Graph 2 (OHNE KLAMMERN): \n>> ");
edges_second = input("\nKanten von Graph 2 (OHNE KLAMMERN & ZEILENUMBRÜCHE): \n>> ");
nodes_raw = [nodes_first, nodes_second]
edges_raw = [edges_first, edges_second]


for j in range(len(nodes_raw)) - 1:

    # Filter out the edge numbers
    # => [1, 2, 1, 4, 3, 5, ...]
    edges_filtered = []
    ignore = [" ", ",", ", "]
    for i in nodes_raw[j]:
        if i in edges_raw[j] and i not in ignore:
            edges_filtered.append(i)

    # Split the numbers in x and y
    # => x: [1, 1, 3, ...], y: [2, 4, 5, ...]
    edges_y = []
    edges_x = []
    for i in range(len(list(map(int, edges_filtered)))):
        if i % 2 == 0:
            edges_x.append(list(map(int, edges_filtered))[i])
        else:
            edges_y.append(list(map(int, edges_filtered))[i])

    # Format x and y to (x,y) => Edges done
    # => [(1,2), (1,4), (3,5), ...]
    edges_total = []
    for i in range(len(edges_x)):
        edges_total.append((edges_x[i], edges_y[i]))


    # Create Graphs from formatted input
    if j == 0:
        G = nx.Graph()
        G.add_nodes_from(list(map(int, knoten_G.split(","))))
        G.add_edges_from(edges_total)
    elif j == 1:
        H = nx.Graph()
        H.add_nodes_from( [ 1, 2, 3, 4, 5, 6] )
        H.add_edges_from( [ (1,2),(1,3),(1,4),(2,3),(2,5),(3,6),(4,5),(4,6),(5,6)] )



# Check for isomorpishm
GH = isomorphism.GraphMatcher(G,H)
GH.is_isomorphic()


# OUTPUT (perfectly formatted)
print("\nlistToFM [", end=" ")
for i in range(len(GH.mapping.keys())):
    print("(", end="")
    print(list(GH.mapping.keys())[i], end=", ")
    print(list(GH.mapping.values())[i], end="), ")
print("]\n")

