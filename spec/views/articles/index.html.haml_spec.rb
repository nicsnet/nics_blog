require 'spec_helper'

describe "articles/index" do
  let(:article) { FactoryGirl.create(:article)}
  let(:other_article) { FactoryGirl.create(:article)}

  it "renders a list of articles" do
    render
    rendered.should contain(article.title)
    rendered.should contain(article.content)
  end
end
