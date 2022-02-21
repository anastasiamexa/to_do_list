# Todo list

This is a REST API, made with Ruby on Rails, for managing a Todo list. <br />
It uses ActiveRecord for CRUD operations and JWT for authentication.

Described below are the functionalities we created: <br />
**POST /signup    Signup <br />
POST /auth/login    Login <br />
GET /auth/logout    Logout <br />
GET /todos    List all todos <br />
POST /todos    Create a new todo <br />
GET /todos/:id    Get a todo <br />
PUT /todos/:id    Update a todo <br />
DELETE /todos/:id    Delete a todo and its items <br />
GET /todos/:id/items    Get a todo item <br />
PUT /todos/:id/items    Update a todo item <br />
DELETE /todos/:id/items    Delete a todo item <br />**

We developed the 'main' branch locally (using an Ubuntu terminal) with SQlite3 as our database. <br />
Meanwhile, the 'heroku' branch has some needed changes (most notably using PostgreSQL instead of SQlite3) in order to be able to be deployed on heroku. <br />

This was made as a university project, and meant for learning about RESTful API development.  <br />
Group members: <br />
https://github.com/anastasiamexa <br />
https://github.com/NancyKomm <br />
https://github.com/VasPasia <br />

We closely followed this tutorial: <br />
https://www.digitalocean.com/community/tutorials/build-a-restful-json-api-with-rails-5-part-one <br />
https://www.digitalocean.com/community/tutorials/build-a-restful-json-api-with-rails-5-part-two <br />
https://www.digitalocean.com/community/tutorials/build-a-restful-json-api-with-rails-5-part-three <br />


###### Instructions

For local deployment:

Clone the repo (git clone git@github.com:anastasiamexa/to_do_list.git) <br />
Run bundle install <br />
Run rails db:migrate <br />
Run rails s <br />
