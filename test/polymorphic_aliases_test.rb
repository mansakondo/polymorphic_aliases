require "test_helper"

class PolymorphicAliasesTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert PolymorphicAliases::VERSION
  end

  test "should generate the proper aliases" do
    post    = Post.new(title: "Polymorphic Aliases", content: "...")
    picture = Picture.new(legend: "Here's my code.", url: "https://avatars.githubusercontent.com/u/47113995?v=4")

    first_comment  = Comment.new(content: "...", commentable: post)
    second_comment = Comment.new(content: "...", commentable: picture)

    assert_equal "Polymorphic Aliases", first_comment.post.title
    assert_equal "Here's my code.", second_comment.picture.legend

    assert_nil first_comment.reload_post
    assert_nil second_comment.reload_picture

    assert_raises { first_comment.legend }
    assert_raises { second_comment.post }
  end
end
