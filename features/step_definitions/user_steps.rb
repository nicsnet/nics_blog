
def create_user
  @user = FactoryGirl.create(:user)
end

def create_visitor
  @visitor ||= { login: "logmein", firstname: "Testy",
                 lastname: "McUserton", email: "example@example.com",
                 password: "test1234", password_confirmation: "test1234"}
end

def sign_up(path = "/users/sign_up")
  delete_user
  visit path
  fill_in "user_email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  find("#user_password_confirmation").visible?
  fill_in "user_password_confirmation", with: @visitor[:password_confirmation]
  click_button "Sign up"
end

def sign_in
  create_user
  visit '/users/sign_in'
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  click_button "Sign in"
end

def delete_user
  @user ||= User.where(email: @visitor[:email]).first
  @user.destroy unless @user.nil?
end

### GIVEN ###

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I log out$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

### WHEN ###

When /^I sign in with valid credentials$/ do
  sign_in
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I register with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(email: "notanemail")
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(email: "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(password_confirmation:  "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(password: "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(password_confirmation: "please123")
  sign_up
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(email: "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(password: "wrongpass")
  sign_in
end

### THEN ###

Then /^I should see a missing password confirmation message$/ do
  page.should have_css('#error_explanation')
  page.should have_content "Password confirmation doesn't match Password"
end

Then /^I should see a mismatched password message$/ do
  page.should have_css('#error_explanation')
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a password can't be blank message$/ do
  page.should have_css('#error_explanation')
  page.should have_content "Password can't be blank"
end
