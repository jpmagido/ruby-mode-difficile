- Visitors can login with their Github account to access the login namespace

ROUTES:
- namespace: `login`
- `login_user_path`

- `new_session_path`
- `edit_session_path`
- `sessions_path #POST`
- `session_path #DELETE`

OBJECTS:
- `Login::UsersController`
- `Session`
- `User`
- `Github::Oauth`
- `Github::Sync::User`
- `Github::Sync::Session`
- `Github::Sync::UserSession`
- `LinkedinSessionsController`
