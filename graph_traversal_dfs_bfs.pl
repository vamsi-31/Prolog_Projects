% --- graph_traversal_dfs_bfs.pl ---
% This file demonstrates Depth-First Search (DFS) and Breadth-First Search (BFS)
% for finding a path in a graph.

% --- Representing the Graph ---
% We'll represent the graph using facts for edges (directed).
% edge(Source, Destination).
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(c, g).
edge(d, h).
edge(e, i).
edge(f, j).
edge(g, k).
edge(k, l). % A longer path
edge(i, l). % Another path to l

% For an undirected graph, you would define edges in both directions:
% connected(X, Y) :- edge(X, Y).
% connected(X, Y) :- edge(Y, X).
% For simplicity, we'll use the directed edges as defined.

% --- Depth-First Search (DFS) ---
% Finds a path from Start node to End node.
% dfs(Start, End, Path)
% Path will be the list of nodes from Start to End.

% Base case: If Start and End are the same, the path is just [Start].
dfs(Node, Node, _, [Node]).

% Recursive step for DFS:
% To find a path from Start to End:
% 1. There must be an edge from Start to NextNode.
% 2. NextNode must not have been visited already in the current path (to avoid cycles).
% 3. Recursively find a path from NextNode to End.
% 4. Prepend Start to the path found from NextNode.
dfs(Start, End, Visited, [Start|Path]) :-
    edge(Start, NextNode),
    \+ member(NextNode, Visited),            % Check if NextNode is not in Visited
    dfs(NextNode, End, [NextNode|Visited], Path).

% Helper predicate to initiate DFS. Visited starts with [Start].
find_path_dfs(Start, End, Path) :-
    dfs(Start, End, [Start], Path).

% Example Queries for DFS:
% ?- find_path_dfs(a, h, Path).
% Output: Path = [a, b, d, h] ; (might find other paths on backtracking if they exist and graph is complex)
%         false. (if no other paths or depending on graph structure)
%
% ?- find_path_dfs(a, l, Path).
% Example Output: Path = [a, b, e, i, l] ; (or Path = [a, c, g, k, l] depending on rule order)
%
% ?- find_path_dfs(a, z, Path). % Node z does not exist or is not reachable
% Output: false.

% --- Breadth-First Search (BFS) ---
% Finds a path from Start to End, typically the shortest path in terms of number of edges.
% bfs(QueueOfPaths, EndNode, FinalPath)
% QueueOfPaths: A list of paths. Each path is a list of nodes.
% We explore paths level by level.

% Base Case: If the current path [Node | PathSoFarReversed] has Node as the End,
% then we've found a path. Reverse it to get the correct order.
bfs_queue([[End|PathSoFarReversed]|_], End, FinalPath) :-
    reverse([End|PathSoFarReversed], FinalPath).

% Recursive Step for BFS:
% 1. Take the first path [CurrentNode | PathSoFarReversed] from the queue.
% 2. Find all neighbors of CurrentNode that haven't been visited in PathSoFarReversed.
% 3. For each such neighbor, create a new path by adding it to the current path.
% 4. Add these new paths to the END of the queue.
% 5. Continue BFS with the updated queue.
bfs_queue([[CurrentNode|PathSoFarReversed]|OtherPaths], End, FinalPath) :-
    findall([Neighbor, CurrentNode|PathSoFarReversed],
            (edge(CurrentNode, Neighbor), \+ member(Neighbor, [CurrentNode|PathSoFarReversed])),
            NewPaths),
    append(OtherPaths, NewPaths, UpdatedQueue), % Add new paths to the end for BFS
    ( UpdatedQueue = [] -> fail ; bfs_queue(UpdatedQueue, End, FinalPath) ). % If queue empty, fail

% Helper predicate to initiate BFS. The queue starts with a single path: [[Start]].
find_path_bfs(Start, End, Path) :-
    bfs_queue([[Start]], End, Path).

% Example Queries for BFS:
% ?- find_path_bfs(a, h, Path).
% Output: Path = [a, b, d, h]. (BFS guarantees shortest path in terms of edges)
%
% ?- find_path_bfs(a, l, Path).
% Output: Path = [a, b, e, i, l]. (Assuming this is shorter or found first by BFS order)
%         (If [a,c,g,k,l] is same length, order depends on findall & append)
%
% ?- find_path_bfs(a, z, Path).
% Output: false.

% Note on BFS implementation:
% - The `PathSoFarReversed` includes the CurrentNode and all its predecessors.
% - `\+ member(Neighbor, [CurrentNode|PathSoFarReversed])` checks if neighbor is already in path.
% - `append(OtherPaths, NewPaths, UpdatedQueue)` ensures breadth-first exploration.
% - If `UpdatedQueue` becomes empty and no solution was found, it will fail, which is correct.

% You can add more edges or nodes to test with more complex scenarios.
% For example, add a cycle:
% edge(l, a).
% And then test dfs. It should not loop indefinitely due to the Visited check.
% Test bfs with cycles too. It should also handle them correctly.
