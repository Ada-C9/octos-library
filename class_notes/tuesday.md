Create the database (once per project)
    $ rails db:create

Generate the model (once per table)
    $ rails generate model book title:string author:string

Run migrations
    $ rails db:migrate

Realize we need another column
Create another migration
    $ rails generate migration add_description_to_books

Edit the migration, add the `add_column` method call

Migrate again
    $ rails db:migrate



How to get someone else's Rails project up and running
    $ git clone <URL>
    $ cd <folder>
    $ bundle install     # Install gems
    $ rails db:create    # Create the DB
    $ rails db:migrate   # Run all migrations
    $ rails server       # Start the server

How to delete your controller
    $ rails delete controller task
    $ rails generate controller tasks
