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

Run script/my_app_server.pl to test the application.

## API Endpoints

All responses are JSON. All POST bodies are JSON unless otherwise noted.

### GET /api/questionnaire

Gets a list of existing published questionnaires.

JSON response:

    {
        "status": "ok",
        "result": {
            "count": 2,
            "list": [
                {
                    "id": 1,
                    "title": "Questionnaire One"
                },
                {
                    "id": 2,
                    "title": "Questionnaire Two"
                }
            ]
        }
    }

### GET /api/questionnaire/{id}

Gets the questions and other metadata for a questionnaire.

JSON response:

    {
        "status": "ok",
        "result": {
            "id": 1,
            "title": "Questionnaire One",
            "is_published": true,
            "questions": [
                {
                    "id": 1,
                    "question_type": "text",
                    "question_text": "What is your name?"
                },
                {
                    "id": 2,
                    "question_type": "single_option",
                    "question_text": "What is your favourite colour?",
                    "options": [
                        { "id": 1, "option_text": "Red" },
                        { "id": 2, "option_text": "Blue" },
                        { "id": 3, "option_text": "Yellow" },
                        { "id": 4, "option_text": "Green" }
                    ]
                },
                {
                    "id": 3,
                    "question_type": "multi_option",
                    "question_text": "Do you have a pet?",
                    "options": [
                        { "id": 5, "option_text": "Dog" },
                        { "id": 6, "option_text": "Cat" },
                        { "id": 7, "option_text": "Rabbit" },
                        { "id": 8, "option_text": "Other" }
                    ]
                }
            ]
        }
    }

The structure within the `result` is a question object and is used in various
other places in this API.

### POST /api/questionnaire

Adds a new questionnaire.

POST a question object as JSON (without any `id` keys, as these will be
provided by the database).

The JSON response will include `id` keys:

    {
        "status": "ok",
        "result": {
            "id": 2,
            /* ... question object ... */
        }
    }

### POST /api/questionnaire/{id}

Saves a questionnaire response. Only published questionnaires accept responses.

**PARTIALLY IMPLEMENTED**

POST the following JSON:

    {
        "user_id": 123,
        "answers": {
            "1": "Toby",
            "2": 4,
            "3": [6, 8]
        },
    }

The above represents the following answers to the questionnaire shown earlier.

* What is your name? _Toby_.
* What is your favourite colour? _Green_.
* Do you have a pet? _Cat_, _Other_.

Text answers are posted as plain text. Single options are posted as the numeric
ID. Multi options are posted as an array of numeric IDs. (Multi options are
always an array, even if only one option is selected.)

### GET /api/questionnaire/{id}/answer

Get a list of responses to a questionnaire.

**NOT IMPLEMENTED**

### GET /api/questionnaire/{id}/answer/{answer_id}

Get a response to a questionnaire.

**NOT IMPLEMENTED**

### POST /api/questionnaire/{id}/status

Publish or unpublish the questionnaire.

**NOT IMPLEMENTED**

