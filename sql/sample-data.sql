-- A sample questionnaire

INSERT INTO questionnaire
    VALUES ( 1, 'Sample Questionnaire', 1 );

INSERT INTO question
    VALUES ( 1, 'What is your age?', 'text' );
INSERT INTO questionnaire_questions
    VALUES ( 1, 1, 2 );  -- deliberately out of order
 
INSERT INTO question
    VALUES ( 2, 'What is your name?', 'text' );
INSERT INTO questionnaire_questions
    VALUES ( 1, 2, 1 );  -- deliberately out of order

INSERT INTO question
    VALUES ( 3, 'What is your favourite colour?', 'single_option' );
INSERT INTO questionnaire_questions
    VALUES ( 1, 3, 3 );
INSERT INTO option
    VALUES ( 1, 3, 'Red', 1 );
INSERT INTO option
    VALUES ( 2, 3, 'Blue', 2 );
INSERT INTO option
    VALUES ( 3, 3, 'Green', 4 );
INSERT INTO option
    VALUES ( 4, 3, 'Yellow', 3 );

INSERT INTO question
    VALUES ( 4, 'Do you own any pets?', 'multi_option' );
INSERT INTO questionnaire_questions
    VALUES ( 1, 4, 4 );
INSERT INTO option
    VALUES ( 5, 4, 'Dog', 1 );
INSERT INTO option
    VALUES ( 6, 4, 'Cat', 2 );
INSERT INTO option
    VALUES ( 7, 4, 'Fish', 3 );
INSERT INTO option
    VALUES ( 8, 4, 'Other', 4 );
