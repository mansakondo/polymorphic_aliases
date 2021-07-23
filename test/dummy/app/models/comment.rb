class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, types: %w( Post Picture )
end
