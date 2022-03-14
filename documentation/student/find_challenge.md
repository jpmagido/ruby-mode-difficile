- Users can search for Challenges
- Challenges must be `status: :ready`

- Search by: `title`, `duration`, `difficulty`, `creator`

ROUTES:

- namespace: `login`
- `login_challenges_path`
- `login_challenge_path`

OBJECTS:

- `Login::ChallengesController`
- `Challenge`
- `Search::Challenge` (TODO)
