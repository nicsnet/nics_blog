require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  it { should respond_to(:email) }
  it { should respond_to(:login) }
  it { should respond_to(:firstname) }
  it { should respond_to(:lastname) }
  it { should respond_to(:avatar) }

  it { should be_valid }
  it { should_not be_admin }

  describe "when email is not present" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with admin attribute set to 'true'" do

    before do
      user.save!
      user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "article associations" do

    before { user.save }

    let!(:older_article) do
      FactoryGirl.create :article, user: user, created_at: 1.day.ago
    end
    let!(:newer_article) do
      FactoryGirl.create(:article, user: user, created_at: 1.hour.ago)
    end

    it "should destroy associated articles" do
      articles = user.articles.to_a
      user.destroy
      expect(articles).not_to be_empty

      articles.each do |article|
        expect(Article.where(id: article.id)).to be_empty
      end
    end
  end
end
