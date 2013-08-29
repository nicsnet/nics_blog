Feature: Static pages

  Scenario: Display static pages
    When I visit the home page
    Then I should see "Welcome to the little foxes blog"
    When I follow "About"
    Then I should see "About Us"
    When I follow "Contact"
    Then I should see "Contact"
