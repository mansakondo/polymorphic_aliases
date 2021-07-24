# polymorphic_aliases
An ActiveRecord extension to use aliases for your polymorphic associations.

WARNING: This gem is purely experimental (for now), so do don't use it in production.
## Usage
Your model code:
```ruby    
# app/models/comment.rb    
class Comment < ApplicationRecord    
  belongs_to :commentable, polymorphic: true, types: %w( Post Picture )    
end    
    
# app/models/post.rb    
class Post < ApplicationRecord    
  has_many :comments, as: :commentable    
end    
    
# app/models/picture.rb    
class Picture < ApplicationRecord    
  has_many :comments, as: :commentable    
end
```
In the console:
```ruby
post    = Post.new(title: "Polymorphic Aliases", content: "...")
picture = Picture.new(legend: "Here's my code.", url: "https://avatars.githubusercontent.com/u/47113995?v=4")

comment_from_post    = Comment.new(content: "...", commentable: post)
comment_from_picture = Comment.new(content: "...", commentable: picture)

comment_from_post.post.title
# => "Polymorphic Aliases"

comment_from_picture.picture.legend
# => "Here's my code."

comment_from_post.picture
# => undefined method `picture'

comment_from_picture.post
# => undefined method `post'
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'polymorphic_aliases'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install polymorphic_aliases
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
