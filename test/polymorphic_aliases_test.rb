require "test_helper"

class PolymorphicAliasesTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert PolymorphicAliases::VERSION
  end

  setup do
    post    = Post.new(title: "Polymorphic Aliases", content: "...")
    picture = Picture.new(legend: "Here's my code.", url: "https://avatars.githubusercontent.com/u/47113995?v=4")

    @comment_from_post    = Comment.new(content: "...", commentable: post)
    @comment_from_picture = Comment.new(content: "...", commentable: picture)
  end

  test "should generate the proper aliases" do
    assert_equal "Polymorphic Aliases", @comment_from_post.post.title
    assert_equal "Here's my code.", @comment_from_picture.picture.legend

    assert_nil @comment_from_post.reload_post
    assert_nil @comment_from_picture.reload_picture

    assert_raises { @comment_from_post.picture }
    assert_raises { @comment_from_picture.post }
  end
end
