When /^I visit the home page$/ do
  visit root_path
end

When /^I follow "([^*"]*)"$/ do |link|
  click_link(link)
end
