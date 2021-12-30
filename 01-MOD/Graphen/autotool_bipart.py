import tkinter as tk
import networkx as nx
from networkx.algorithms import bipartite
from networkx.classes import graph


# INIT GRAPHEN
G = nx.Graph()

# INPUT G
G.add_nodes_from( [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10] ) 
G.add_edges_from( [ (1, 3), (1,5), (1,10), (2, 3), (2,5), (2,6), (2,10), (3,7), (3,8), (4,5), (4,6), (4,10), (5,7), (5,8), (6,7), (6,8), (7,9), (7,10), (8,9)] )

# VERGLEICH VON G UND H
bipartite.is_bipartite(G)


# OUTPUT (mit Formatierung)
print("\nmkSet [ " + str(bipartite.sets(G)[0]).replace("{", "").replace("}", "") + " ] " )

import tkinter as tk
import networkx as nx
from networkx.algorithms import isomorphism



# Run if submit button clicked
############################################################## \
def calculate():
    edges_raw = []

    for j in range(len(graphs)):

        # Initialize @edges_raw and @nodes_raw from text input
        edges_raw.append(tk_edges_raw[j].get().replace("\n","").replace("10","0"))
        nodes_raw = tk_nodes_raw.get().replace("10", "0") #"1, 2, 3, 4, 5, 6"

        # Filter out the edge numbers
        # => [1, 2, 1, 4, 3, 5, ...]
        edges_filtered = []
        ignore = [" ", ",", ", "]
        for i in edges_raw[j]:
            if i in nodes_raw and i not in ignore:
                edges_filtered.append(i)

        # Split the numbers in x and y
        # => x: [1, 1, 3, ...], y: [2, 4, 5, ...]
        edges_x = []
        edges_y = []
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
        nodes = list(map(int, nodes_raw.split(",")))
        graphs[j].add_nodes_from(nodes)
        graphs[j].add_edges_from(edges)

        print(graphs[j].nodes)
        print(graphs[j].edges)


    # Check for isomorphism (where the magic happens)
    G = graphs[0]
    bipartite.is_bipartite(G)

    # OUTPUT (perfectly formatted)
    output = "\nmkSet [ " + str(bipartite.sets(G)[0]).replace("{", "").replace("}", "") + " ] "


    # Add TextField and insert @output
    output_text = tk.Text(root)
    output_text.insert(1.0, output)
    output_text.pack()
############################################################## /



# Run on start and if reset button clicked
################################################################ \
def main():

    # Create Window
    global root
    root = tk.Tk()
    root.title('Autotool: "Bipartit" lösen')
    root.geometry("500x400")

    # Create a number of graphs given by @number_of_graphs
    number_of_graphs = 1
    global graphs
    graphs = [ nx.Graph() for n in range(number_of_graphs) ]

    # Add hint at the top
    tk.Label(root, text="\n( Einträge stets OHNE Klammern einfügen )").pack()

    # Add a node input area with string @tk_nodes_raw which gets the input
    global tk_nodes_raw
    tk_nodes_raw = tk.StringVar()
    tk.Label(root, text="\nKnoten der Graphen:").pack()
    tk.Entry(root, textvariable=tk_nodes_raw).pack()

    # Add edge input areas (Entry) for the given number of graphes
    # and create a list of strings @tk_edges_raw which get the input
    global tk_edges_raw
    tk_edges_raw = [tk.StringVar() for n in range(len(graphs)) ]
    for j in range(len(graphs)):
        tk.Label(root, text="\nKanten von Graph {}:".format(j + 1)).pack()
        tk.Entry(root, textvariable=tk_edges_raw[j]).pack()
        
    # Add submit button at the bottom
    tk.Label(root, text="").pack()
    tk.Button(root, text="Berechnen", command=calculate).pack()
    tk.Label(root, text="").pack()
    tk.Button(root, text="Reset", command=refresh).pack()
    tk.Label(root, text="").pack()

    tk.mainloop()
    print("\nPROGRAM END OR RESET\n")
################################################################ /


# Run @main()
# @refresh() is used to restart
if __name__ == '__main__':
    def refresh():
        root.destroy()
        main()
    main()


# Grüße, Tim.