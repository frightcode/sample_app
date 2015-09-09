require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:daiver)
  end

  test "unsuccessfull edit" do
    login_as_user(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: '',
      email: 'chachacha',
      password: 'foo',
      password_confirmation: 'bar'
    }
    assert_template 'users/edit'
  end

  test "successful edit" do
    login_as_user(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "foofoo"
    email = "foo@dar.com"
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
