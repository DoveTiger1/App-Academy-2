PRAGMA foreign_keys = ON;

CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    author_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    parent_id INTEGER,
    author_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    author_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('Ned', 'Stark'),
    ('Bran', 'Stark'),
    ('Jaime', 'Lannister'),
    ('Cersei', 'Lannister'),
    ('Three-Eyed', 'Crow'),
    ('Petyr', 'Baelish'),
    ('Varys', 'The Spider')
    ;

INSERT INTO 
    questions (title, body, author_id)
VALUES
    ("How can i get the lannisters off my back?", "all in the title",
    (SELECT id FROM users WHERE fname = 'Ned')),

    ("How can i walk again?", "im in a wheelchair lolz",
    (SELECT id FROM users WHERE fname = 'Bran')),

    ("Is incest really that bad?", "i love my sister guys please answer",
    (SELECT id FROM users WHERE fname = 'Jaime'))
    ;


INSERT INTO
    question_likes (author_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Cersei'),
    (SELECT id FROM questions WHERE title = "Is incest really that bad?")),

    ((SELECT id FROM users WHERE fname = 'Three-Eyed'),
    (SELECT id FROM questions WHERE title = "How can i walk again?")),

    ((SELECT id FROM users WHERE fname = 'Petyr'),
    (SELECT id FROM questions WHERE title = "How can i get the lannisters off my back?")),

    ((SELECT id FROM users WHERE fname = 'Varys'),
    (SELECT id FROM questions WHERE title = "How can i get the lannisters off my back?"))
;

INSERT INTO
    question_follows (author_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Cersei'),
    (SELECT id FROM questions WHERE title = "Is incest really that bad?")),

    ((SELECT id FROM users WHERE fname = 'Varys'),
    (SELECT id FROM questions WHERE title = "How can i get the lannisters off my back?"))
;

INSERT INTO
    replies (body, author_id, question_id)
VALUES
    ("i can help, definitely not a traitor, trust me lol",
    (SELECT id FROM users WHERE fname = 'Petyr'),
    (SELECT id FROM questions WHERE title = "How can i get the lannisters off my back?")),

    ("you wont walk again kid, but i can teach you how to fly, and yes, it does involve drugs",
    (SELECT id FROM users WHERE fname = 'Three-Eyed'),
    (SELECT id FROM questions WHERE title = "How can i walk again?"))
;

INSERT INTO
    replies (body, parent_id, author_id, question_id)
VALUES
    ("dont trust him ned! hes a weirdo",
    (SELECT id FROM replies WHERE body = "i can help, definitely not a traitor, trust me lol"),
    (SELECT id FROM users WHERE fname = 'Varys'),
    (SELECT id FROM questions WHERE title = "How can i get the lannisters off my back?"))
;