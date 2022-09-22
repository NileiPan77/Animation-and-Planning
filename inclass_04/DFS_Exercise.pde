//CSCI 5611 - Graph Search & Planning
//Breadth-First Search (BFS) [Exercise]
// Stephen J. Guy <sjguy@umn.edu>

/*
 TODO: 
    1. Try to understand how this Breadth-first Search (BFS) implementation works.
       As a start, compare to the pseudocode at: https://en.wikipedia.org/wiki/Breadth-first_search
       How do I represent nodes? How do I represent edges?
       What is the purpose of the visited list? What about the parent list?
       What is getting added to the fringe? In what order?
       How do I find the path once I've found the goal?
    2. Convert this Breadth-first Search to a Depth-First Search.
       Which version BFS or DFS has a smaller maximum fring size?
    3. Currently, the code sets up a graph which follows this tree-like structure: https://snipboard.io/6BhxRd.jpg
       Change it to plan a path from node 0 to node 7 over this graph instead: https://snipboard.io/VIx6Er.jpg
       How do we know the graph is no longer a tree?
       Does Breadth-first Search still find the optimal path?
       
 CHALLENGE:
    1. Make a new graph where there is a cycle. DFS should fail. Does it? Why?
    2. Add a maximum depth limit to DFS. Now can it handle cycles?
    3. Call the new depth-limited DFS in a loop, growing the depth limit with each
       iteration. Is this new iterative deepening DFS optimal? Can it handle loops
       in the graph? How does the memory usage/fringe size compare to BFS?
*/


/*
    1. Integer as nodes, arrayList array represent edges between nodes. Nodes need to be visited are added to fringe, in the order they are added.
       Manage a parentList and work backwards from goal to start.
    2. DFS
    3. Nodes have more than 1 parent.
       Yes
       
    Challenge:
    1. It didn't fail because we handle a visited node list that prevent it enter loop.
    2. 
*/
import java.util.*;
//Initialize our graph 
int numNodes = 8;

//Represents our graph structure as 3 lists
ArrayList<Integer>[] neighbors = new ArrayList[numNodes];  //A list of neighbors can can be reached from a given node
Boolean[] visited = new Boolean[numNodes]; //A list which store if a given node has been visited
int[] parent = new int[numNodes]; //A list which stores the best previous node on the optimal path to reach this node
  
// Initialize the lists which represent our graph 
for (int i = 0; i < numNodes; i++) { 
    neighbors[i] = new ArrayList<Integer>(); 
    visited[i] = false;
    parent[i] = -1; //No parent yet
}

//Set which nodes are connected to which neighbors
neighbors[0].add(1); neighbors[0].add(3); //0 -> 1 & 3
neighbors[1].add(2);                      //1 -> 2  
neighbors[2].add(0);                      //2 -> 1
neighbors[3].add(6); //3 -> 4 & 6 
neighbors[4].add(3);                      //4 -> 3 
neighbors[5].add(7);                      //5 -> 7
neighbors[6].add(5); neighbors[6].add(4); //6 -> 5 & 4 (cycle)

println("List of Neighbors:");
println(neighbors);

//Set start and goal
int start = 0;
int goal = 7;

ArrayList<Integer> fringe = new ArrayList(); 

println("\nBeginning Search");

visited[start] = false;
fringe.add(start);
println("Adding node", start, "(start) to the fringe.");
println(" Current Fringe: ", fringe);

//DFS

/**/
Stack<Integer> stack = new Stack<>();

stack.push(start);
while(!stack.isEmpty()){
  int node = stack.peek();
  stack.pop();
  if(node == goal){
     println("Goal Found");
     break;
  }else if(visited[node]){
     continue;
  }
  visited[node] = true;
  for (int i = neighbors[node].size()-1; i >=0 ; i--){
    int neighborNode = neighbors[node].get(i);
    if (!visited[neighborNode]){
      parent[neighborNode] = node;
      stack.push(neighborNode);
      println("Added node", neighborNode, "to the fringe.");
      println("Current stack : ", stack);
    }
  }
}

//BFS
/*
while (fringe.size() > 0){
  int fringeTop = 0;
  int currentNode = fringe.get(fringeTop);
  fringe.remove(fringeTop);
  if (currentNode == goal){
    println("Goal found!");
    break;
  }
  for (int i = 0; i < neighbors[currentNode].size(); i++){
    int neighborNode = neighbors[currentNode].get(i);
    if (!visited[neighborNode]){
      visited[neighborNode] = true;
      parent[neighborNode] = currentNode;
      fringe.add(neighborNode);
      println("Added node", neighborNode, "to the fringe.");
      println(" Current Fringe: ", fringe);
    }
  } 
}
*/
print("\nReverse path: ");
int prevNode = parent[goal];
print(goal, " ");
while (prevNode >= 0){
  print(prevNode," ");
  prevNode = parent[prevNode];
}
print("\n");
