- Users can answer a Challenge using a Github Repo
- Created Answer must be `status: :pending`

ROUTES:

- namespace: `login`
- `login_challenge_answer_path`
- `new_login_challenge_answer_path`
- `login_challenge_answer_path #POST`

OBJECTS:

- `Login::AnswersController`
- `Answer`
- `Repository`
- `Challenge`
- `Github::Sync::Repository`
