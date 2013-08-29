def create_article
  fill_in 'article_title', with: 'title'
  fill_in 'article_content', with: 'My content ...'
  click_button "Save"
end

### WHEN ###

When /^I visit the blog$/ do
  visit articles_path
end

When /^I visit the blog and fill in a new entry$/ do
  step %{I visit the blog}
  click_link 'new entry'
  create_article
end

When /^I edit the article with the content "([^"]*)"$/ do |text|
  article = Article.last
  visit edit_article_path(article)
  fill_in 'article_content', with: text
  click_button "Save"
end

When /^I delete the article$/ do
  click_link 'delete'
end

## THEN ##

Then /^I should see a new article link$/ do
  page.should have_content('new entry')
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should be on the sign in page$/ do
  current_path.should eq("/users/sign_in")
end

Then /^there should be (\d+) article(?:s)?$/ do |count|
  Article.count.should == count.to_i
end

Then /^I should be on the articles page$/ do
  current_path.should eq("/articles")
end

Then /^I should be on the article page$/ do
  id = Article.last.id
  current_path.should eq("/articles/#{id}")
end
