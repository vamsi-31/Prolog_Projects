% --- sentence_parser_dcg.pl ---
% This file demonstrates parsing simple English sentences using
% Definite Clause Grammars (DCGs) in Prolog.

% --- DCG Rules ---
% A DCG rule defines how a grammatical category can be formed.
% --> is the DCG operator.
% Terminals (words) are usually enclosed in lists.

% Sentence structure: A sentence is a noun phrase followed by a verb phrase.
% sentence(Tree) --> noun_phrase(NP_Tree), verb_phrase(VP_Tree).
% For simplicity, we'll first parse without building an explicit parse tree.
sentence --> noun_phrase, verb_phrase.

% Noun Phrase (NP): Can be a determiner followed by a noun, or just a proper noun.
% noun_phrase --> determiner, noun.
% noun_phrase --> proper_noun. % Proper nouns usually don't take determiners.

% Let's make NP more structured: determiner, optional adjective, noun
noun_phrase --> determiner, opt_adjective_list, noun.
noun_phrase --> proper_noun. % Proper nouns like 'john' or 'mary'

opt_adjective_list --> adjective, opt_adjective_list.
opt_adjective_list --> []. % Empty list - no adjective

% Verb Phrase (VP): Can be a verb, or a verb followed by a noun phrase (transitive),
% or a verb followed by a prepositional phrase.
verb_phrase --> verb. % Intransitive verb (e.g., "the cat sleeps")
verb_phrase --> verb, noun_phrase. % Transitive verb (e.g., "the cat chased the mouse")
verb_phrase --> verb, prepositional_phrase. % Verb with PP (e.g., "the cat sat on the mat")
verb_phrase --> verb, noun_phrase, prepositional_phrase. % e.g., "the dog put the bone in the bowl"


% Prepositional Phrase (PP): A preposition followed by a noun phrase.
prepositional_phrase --> preposition, noun_phrase.

% --- Lexicon (Terminal Symbols - Words) ---
determiner --> [the].
determiner --> [a].
determiner --> [an]. % Requires checking context for vowel, simplified here

noun --> [cat].
noun --> [cats].
noun --> [dog].
noun --> [dogs].
noun --> [mouse].
noun --> [mice].
noun --> [mat].
noun --> [mats].
noun --> [boy].
noun --> [girl].
noun --> [ball].
noun --> [house].
noun --> [tree].
noun --> [man].
noun --> [woman].
noun --> [book].

proper_noun --> [john].
proper_noun --> [mary].


adjective --> [big].
adjective --> [small].
adjective --> [red].
adjective --> [fluffy].
adjective --> [quick].
adjective --> [brown].

verb --> [sat].
verb --> [chased].
verb --> [ate].
verb --> [slept].
verb --> [ran].
verb --> [jumped].
verb --> [saw].
verb --> [liked].
verb --> [put]. % Transitive, often needs a PP too

preposition --> [on].
preposition --> [in].
preposition --> [under].
preposition --> [near].
preposition --> [with].
preposition --> [behind].


% --- How to Use DCGs for Parsing ---
% The phrase/2 predicate is used to parse a list of words using a DCG rule.
% phrase(RuleName, ListOfWordsToParse)
% It succeeds if ListOfWordsToParse can be parsed according to RuleName.

% ?- phrase(sentence, [the, cat, sat, on, the, mat]).
% Output: true.

% ?- phrase(sentence, [a, fluffy, dog, chased, a, quick, brown, mouse]).
% Output: true.

% ?- phrase(sentence, [the, cat, slept]).
% Output: true.

% ?- phrase(sentence, [john, saw, mary]). % NP -> proper_noun, VP -> verb, NP -> proper_noun
% Output: true.

% ?- phrase(sentence, [the, cat, on, the, mat, sat]). % Ungrammatical by our rules
% Output: false.

