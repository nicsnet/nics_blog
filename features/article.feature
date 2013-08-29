Feature: CRUD Articles for users

Scenario: A not logged in user can read articles
  Given there is an article with the content "My Content"
  When I visit the blog
  Then I should see "My Content"


Scenario: A not logged in user cannot create an article
  Given I do not exist as a user
  When I visit the blog and fill in a new entry
  Then I should be on the sign in page
    And there should be 0 articles


Scenario: a logged in user can create, edit and delete articles
  When I sign in with valid credentials
    And I visit the blog and fill in a new entry
  Then I should be on the articles page
    And there should be 1 article
  When I edit the article with the content "edited"
  Then I should be on the article page
    And I should see "edited"
  When I delete the article
  Then there should be 0 articles
    And I should be on the articles page


