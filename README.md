# questionnaire

The purpose of this project is to provide a REST API through which users
can access questionnaires and answer the questions therein.

Each questionnaire consists of a series of 0 or more questions.

Each question has a question type, as follows:

- `text` - answered in freeform text
- `single_option` - answered by choosing a single option from a list
- `multi_option` - answered by choosing zero or more options from a list

The available questionnaires and user answers are stored in an SQLite
database. (A sample database is provided as `questionnaire.sqlite` in
the repository.)

## API Endpoints

### Get questionnaire metadata

### Get questions for a questionnaire

### Put answers for a questionnaire

### Post a new questionnaire (maybe based on an existing questionnaire)

