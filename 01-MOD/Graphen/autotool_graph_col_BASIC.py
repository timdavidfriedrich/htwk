import networkx as nx
from networkx.algorithms.coloring.greedy_coloring import greedy_color

# INIT GRAPHEN
G = nx.Graph()

# INPUT G
G.add_nodes_from( [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] ) 
G.add_edges_from( [ (1,9),(1,11),(1,13),(2,6),(2,8),(2,11),(3,6),(3,15),(3,16),(3,17),(4,5),(4,8),(4,16),(4,17),(5,9),(5,14),(5,15),(6,7),(6,9),(6,11),(6,14),(6,15),(7,8),(7,11),(7,12),(7,13),(7,17),(8,9),(8,14),(9,12),(9,16),(10,11),(10,13),(11,15),(12,17),(13,17),(15,16)] )

# COLORING
print(greedy_color(G))

alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P"]

output = "listToFM [ "
for i in range(len(greedy_color(G))):
    output = output + "(" + str(list(greedy_color(G).keys())[i]) + "," + alphabet[list(greedy_color(G).values())[i]] + ")"
    if i is not len(greedy_color(G)) - 1:
        output = output + ", "
output = output + " ]"

print(output)

