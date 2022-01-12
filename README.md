# Ruby Mode difficile

Stack:  
- `ruby 3.0.0`
- `rails 7.0.0`
- `postgres`
- `puma`
- `rspec`
- `erb`

Initialization:  
- `bundle install`
- `rails db:create db:migrate db:seed`

Database:
- `config/database.yml`
- You need to create a user named `rmd_postgres` on your psql
- Create psql user: https://www.postgresql.org/docs/8.0/sql-createuser.html
- Update psql user permissions: https://docs.postgresql.fr/10/sql-alteruser.html

Specs:  
- `rspec`

Deployment:  
- https://www.heroku.com/


Variable dependencies:  
- `.env`
- Ask an admin for the project's credentials needed to run the app


---------


# __TO READ:__


# This project's goal is to spread Ruby and Rails knowledge to the new & not so new Rubyists

As we care about our app, we have requirements about the code we push in production:

- Workflow
  - Pick a card in the Project board as agreed with an admin
  - Create a new branch from `main` with your name: `ahmed-my-feature`
  - Use the _Pull Request system_
  - Ask for review
  - Never try to push the code yourself to another branch than yours

- Practices
  - You need to test your code with `Rspec`: 
    - `Request`, `Models`, `Services`, `Workers`
    - _Unit_ & _Integration_ test
    - _End to end_ test with `Capybara`
  - Stick to **REST** when possible
  - Make your code **EXPLICIT**, it's meant to be **read** not **written** !
  - Don't add dependencies (gems) if you can do it yourself
