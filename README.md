# Prolog Learning Path 🚀

Welcome to the Prolog Learning Path repository! This collection of Prolog programs is designed to help beginners explore the fascinating world of logic programming. We'll guide you from the very basics to more complex examples, making your learning journey smooth and enjoyable.

## ⭐ Featured Examples for Learning

To help you get started and see Prolog in action, here are some handpicked examples:

### 🌱 Easy
1.  **`hello_world.pl`**
    *   **Concept:** The essential first program. Prints "hello world" and introduces the basic idea of a goal and output.
    *   **Why:** A gentle introduction, perfect for verifying your Prolog setup and seeing a program run.
2.  **`basic_facts_and_rules.pl`**
    *   **Concept:** Defines simple facts (unconditional truths) and rules (conditional truths). Shows how Prolog uses these to answer queries.
    *   **Why:** Clearly demonstrates Prolog's declarative nature and its fundamental reasoning mechanism.
3.  **`factorial_recursive_standard.pl`** (was `t.pl`)
    *   **Concept:** Calculates factorial using recursion, a core technique in Prolog. Shows a base case and a recursive step.
    *   **Why:** A classic, easily understandable example of how recursion is expressed in Prolog for mathematical computations.

### 🌳 Medium
1.  **`family_tree.pl`** (was `FamilyTree.pl`)
    *   **Concept:** Models family relationships (parent, male, female) as facts and defines complex relations (father, grandmother, ancestor) using rules.
    *   **Why:** A classic Prolog example showcasing how to represent knowledge and deduce new information about relationships.
2.  **`simple_database_queries.pl`** (was `simple_db_queries.pl`)
    *   **Concept:** Uses Prolog facts to store data (like book records) and rules to perform sophisticated queries on this data.
    *   **Why:** Illustrates Prolog's capability as a powerful querying language for structured information, akin to a database.

### 🌲 Complex
1.  **`sentence_parser_dcg.pl`**
    *   **Concept:** Implements a simple English grammar using Definite Clause Grammars (DCGs) to parse sentences and build a parse tree.
    *   **Why:** Highlights one of Prolog's most powerful and unique features, showcasing its strengths in natural language processing and symbolic computation.

---

## 🌟 Why Prolog?

Prolog (Programming in Logic) is a powerful language that's excellent for tasks involving symbolic reasoning, artificial intelligence, natural language processing, and database querying. It works by defining facts and rules, and then asking questions (queries) to deduce new information. It encourages a declarative way of thinking about problems.

## 🛠️ How to Use This Repository

