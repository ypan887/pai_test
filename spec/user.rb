
class User
  include Capybara::DSL

  def initialize
    timestamp = Time.now.to_i
    @user = { first_name: 'user1',
              last_name: 'in_test',
              email: "user#{timestamp}@example.com",
              password: "password" }
  end

  def register
    visit "/users/sign_up"
    within("form#new_user") do
      fill_in 'user[first_name]', with: @user[:first_name]
      fill_in 'user[last_name]', with: @user[:last_name]
      fill_in 'user[email]', with: @user[:email]
      fill_in 'phone1', with: 415
      fill_in 'phone2', with: 555
      fill_in 'phone3', with: 1234
      fill_in 'user[password]', with: @user[:password]
      fill_in 'user[password_confirmation]', with: @user[:password]
    end
    click_button("Start Analyzing »")
  end

  def signin
    visit "/users/sign_in"
    within("form#new_user") do
      fill_in 'user[email]', with: @user[:email]
      fill_in 'user[password]', with: @user[:password]
    end
    click_button 'Sign in'
  end
end