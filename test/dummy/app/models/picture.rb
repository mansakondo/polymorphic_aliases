class Picture < ApplicationRecord
  has_many :comments, as: :commentable
end
