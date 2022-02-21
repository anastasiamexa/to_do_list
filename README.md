This is a REST API, made with Ruby on Rails, for managing a Todo list. 
It uses ActiveRecord for CRUD operations and JWT for authentication.

Described below are the functionalities we created:
POST /signup    Signup
POST /auth/login    Login
GET /auth/logout    Logout
GET /todos    List all todos
POST /todos    Create a new todo
GET /todos/:id    Get a todo
PUT /todos/:id    Update a todo
DELETE /todos/:id    Delete a todo and its items
GET /todos/:id/items    Get a todo item
PUT /todos/:id/items    Update a todo item
DELETE /todos/:id/items    Delete a todo item

We developed the 'main' branch locally (using an Ubuntu terminal) with SQlite3 as our database. 
Meanwhile, the 'heroku' branch has some needed changes (most notably using PostgreSQL instead of SQlite3) in order to be able to be deployed on heroku.

This was made as a university project, and meant for learning about RESTful API development. 
Group members:
https://github.com/anastasiamexa
https://github.com/NancyKomm
https://github.com/VasPasia

We closely followed this tutorial:
https://www.digitalocean.com/community/tutorials/build-a-restful-json-api-with-rails-5-part-one
https://www.digitalocean.com/community/tutorials/build-a-restful-json-api-with-rails-5-part-two
https://www.digitalocean.com/community/tutorials/build-a-restful-json-api-with-rails-5-part-three


Instructions
**For local deployment: **

Clone the repo (git clone git@github.com:anastasiamexa/to_do_list.git)
Run bundle install
Run rails db:migrate
Run rails s
