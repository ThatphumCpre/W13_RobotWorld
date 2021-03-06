class Node {
  
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: Node to collect string values and implement binary tree
    //
    /////////////////////////////////////////////////////

  String command = null;  //Set command as attribute to collect command 
  boolean ifType;          //Set ifType to collect is it "IF" in flowchart
  Node endTrueNode = null;    //Set endTrueNode as attribute to collect endTrueNode
  Node left = null;    //Set left as attribute to link to left node
  Node right = null; //Set right as attribute to link to right node

  Node() {
  }

  Node(String args) {    //create node that have command from argument 
    this.command = args;
  }

  Node(String condition, String trueCommand, String falseCommand) { //Add if Node 
  
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: Instance with if condition to Binary Tree 
    //
    /////////////////////////////////////////////////////
    
    command = "IF "+condition;      //give command condition to attribute 
    ifType = true;                  //give this node as "if" node
    left = new Node(falseCommand);  //create left node
    right = new Node(trueCommand);  //create right node
    endTrueNode = right;           //create endTrueNode that "IF" Node done will end with this node 
  }

  Node addRight(Node currentNode, String cmd) {
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add String command to most right node 
    //
    /////////////////////////////////////////////////////
    
    Node temp;
    if ( currentNode.right == null ) {      //if last node then create node
      currentNode.right = new Node(cmd);
      return currentNode.right;      //return and collect to temp 
    } else {
      temp = currentNode.addRight(currentNode.right, cmd);  //recursive if node is not last one 
    }
    println(temp);
    return temp;
  }

  void addRight(Node currentNode, Node subTree) {
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add SubTree to most right node
    //
    /////////////////////////////////////////////////////
    
    if (currentNode.right == null) {
      currentNode.right = subTree;    //if right note is not empty put subTree to empty node 
    } else {
      currentNode.addRight(currentNode.right, subTree); //recursive if node is not last one 
    }
  }

  void addLeft(Node currentNode, String cmd) {
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add command to most left node 
    //
    /////////////////////////////////////////////////////    
    
    if (currentNode.left == null) {
      currentNode.left = new Node(cmd);  //if right node is empty create a new node
    } else {
      currentNode.addLeft(currentNode.left, cmd);    //if not recursive with left node 
    }
  }

  void addLeft(Node currentNode, Node subTree) {
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add node to most left Node 
    //
    /////////////////////////////////////////////////////
    
    if (currentNode.left == null) {     
      currentNode.left = subTree;   //if right node is not empty put subTree to empty node 
    } else {
      currentNode.addLeft(currentNode.left, subTree);  //recursive if node is not last one 
    }
  }
  
 
}

class Flowchart {
  
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: implement binary tree to flowchart
    //
    /////////////////////////////////////////////////////
    
  Node data;      //Set data as attribute to collect Node or Binary tree 
  Node lastIF;    //Collect last if node that was create 

  Flowchart() {
    data = new Node();    //create empty node
  }

  void addCommand(String args) {
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add command args to binary tree
    //
    /////////////////////////////////////////////////////
    
    if (data.command == null) {  //if first node is empty then 
      data.command = args;   //add command 
    } else {
      data.addRight(data, args);  //insert command to most right node
    }
  }

  void addCommand(Flowchart subFlow) {
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add subFlowchart or sub Binary Tree to Main Tree
    //
    /////////////////////////////////////////////////////
    
    if ( data.command == null) {  //if first node is empty then
      data = subFlow.data;      //put sub Binary tree instead old data 
    } else {
      data.addRight(data, subFlow.data);    //put sub Binary tree to most right data 
    }
    lastIF = subFlow.lastIF;    //collect last time if that create from sub Binary Tree
  }

  void addFalseCommand(String args) {
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add False command to last if that was create
    //
    /////////////////////////////////////////////////////
    
    lastIF.addLeft(lastIF, args);   //add command to most left from lastIF node 
  }

  void addFalseCommand(Flowchart subFlow) {
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add False command to alst if that was create 
    //
    /////////////////////////////////////////////////////
    
    lastIF.addLeft(lastIF, subFlow.data);  //add sub Binary Tree to most left from lastIF node 
  }
  
  void addTrueCommand(String args){
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add True command to a last if node that was  create
    //
    /////////////////////////////////////////////////////
    
    Node temp = lastIF.addRight(lastIF,args);  //add command to most right from lastIF node and collect to temp
    lastIF.endTrueNode = temp;      //add new end node that was created
  }
  
  void addTrueCommand(Flowchart subFlow){
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add True command to a last if node that was create 
    //
    /////////////////////////////////////////////////////
    
    lastIF.addRight(lastIF, subFlow.data); //add subBinart Tree to most right from lastIF node 
  }


  void addIFcommand(String condition, String trueCommand, String falseCommand) { 
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add if command to most right node
    //
    /////////////////////////////////////////////////////
    
    Node temp = new Node(condition, trueCommand, falseCommand); //add if command 
    lastIF = temp;                
    if (data.command != null ) {
      data.addRight(data, temp);    //add to most right node 
    } else {
      data = temp;
    }
  }

  void addIFcommand(String condition, Flowchart trueCommand, Flowchart falseCommand) {
    
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: add if command from subTree
    //
    /////////////////////////////////////////////////////
    
    Flowchart temp = new Flowchart();  //create temp flowchart
    temp.addCommand(condition);    //add command condition
    temp.data.right = trueCommand.data;    //put right as true sub Binary Tree
    temp.data.left = falseCommand.data;    //put left as false sub Binary Tree
    data.addRight(data, temp.data);  //add to the most right node
  }

  void getFlow() {
    /////////////////////////////////////////////////////
    //
    // Programmer: ThatphumCpre
    //
    // Description: view all command node that not null
    //
    /////////////////////////////////////////////////////
    
    getFlow(this.data);
  }

  void getFlow(Node args) {  //view all command 
    if (args != null ) {
      println(args.command);
      getFlow(args.left); //go to most left
      getFlow(args.right);    //go to most right
    }
  }

}
