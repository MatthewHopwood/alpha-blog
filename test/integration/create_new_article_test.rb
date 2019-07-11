require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "John", email: "john@example.com", password: "password", admin: false)
  end

  test "get new article form and create article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params:{ article:{title: "Example Article", description: "Example Description"}}
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match "Article was successfully created", response.body
  end

  test "invalid article submission results in failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: { article:{ title: " ", description: " "}}
    end
    assert_template 'articles/new'
    assert_match "prohibited this article from being saved", response.body
  end
end