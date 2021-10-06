/*
 Questionnaires and their questions are write-once/read-many. This is
 done so that answers can be stored always referring to the original
 questionnaires.
 */

/*
 Once a questionnaire has been published, its row in the questionnaire
 table and all its rows in questionnaire_question should not be modified.
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

DROP TABLE IF EXISTS questionnaire_question;
CREATE TABLE questionnaire_question
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

/*
 A user may fill out the same questionnaire multiple times, each producing
 a unique row in the questionnaire_answer table.
 */
DROP TABLE IF EXISTS questionnaire_answer;
CREATE TABLE questionnaire_answer
(
    questionnaire_answer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id                 TEXT    NOT NULL,
    questionnaire_id        INTEGER NOT NULL,
    answered_at             TEXT    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (questionnaire_id) REFERENCES questionnaire (questionnaire_id)
);

/*
 Each answer a user provides to a question corresponds to a row in the
 question_answer table. Each answered question may contain an answer_text
 (for 'text' question types) or a list of selected options in the
 question_answer_option table (for 'single_option' and 'multi_option'
 question types).
 */
DROP TABLE IF EXISTS question_answer;
CREATE TABLE question_answer
(
    question_answer_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    questionnaire_answer_id INTEGER NOT NULL,
    question_id             INTEGER NOT NULL,
    answer_text             TEXT,
    UNIQUE (questionnaire_answer_id, question_id),
    FOREIGN KEY (questionnaire_answer_id) REFERENCES questionnaire_answer (questionnaire_answer_id),
    FOREIGN KEY (question_id) REFERENCES question (question_id)
);

DROP TABLE IF EXISTS question_answer_option;
CREATE TABLE question_answer_option
(
    question_answer_id INTEGER NOT NULL,
    option_id          INTEGER NOT NULL,
    PRIMARY KEY (question_answer_id, option_id),
    FOREIGN KEY (question_answer_id) REFERENCES question_answer (question_answer_id),
    FOREIGN KEY (option_id) REFERENCES option (option_id)
);
