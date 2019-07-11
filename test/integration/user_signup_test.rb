require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  def setup
    
  end

  test "user can sign up" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params:{ user:{username: "jeff seid", email: "jeffseid@example.com", password: "password", admin: false} }
      follow_redirect!                                
    end
    assert_template 'users/show'
    assert_match "jeff", response.body
  end
end