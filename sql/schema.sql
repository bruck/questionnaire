/*
 Questionnaires and their questions are write-once/read-many. This is
 done so that answers can be stored always referring to the original
 questionnaires.
 */

/*
 Once a questionnaire has been published, its row in the questionnaire
 table and all its rows in questionnaire_questions should not be modified.
 If you want to edit an existing, published questionnaire, start by
 cloning a new one with all the same questions.
 */

DROP TABLE IF EXISTS questionnaire;
CREATE TABLE questionnaire
(
    questionnaire_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title            TEXT    NOT NULL DEFAULT '',
    is_published     INTEGER NOT NULL DEFAULT 0 -- boolean
);

DROP TABLE IF EXISTS questionnaire_questions;
CREATE TABLE questionnaire_questions
(
    questionnaire_id INTEGER NOT NULL,
    question_id      INTEGER NOT NULL,
    rank             INTEGER NOT NULL,
    PRIMARY KEY (questionnaire_id, question_id),
    UNIQUE (questionnaire_id, rank),
    FOREIGN KEY (questionnaire_id) REFERENCES questionnaire (questionnaire_id),
    FOREIGN KEY (question_id) REFERENCES question (question_id)
);

/*
 Once a question has been included in a published questionnaire, its row
 in the question table and all corresponding rows in the option table
 should not be modified. If you want to edit a question or its options,
 start by cloning a new one with all the same options.
 */

DROP TABLE IF EXISTS question;
CREATE TABLE question
(
    question_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    question_text TEXT,
    question_type TEXT CHECK ( question_type IN ('text', 'single_option', 'multi_option') )
);

DROP TABLE IF EXISTS option;
CREATE TABLE option
(
    option_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    question_id INTEGER,
    option_text TEXT,
    option_rank INTEGER NOT NULL,
    UNIQUE (question_id, option_rank),
    FOREIGN KEY (question_id) REFERENCES question (question_id)
);


DROP TABLE IF EXISTS questionnaire_answer;
CREATE TABLE questionnaire_answer
(
    questionnaire_answer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id                 TEXT,
    questionnaire_id        INTEGER,
    answered_at             TEXT DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS question_answer;
CREATE TABLE question_answer
(
    question_answer_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    questionnaire_answer_id INTEGER,
    question_id             INTEGER,
    answer_text             TEXT
);

DROP TABLE IF EXISTS question_answer_option;
CREATE TABLE question_answer_option
(
    question_answer_id INTEGER,
    option_id          INTEGER
);
