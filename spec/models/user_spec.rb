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
end
