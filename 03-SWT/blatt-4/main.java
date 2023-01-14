
/*
 * KDTree is a class supporting KD-tree insertion, deletion, equality search, range search, 
 * and nearest neighbor(s) using double-precision floating-point keys.
 * Splitting dimension is chosen naively, by depth modulo K. Semantics are as follows:
 *    - Two different keys containing identical numbers should retrieve the same value from a 
 *      given KD-tree. Therefore keys are cloned when a node is inserted.
 *    - As with Hashtables, values inserted into a KD-tree are not cloned. Modifying a value 
 *      between insertion and retrieval will therefore modify the value stored in the tree.
 * 
 * @version: JDK 1.2
 * @author: Simon Levy, Bjoern Heckel
 */
public class KdTree {
    /*
     * Creates a KD-tree.
     */
    public KdTree() {}
    /*
     * Insert a node in a KD-tree. Uses algorithm translated from 352.ins.c of
     *  @Book{GonnetBaezaYates1991,                                   
     *      author =    {G.H. Gonnet and R. Baeza-Yates},
     *      title =     {Handbook of Algorithms and Data Structures},
     *      publisher = {Addison-Wesley},
     *      year =      {1991}
     *  }
     * @param p: Node position for the added Node 
     */
    public void insert (Point2D p) {}
    /*
     * Find KD-tree node whose key is nearest neighbor to key. Implements the Nearest Neighbor algorithm (Table 6.4) of
     * @techreport{AndrewMooreNearestNeighbor,
     *  author  = {Andrew Moore},
     *  title   = {An introductory tutorial on kd-trees},
     *  institution = {Robotics Institute, Carnegie Mellon University},
     *  year    = {1991},
     *  number  = {Technical Report No. 209, Computer Laboratory, 
     *              University of Cambridge},
     *  address = {Pittsburgh, PA}
     *  }
     *
     * @param p: Source point
     */
    public Point2D nearest (Point2D p) {}
}