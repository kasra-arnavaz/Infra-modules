USE library;

CREATE TABLE IF NOT EXISTS books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    avg_rating DECIMAL(4,2),
    num_rating INT,
    UNIQUE(book, author)
);

INSERT IGNORE INTO books (book, author, avg_rating, num_rating)
VALUES 
    ('Animal Farm', 'George Orwell', 9.5, 200),
    ('Of Mice and Men', 'John Steinbeck', 9.0, 150),
    ('The Old Man and the Sea', 'Ernest Hemingway', 8.7, 180);