% ?- phrase(sentence, [cat, sat]). % "cat" needs a determiner by current NP rule
% Output: false.
% (To allow "cats sat", we'd need noun_phrase --> noun for plurals without determiners, or adjust rules)

% ?- phrase(noun_phrase, [the, big, red, ball], Remainder). % Parse part of a list
% Output: Remainder = []. (If it consumes all)
%
% ?- phrase(verb_phrase, [chased, a, dog], []).
% Output: true.

% --- Building Parse Trees (More Advanced) ---
% DCGs can also be used to build parse trees that represent the sentence structure.
% This is done by adding arguments to the non-terminal symbols in the DCG rules.

% Example: sentence(s(NP_Tree, VP_Tree)) --> noun_phrase(NP_Tree), verb_phrase(VP_Tree).
% noun_phrase(np(D_Tree, N_Tree)) --> determiner(D_Tree), noun(N_Tree).
% determiner(det(the)) --> [the].
% noun(n(cat)) --> [cat].
% ...and so on for all rules and terminals.

% Redefining some rules to build parse trees:
sentence(s(NP, VP)) --> noun_phrase(NP), verb_phrase(VP).

noun_phrase(np(D, ADJ_L, N)) --> determiner(D), opt_adjective_list_tree(ADJ_L), noun(N).
noun_phrase(np(PN)) --> proper_noun(PN).

opt_adjective_list_tree([A|ADJ_L_Rest]) --> adjective(A), opt_adjective_list_tree(ADJ_L_Rest).
opt_adjective_list_tree([]) --> []. % Base case: empty list of adjectives

verb_phrase(vp(V)) --> verb(V).
verb_phrase(vp(V, NP)) --> verb(V), noun_phrase(NP).
verb_phrase(vp(V, PP)) --> verb(V), prepositional_phrase(PP).
verb_phrase(vp(V, NP, PP)) --> verb(V), noun_phrase(NP), prepositional_phrase(PP).

prepositional_phrase(pp(P, NP)) --> preposition(P), noun_phrase(NP).

% Lexicon with tree structures
determiner(det(the)) --> [the].
determiner(det(a)) --> [a].
determiner(det(an)) --> [an].

noun(n(cat)) --> [cat].
noun(n(cats)) --> [cats].
noun(n(dog)) --> [dog].
noun(n(dogs)) --> [dogs].
noun(n(mouse)) --> [mouse].
noun(n(mat)) --> [mat].
noun(n(boy)) --> [boy].
noun(n(ball)) --> [ball].

proper_noun(pn(john)) --> [john].
proper_noun(pn(mary)) --> [mary].

adjective(adj(big)) --> [big].
adjective(adj(small)) --> [small].
adjective(adj(red)) --> [red].
adjective(adj(fluffy)) --> [fluffy].
adjective(adj(quick)) --> [quick].
adjective(adj(brown)) --> [brown].

verb(v(sat)) --> [sat].
verb(v(chased)) --> [chased].
verb(v(ate)) --> [ate].
verb(v(slept)) --> [slept].
verb(v(put)) --> [put].

preposition(p(on)) --> [on].
preposition(p(in)) --> [in].
preposition(p(under)) --> [under].

% --- Querying with Parse Tree Generation ---
% ?- phrase(sentence(ParseTree), [the, fluffy, cat, slept]).
% Output: ParseTree = s(np(det(the), [adj(fluffy)], n(cat)), vp(v(slept))).
%
% ?- phrase(sentence(ParseTree), [john, put, a, ball, in, the, box]).
% (Assuming 'box' is added to nouns)
% Expected like:
% ParseTree = s(np(pn(john)), vp(v(put), np(det(a), [], n(ball)), pp(p(in), np(det(the), [], n(box)))))
% (Need to add 'box' to lexicon for this to work)
% Let's add box:
% noun(n(box)) --> [box].

% Run the query again after adding 'box' to the noun rules (and reconsulting):
% ?- noun(n(box)) --> [box]. (add this to your code and reconsult)
% ?- phrase(sentence(ParseTree), [john, put, a, ball, in, the, box]).
% Output should be something like:
% ParseTree = s(np(pn(john)), vp(v(put), np(det(a), [], n(ball)), pp(p(in), np(det(the), [], n(box))))).

% This is a very basic parser. Real natural language parsing is much more complex,
% handling ambiguity, more grammar rules, agreement (subject-verb, noun-determiner), etc.
% DCGs provide a powerful and readable way to express grammars in Prolog.

% To make the second set of rules (with trees) active, you might need to comment out
% the first set of simpler rules if they have the same names (e.g., sentence//0 vs sentence//1).
% Prolog typically uses the first one it finds or the one with matching arity.
% For this file, I've made them distinct by arity (sentence//0 vs sentence//1) so both can coexist.
% You choose which one to call with phrase/2 or phrase/3.
% phrase(sentence, Words) uses sentence//0.
% phrase(sentence(Tree), Words) uses sentence//1.

% Consider adding a simple "driver" predicate:
parse(Words) :-
    ( phrase(sentence(Tree), Words) ->
        format('Parse successful!~nTree: ~w~n', [Tree])
    ; format('Parse failed for: ~w~n', [Words])
    ).

% ?- parse([the, big, dog, chased, a, cat]).
% ?- parse([mary, slept]).
% ?- parse([a, cat, on, a, mat, saw, a, dog]). % Might be ambiguous or parsed differently
                                          % depending on VP rule order.
                                          % vp(V, NP, PP) vs vp(V, PP) etc.
                                          % Current rules might parse "cat on a mat" as NP if PP can attach to NP.
                                          % Our current NP doesn't directly take a PP.
                                          % "a cat on a mat" as a subject would require NP --> NP, PP.
                                          % Let's test: phrase(noun_phrase(T), [the,cat,on,the,mat]). Fails. Good.
% The current grammar is quite simple and left-associative in many ways.
% Ambiguity handling often requires more sophisticated DCGs or parsing strategies.
