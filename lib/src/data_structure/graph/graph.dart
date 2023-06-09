
import 'dart:collection';

class GraphNode<T> {
  final T value;
  List<GraphNode<T>> adjacents = [];

  GraphNode(this.value);
}

class Graph<T> {
  final Map<T, GraphNode<T>> _nodes = {};

  void addNode(T value) {
    _nodes[value] = GraphNode(value);
  }

  void addEdge(T source, T destination) {
    if (!_nodes.containsKey(source) || !_nodes.containsKey(destination)) {
      throw Exception('Source or destination node is not present');
    }
    _nodes[source]!.adjacents.add(_nodes[destination]!);
  }

  // Size of the graph
  int size() {
    return _nodes.length;
  }

  // Contains method
  bool contains(T value) {
    return _nodes.containsKey(value);
  }

  // Depth-First Search
  void depthFirstSearch(T startValue, void Function(T value) visit) {
    var startNode = _nodes[startValue];
    if (startNode == null) return;
    var visitedNodes = <GraphNode<T>>{};
    _depthFirstSearch(startNode, visitedNodes, visit);
  }

  void _depthFirstSearch(
      GraphNode<T> node, Set<GraphNode<T>> visitedNodes, void Function(T value) visit) {
    visit(node.value);
    visitedNodes.add(node);
    for (var adjacent in node.adjacents) {
      if (!visitedNodes.contains(adjacent)) {
        _depthFirstSearch(adjacent, visitedNodes, visit);
      }
    }
  }

  // Breadth-First Search
  void breadthFirstSearch(T startValue, void Function(T value) visit) {
    var startNode = _nodes[startValue];
    if (startNode == null) return;
    var queue = Queue<GraphNode<T>>();
    var visitedNodes = <GraphNode<T>>{};
    queue.add(startNode);
    visitedNodes.add(startNode);
    while (queue.isNotEmpty) {
      var currentNode = queue.removeFirst();
      visit(currentNode.value);
      for (var adjacent in currentNode.adjacents) {
        if (!visitedNodes.contains(adjacent)) {
          queue.add(adjacent);
          visitedNodes.add(adjacent);
        }
      }
    }
  }
}
