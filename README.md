# polymorphic_aliases
An ActiveRecord extension to use aliases for your polymorphic associations.

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
post    = Post.create(title: "Polymorphic Aliases", content: "...")
picture = Picture.create(legend: "Here's my code.", url: "https://avatars.githubusercontent.com/u/47113995?v=4")

comment_from_post    = Comment.create(content: "...", commentable: post)
comment_from_picture = Comment.create(content: "...", commentable: picture)

comment_from_post.post.title
# => "Polymorphic Aliases"

comment_from_picture.picture.legend
# => "Here's my code."

comment_from_post.picture
# => nil

comment_from_picture.post
# => nil
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "polymorphic_aliases"
```

Or if you want to target the `main` branch:

```ruby
gem "polymorphic_aliases", github: "mansakondo/polymorphic_aliases"
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
