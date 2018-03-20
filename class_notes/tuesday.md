# Tuesday Notes

## Migrations

**Initial Setup**
1. Create the database (once per project)
    ```
    $ rails db:create
    ```

**Create a Model**
1. Generate the model
    ```
    $ rails generate model book title:string author:string
    ```

1. Run migrations
    ```
    $ rails db:migrate
    ```

1. Check the results in `db/schema.rb`

**Modify a Model**
1. Create another migration
    ```
    $ rails generate migration add_description_to_books
    ```

1. Edit the migration, add the `add_column` method
    ```ruby
    class AddDescriptionToBooks < ActiveRecord::Migration[5.1]
      def change
        add_column :books, :description, :string
      end
    end
    ```

1. Migrate again
    ```
    $ rails db:migrate
    ```

## Working with Models

1. Create 3 different books. What are their IDs?
    ```ruby
    Book.create(title: "Parable of the Sower", author: "Octavia Butler")
    ```

1. Get all the books written by a certain author
    ```ruby
    book_list = Book.where(author: "Ursula K Le Guin")
    ```

1. Get the last book created
    ```ruby
    Book.last
    ```

1. Find book 2
    ```ruby
    Book.find(2)
    ```

1. Change book 3 to have a different author
    ```ruby
    book = Book.find(3)
    book.author = "someone else"
    book.save

    # or
    book.update(author: "someone else")
    ```

1. Destroy the first book
    ```ruby
    Book.first.destroy
    ```

1. Create another book. What is the ID?

## Random Setup Stuff

How to get someone else's Rails project up and running
    ```
    $ git clone <URL>
    $ cd <folder>
    $ bundle install     # Install gems
    $ rails db:create    # Create the DB
    $ rails db:migrate   # Run all migrations
    $ rails server       # Start the server
    ```

How to delete your controller
    $ rails delete controller task
    $ rails generate controller tasks
