# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

raw_authors = [
  {
    name: "Sandi Metz",
    books: [
      {
        title: "POODR",
        publication_year: 2012,
      },
      {
        title: "99 Bottles of OOP",
        publication_year: 1998
      }
    ]
  },
  {
    name: "Roxane Gay",
    books: [
      {
        title: "Bad Feminist"
      }
    ]
  }
]

raw_authors.each do |raw_author|
  author = Author.create(name: raw_author[:name])
  puts "Created author #{author.name}"
  raw_author[:books].each do |raw_book|
    book = author.books.create(raw_book)
    puts "Created book #{book.title}"
  end
end

# sm = Author.create(name: "Sandi Metz")
# rg = Author.create(name: "Roxane Gay")
#
# sm.books.create(title: "POODR")
