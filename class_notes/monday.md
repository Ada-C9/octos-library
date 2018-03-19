# Class Notes from Monday

1. Initial setup

    ```
    $ rails new octos-library
    $ cd octos-library
    $ git add .
    $ git commit -m "Run rails new"
    ```

1. Set up the controller

    ```
    $ rails generate controller books
    ```

1. Add a route to `config/routes.rb`

    ```ruby
    get '/books', to: 'books#index'
    ```

1. Define a method that matches the controller action in app/controllers/books_controller.rb
    ```ruby
    def index
    end
    ```

1. Create a view template in app/views/books/index.html.erb
    - The extension will always be .html.erb
        - Can have just HTML, also takes ERB syntax (covered this afternoon)
    - The name matches our controller action

1. Add some HTML to the view

1. Start the server
    ```
    $ rails server
    ```

1. Point your browser to the URL you specified in your route
    ```
    localhost:3000/books
    ```
