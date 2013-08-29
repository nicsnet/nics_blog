Feature: As a visitor I want to sign up,
         as a registered user I want to sign in

Scenario: User signs up by filling out the registration form with valid credentials
  Given I do not exist as a user
  When I sign up with valid user data
  Then I should be on the articles page

Scenario: User signs up without password confirmation
  When I sign up without a password confirmation
  Then I should see a missing password confirmation message

Scenario: User signs up without a password
  When I sign up without a password
  Then I should see a password can't be blank message

Scenario: A registered user can sign in
  When I sign in with valid credentials
  Then I should be on the articles page
