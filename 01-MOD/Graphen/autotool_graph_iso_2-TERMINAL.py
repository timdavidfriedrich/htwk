import networkx as nx
from networkx.algorithms import isomorphism


# Create a given number of graphs
number_of_graphs = 2 # EXPERIMENTAL: int(input("\nAnzahl der Graphen: \n>> "))
graphs = [ nx.Graph() for n in range(number_of_graphs) ]


for j in range(len(graphs)):

    # Raw input (without brackets and linewraps)
    nodes_raw = input("\nKnoten von Graph {} (OHNE KLAMMERN): \n>> ".format(j + 1))
    edges_raw = input("\nKanten von Graph {} (OHNE KLAMMERN & ZEILENUMBRÜCHE): \n>> ".format(j + 1))

    # Filter out the edge numbers
    # => [1, 2, 1, 4, 3, 5, ...]
    edges_filtered = []
    ignore = [" ", ",", ", "]
    for i in edges_raw:
        if i in nodes_raw and i not in ignore:
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
    edges = []
    for i in range(len(edges_x)):
        edges.append((edges_x[i], edges_y[i]))

    # Add nodes and edges from formatted input to graphs
    graphs[j].add_nodes_from(list(map(int, nodes_raw.split(","))))
    graphs[j].add_edges_from(edges)


# Check for isomorphism (where the magic happens)
GH = isomorphism.GraphMatcher(graphs[0],graphs[1])
GH.is_isomorphic()


# OUTPUT (perfectly formatted)
print("\nlistToFM [", end=" ")
for i in range(len(GH.mapping.keys())):
    print("(", end="")
    print(list(GH.mapping.keys())[i], end=", ")
    print(list(GH.mapping.values())[i], end=")")
    if i is not len(GH.mapping.keys()) - 1:
        print(", ", end="")
print(" ]\n")


