class Genre < ApplicationRecord
  has_and_belongs_to_many :books

  # validation on name
end
