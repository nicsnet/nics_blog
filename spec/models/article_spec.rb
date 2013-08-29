require 'spec_helper'

describe Article do

  let(:user) { FactoryGirl.create(:user) }
  let(:article) do
    article = user.articles.build(content: 'my content')
  end

  subject { article }

  it { should respond_to(:content) }
  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  its(:user) { should eq user }

  describe "when user_id is not present" do
    before { article.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { article.content = " " }

    it { should_not be_valid }
  end
end
