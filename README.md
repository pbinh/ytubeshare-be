# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation:
    - Grant process permission for sh: chmod +x setup_db_local.sh
    - For the new database and new docker image & container:
        ./setup_db_local.sh create_new
    - For the existing one:
        ./setup_db_local.sh start

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* Entity generation:
    rails generate model User username:string email:string password:string
    rails generate model Video title:string url:string description:string metadata:string  user:references
    rails generate model Notification user:references title:string message:string metadata:string
    rails db:migrate

* NOTES:
    - It occured a very strange case that need to install mysql on development machine to bundle install successfully <= will keep eye on this problem on production built later.