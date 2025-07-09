% --- simple_db_queries.pl ---
% This file demonstrates how Prolog can be used as a simple database
% by defining facts and then writing rules to query these facts.

% --- Facts ---
% We define facts about books: book(Title, Author, Genre, YearPublished, CopiesSold).

book('The Hobbit', 'J.R.R. Tolkien', fantasy, 1937, 100000000).
book('1984', 'George Orwell', dystopia, 1949, 50000000).
book('The Lord of the Rings', 'J.R.R. Tolkien', fantasy, 1954, 150000000).
book('To Kill a Mockingbird', 'Harper Lee', fiction, 1960, 40000000).
book('Pride and Prejudice', 'Jane Austen', romance, 1813, 20000000).
book('The Great Gatsby', 'F. Scott Fitzgerald', fiction, 1925, 30000000).
book('Dune', 'Frank Herbert', scifi, 1965, 20000000).
book('Foundation', 'Isaac Asimov', scifi, 1951, 15000000). % A bit less than Dune
book('Brave New World', 'Aldous Huxley', dystopia, 1932, 45000000).


% --- Rules (Queries) ---

% Find all books by a specific author.
% books_by_author(Author, Title)
books_by_author(Author, Title) :-
    book(Title, Author, _, _, _). % Underscores mean we don't care about these values.

% Find all books in a specific genre.
% books_in_genre(Genre, Title)
books_in_genre(Genre, Title) :-
    book(Title, _, Genre, _, _).

% Find books published after a certain year.
% books_published_after(Year, Title, ActualYear)
books_published_after(Year, Title, ActualYear) :-
    book(Title, _, _, ActualYear, _),
    ActualYear > Year.

% Find books published before a certain year.
% books_published_before(Year, Title, ActualYear)
books_published_before(Year, Title, ActualYear) :-
    book(Title, _, _, ActualYear, _),
    ActualYear < Year.

% Find authors of a specific genre.
% authors_in_genre(Genre, Author)
% We use findall/3 and sort/2 to get a unique, sorted list of authors.
authors_in_genre(Genre, UniqueAuthors) :-
    findall(Author, book(_, Author, Genre, _, _), Authors),
    sort(Authors, UniqueAuthors). % sort/2 also removes duplicates

% Find a book with more than a certain number of copies sold.
% bestseller(MinimumCopies, Title, Copies)
bestseller(MinimumCopies, Title, Copies) :-
    book(Title, _, _, _, Copies),
    Copies > MinimumCopies.

% Find all fantasy books published before 1950.
% classic_fantasy(Title, Year)
classic_fantasy(Title, Year) :-
    book(Title, _, fantasy, Year, _),
    Year < 1950.

% --- Example Queries ---
% ?- books_by_author('J.R.R. Tolkien', Title).
% Output: Title = 'The Hobbit' ;
%         Title = 'The Lord of the Rings'.
%
% ?- books_in_genre(dystopia, Title).
% Output: Title = '1984' ;
%         Title = 'Brave New World'.
%
% ?- books_published_after(1950, Title, Year).
% Output: Title = 'The Lord of the Rings', Year = 1954 ;
%         Title = 'To Kill a Mockingbird', Year = 1960 ;
%         ... (and so on)
%
% ?- authors_in_genre(scifi, Authors).
% Output: Authors = ['Frank Herbert', 'Isaac Asimov'].
%
% ?- bestseller(60000000, Title, Copies).
% Output: Title = 'The Hobbit', Copies = 100000000 ;
%         Title = 'The Lord of the Rings', Copies = 150000000.
%
% ?- classic_fantasy(Title, Year).
% Output: Title = 'The Hobbit', Year = 1937.
%
% ?- book(Title, Author, Genre, Year, CopiesSold), Author = 'George Orwell'.
% Output: Title = '1984', Author = 'George Orwell', Genre = dystopia, Year = 1949, CopiesSold = 50000000.