1.  **Get a Prolog Environment:** Download and install a Prolog interpreter. [SWI-Prolog](https://www.swi-prolog.org/) is a popular, free, and open-source option.
2.  **Consult a File:** Open a `.pl` file from this repository in your Prolog environment. Most interpreters have a "Consult" option in their File menu, or you can use a command like `consult('filename.pl').` in the Prolog console.
3.  **Run Queries:** Once a file is consulted, you can run the queries suggested in the examples below or try your own! Remember to end your queries with a period (`.`). If multiple solutions exist, Prolog might show one and wait; you can type a semicolon (`;`) to see the next solution, or press Enter to stop.

---

## 🏁 Section 1: Getting Started - The Bare Essentials

This section introduces the absolute basics: how to write simple statements and ask Prolog about them.

### 🌍 Hello, World!
*   **File:** `hello_world.pl`
*   **Concept:** The most basic Prolog program that prints "hello world" to the console. It introduces the concept of a *goal* (`main`) and a built-in *predicate* (`write/1`) for output. This is often the first program you write in any new language!
*   **How to Run:**
    1.  Consult `hello_world.pl`.
    2.  At the Prolog prompt (usually `?-`), type: `main.`
*   **Expected Output:**
    ```prolog
    hello world
    true.
    ```
    The `true.` means Prolog successfully achieved the goal.

### 🧠 Facts & Basic Queries
*   **File:** `basic_facts_queries.pl`
*   **Concept:** This program demonstrates how to define *facts* in Prolog. Facts are statements that are unconditionally true, like "Socrates is a man" or "The sky is blue." You'll learn how to ask Prolog questions (queries) about these facts.
    *   `likes(vamsi, krishna).` states that "vamsi likes krishna". This is a fact with a predicate `likes` and two arguments.
    *   `rises(sun).` states that "sun rises".
*   **Example Queries (after consulting `basic_facts_queries.pl`):**
    *   `?- likes(vamsi, krishna).` (Does vamsi like krishna?)
        *   Output: `true.`
    *   `?- likes(X, krishna).` (Who likes krishna? `X` is a variable.)
        *   Output: `X = vamsi.`
    *   `?- likes(vamsi, X).` (Whom or what does vamsi like?)
        *   Output: `X = krishna ;` (press `;` for more solutions)
        *   `X = surya ;`
        *   `X = mangoes.`

### 📜 Basic Facts and Rules
*   **File:** `basic_facts_and_rules.pl`
*   **Concept:** Building on just facts, this file introduces *rules*. A rule is a way to define new information based on existing facts or other rules. For example, "X is a person if X is a man." This file shows simple facts (e.g., `is_fruit(apple).`) and simple rules (e.g., `healthy_snack(X) :- is_fruit(X).` which means "X is a healthy snack if X is a fruit"). It's a great next step to see how Prolog can reason.
*   **Example Queries (after consulting `basic_facts_and_rules.pl`):**
    *   `?- is_fruit(apple).`
        *   Output: `true.`
    *   `?- healthy_snack(apple).` (Prolog uses the rule to figure this out)
        *   Output: `true.`
    *   `?- healthy_snack(X).` (What things are healthy snacks?)
        *   Output: `X = apple ; X = banana.`

### ✂️ Understanding the "Cut" (`!`)
*   **File:** `cut_examples.pl`
*   **Concept:** The "cut" (written as `!`) is a special goal in Prolog that affects how Prolog searches for solutions (backtracking). It can be used to make programs more efficient (a "green cut") or to change their logic, for example, to implement an if-then-else structure (often a "red cut"). This file provides simple examples to illustrate both types. Understanding the cut is important for more advanced Prolog programming.
*   **Key Ideas to Look For:**
    *   `max_green_cut/3`: Shows how `!` can prevent Prolog from looking for alternative solutions once one is found, making it faster if you only need one answer.
    *   `classify_num_red_cut/2`: Shows how `!` can be used to create if-then-else logic.
*   **Example Queries (after consulting `cut_examples.pl`):**
    *   `?- max_green_cut(5, 3, Max).`
        *   Output: `Max = 5.`
    *   `?- classify_num_red_cut(0, Type).`
        *   Output: `Type = zero.`
    *   `?- discount(book, 25, D).`
        *   Output: `D = '10%'.` (The cut ensures only the first matching discount rule is used).

---

## 🧮 Section 2: Working with Data - Numbers, Lists, and Databases

Prolog isn't just for logic; it can handle data too! This section covers arithmetic, a fundamental data structure called lists, and how Prolog can act like a simple database.

### ➕ Simple Arithmetic Operations
*   **File:** `simple_calculator.pl` (covers basic operations)
*   **Concept:** Prolog can perform arithmetic. This program shows how to do addition, subtraction, etc. It uses the `is` operator, which is crucial: `X is 2 + 2` calculates `2+2` and makes `X` equal to `4`.
*   **How to Run:** Consult `simple_calculator.pl`, then type `ar.` and follow the prompts for numbers.
*   **Example (Input 10, then 5 for `ar.`):**
    `sum is : 15`
    `diff is : 5`
    `...and so on for other operations.`

### !️⃣ Factorial Calculation
*   **File:** `factorial_interactive.pl` (original interactive version)
*   **Concept:** Factorial (e.g., 5! = 5\*4\*3\*2\*1 = 120) is a classic example of *recursion*. A recursive definition has a *base case* (e.g., factorial of 0 is 1) and a *recursive step* (e.g., factorial of N is N times factorial of N-1).
*   **Note:** The `factorial_interactive.pl` in the repo has an unusual structure for direct querying but is interactive. For a more standard, queryable definition, see `factorial_recursive_standard.pl`. A typical standard definition is:
    ```prolog
    factorial(0, 1). % Base case
    factorial(N, F) :- N > 0, N1 is N - 1, factorial(N1, F1), F is N * F1.
    ```
*   **Standard Query (for a version like `factorial_recursive_standard.pl`):**
    *   `?- factorial(5, X).`
        *   Output: `X = 120.`

### 📚 Simple Database Queries
*   **File:** `simple_database_queries.pl`
*   **Concept:** You can store information as Prolog facts, just like records in a database table. Then, you can write rules to query this information. This example stores facts about books (title, author, genre, year) and shows how to ask questions like "Find all books by Tolkien" or "List sci-fi books published after 1960."
*   **Example Queries:**
    *   `?- books_by_author('J.R.R. Tolkien', Title).`
    *   `?- books_in_genre(scifi, Title).`
    *   `?- authors_in_genre(fantasy, AuthorsList).`

### 📋 Basic List Operations
*   **File:** `basic_list_operations.pl` (also see `list_length.pl`, `list_concatenation.pl`, `list_sum_elements.pl`, `list_reverse.pl`, `list_intersection.pl`, `List_union.pl` for more examples).
*   **Concept:** Lists are ordered collections of items, like `[a, b, c]` or `[1, 2, 3]`. They are incredibly useful in Prolog. This file (and others listed) show common operations:
    *   `my_member(Element, List)`: Is Element in the List?
    *   `my_append(List1, List2, ResultList)`: Join List1 and List2.
    *   `my_reverse(List, ReversedList)`: Reverse the List.
    *   `list_length(List, Length)`: Find the length of a List.
*   **Example Queries (from `basic_list_operations.pl`):**
    *   `?- my_member(b, [a,b,c]).`
        *   Output: `true.`
    *   `?- my_append([1,2], [3,4], R).`
        *   Output: `R = [1,2,3,4].`
    *   `?- my_reverse([a,b,c], Rev).`
        *   Output: `Rev = [c,b,a].`

### 🔁 Palindrome Check
*   **File:** `palindrome_checker.pl`
*   **Concept:** A palindrome is a word or list that reads the same forwards and backward (e.g., "madam", `[m,a,d,a,m]`). This program checks if a list is a palindrome, usually by reversing it and comparing it to the original.
*   **Example Query (using a helper like `my_reverse/2` from `basic_list_operations.pl` or `list_reverse.pl`):**
    *   If you define `is_palindrome(L) :- my_reverse(L, L).`
    *   `?- is_palindrome([m,a,d,a,m]).`
        *   Output: `true.`
    *   The `palind/1` in `palindrome_checker.pl` prints the result directly.

---

## 🧩 Section 3: Logic, Puzzles, and Reasoning

This is where Prolog truly shines! These examples show how to represent complex relationships and solve problems that require logical deduction.

### 👨‍👩‍👧‍👦 Family Tree
*   **File:** `family_tree.pl` (See also `family_tree_variation.pl` and `family_tree_extended.pl` (was `L.pl`) for other variations)
*   **Concept:** A classic Prolog example. You define facts about family members (e.g., `male(john).`, `parent_of(john, mary).`) and then write rules to define more complex relationships like `father_of(F,C)`, `sibling_of(A,B)`, `grandfather_of(GF,GC)`, etc. Prolog can then answer questions like "Who is Mary's grandfather?".
*   **Example Queries:**
    *   `?- father_of(jack, jess).`
    *   `?- grandfather_of(GrandFather, simon).`
    *   `?- ancestor_of(X, harry).` (Find all ancestors of Harry)

### 🗺️ Map Coloring
*   **File:** `map_coloring.pl`
*   **Concept:** A common problem in computer science and logic. The goal is to assign colors to regions on a map such that no two adjacent regions have the same color. This example uses a few colors (e.g., red, green, blue) and a small map, demonstrating how Prolog can find a valid coloring using constraints.
*   **How to Run:**
    *   `?- solve_map_coloring(Solution).` (Provides a list of region-color pairs)
    *   `?- solve_map_coloring(S), pretty_print_solution(S).` (Prints it nicely)
*   **Example Output Snippet:**
    `Region r1 is colored red`
    `Region r2 is colored green` ...

### 🕵️ Simple Logic Puzzle (Einstein-like)
*   **File:** `logic_puzzle_einstein.pl`
*   **Concept:** These puzzles involve a set of items in different categories (e.g., people, nationalities, pets, drinks) and a list of clues linking them. The goal is to deduce all relationships (e.g., "Who owns the Zebra?"). This program sets up a simplified version and uses Prolog's search and constraint satisfaction capabilities to find the solution.
*   **How to Run:**
    *   `?- solve_and_report.`
*   **Example Output Snippet:**
    `--- Logic Puzzle Solution ---`
    `  Nationality: english, Beverage: tea, Pet: cat`
    `  ... (other people) ...`
    `The japanese owns the Zebra.`

### 💡 Simple Expert System
*   **File:** `simple_expert_system.pl`
*   **Concept:** An expert system tries to mimic the decision-making ability of a human expert. This program builds a small knowledge base about animals and their characteristics (e.g., "sparrow has feathers", "lion is a carnivore"). Then, it uses rules to classify animals (e.g., "if X has feathers, X is a bird"). You can ask it to identify an animal based on its known properties.
*   **Example Queries:**
    *   `?- identify(sparrow).`
    *   `?- identify(lion).`
    *   `?- identify_all.` (Tries to classify all animals it knows about)
*   **Example Output for `identify(sparrow).`:**
    `--- Identifying: sparrow ---`
    `Type: BIRD`
    `  - Can fly`
    `  Known properties: ...`

### 🧭 Graph Traversal (DFS & BFS)
*   **File:** `graph_traversal_dfs_bfs.pl`
*   **Concept:** Graphs are structures made of nodes and edges connecting them. Finding a path between two nodes is a common task. This program shows two ways to do this:
    *   **Depth-First Search (DFS):** Explores as far as possible along each branch before backtracking.
    *   **Breadth-First Search (BFS):** Explores all neighbors at the present depth prior to moving on to nodes at the next depth level (finds the shortest path in terms of number of edges).
*   **Example Queries:**
    *   `?- find_path_dfs(a, h, Path).` (Find a path from node 'a' to 'h' using DFS)
    *   `?- find_path_bfs(a, l, Path).` (Find a path from 'a' to 'l' using BFS)

### 💧 4-Litre Water Jug Problem
*   **File:** `water_jug_problem_4l_3l.pl`
*   **Concept:** A classic puzzle: using only a 4-litre jug and a 3-litre jug (and an unlimited water source), can you measure out exactly 2 litres? The version in this repository is a specific state-checker. A more general solution involves defining states (amount of water in each jug) and actions (fill, empty, pour) and searching for a sequence of actions to reach the goal state.
*   **Note:** This example is good for understanding how states can be represented, but a full search-based solution would be more complex and typical for AI problem-solving.

---

## 🎮 Section 4: AI, Planning, and Language

More advanced topics showing Prolog's strengths in AI and symbolic computation.

### 🕹️ Tic-Tac-Toe with AI
*   **File:** `tic_tac_toe_ai.pl`
*   **Concept:** Implements the game of Tic-Tac-Toe where a human can play against the computer. The computer AI uses a strategy:
    1.  Win if it can.
    2.  Block the opponent's win if necessary.
    3.  Take the center, then corners, then sides.
    This demonstrates game state representation, win/draw detection, and basic AI decision-making.
*   **How to Run:**
    *   `?- play.` (Follow prompts to enter moves 1-9)

### 🧱 Blocks World Planner (Simple)
*   **File:** `blocks_world_planner_simple.pl`
*   **Concept:** The Blocks World is a classic AI planning problem. You have a set of blocks on a table or stacked on each other. The goal is to reach a specific configuration of blocks (e.g., block A on block B, block B on block C). This program implements a simple planner that finds a sequence of actions (like `pickup(Block)`, `stack(Block, OnBlock)`) to get from an initial state to a goal state.
*   **Example Queries:**
    *   `?- test_plan1(Plan).` (Tries to stack a,b,c from table)
    *   `?- test_plan2(Plan).` (Involves unstacking first)
*   **Output:** `Plan` will be a list of actions, e.g., `[pickup_from_table(b), stack_on_block(b,c), ...]`

### 🗣️ Sentence Parser (DCG)
*   **File:** `sentence_parser_dcg.pl`
*   **Concept:** Prolog has a powerful feature called Definite Clause Grammars (DCGs) which is excellent for parsing languages (like simple English). This program defines a small grammar (rules for what makes a valid sentence, noun phrase, verb phrase, etc.) and a lexicon (list of known words). It can then parse sentences like "the fluffy cat slept" and even build a tree structure representing the sentence's grammar.
*   **Example Queries:**
    *   `?- phrase(sentence, [the, cat, sat, on, the, mat]).`
        *   Output: `true.`
    *   `?- phrase(sentence(ParseTree), [a, big, dog, chased, a, cat]).`
        *   Output: `ParseTree = s(np(det(a), [adj(big)], n(dog)), vp(v(chased), np(det(a), [], n(cat)))).` (or similar tree structure)
    *   `?- parse([the, fluffy, cat, slept]).` (Uses a helper to print the tree)

---

## 💡 Section 5: Simple Applications & Data Management (Existing Examples)

These are existing interactive programs from the repository that show how Prolog can be used for basic data input, processing, and output.

### 🧑‍💼 Employee Data
*   **File:** `employee_salary_calculator.pl`
*   **Concept:** Calculates an employee's gross salary based on interactive input.

### 📦 Inventory Management
*   **File:** `inventory_manager.pl`
*   **Concept:** Interactively manages a list of inventory items, costs, and descriptions.

### 🎓 Student Marks & Average
*   **File:** `student_marks_percentage.pl`
*   **Concept:** Calculates student percentages based on marks entered for multiple subjects.
    *   **Note:** `student_marks_percentage.pl` is more complete. The previous `studentaverage.pl` file had logical issues and has been removed.

---

## 📖 Section 6: Further Learning Resources

Ready to dive deeper into Prolog? Here are some excellent resources:

*   **SWI-Prolog Documentation:**
    *   [Official Website](https://www.swi-prolog.org/): Downloads, manuals, and more.
    *   [SWI-Prolog Manual](https://www.swi-prolog.org/pldoc/man?section=summary): A comprehensive guide.
*   **Online Tutorials & Books:**
    *   [Learn Prolog Now!](https://www.learnprolognow.org/): A classic and highly recommended free online book/course.
    *   [Prolog Wikibook](https://en.wikibooks.org/wiki/Prolog): A collaborative textbook.
    *   [The Power of Prolog](https://www.metalevel.at/prolog): Modern Prolog programming, with many examples (by Markus Triska, a prominent SWI-Prolog developer).
*   **Practice Platforms:**
    *   [Prolog Problems](https://prologproblems.org/): A collection of problems to solve in Prolog, inspired by Ninety-Nine Lisp Problems.
*   **Online Prolog Environments:**
    *   [SWISH](https://swish.swi-prolog.org/): An online SWI-Prolog environment for running and sharing code, great for quick experiments.
*   **Community:**
    *   [SWI-Prolog Discourse Forum](https://swi-prolog.discourse.group/): Ask questions and discuss with the SWI-Prolog community.
    *   Stack Overflow (Prolog tag): Many questions answered, a good resource for specific problems.

Happy Prolog-gramming! 🎉