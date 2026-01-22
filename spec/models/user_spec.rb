require './spec/rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do

    it {should have_secure_password}

    it {should allow_values("Manager", "Developer").for(:type)}
    it {should validate_presence_of (:name)}

    it {should_not allow_value('abc.com').for(:email)}
    it {should_not allow_value('abc.at.com').for(:email)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}

    it {should_not allow_value('asfd12334').for(:password)}
    it {should_not allow_value('8374834').for(:password)}
    it {should allow_value('Test@1234').for(:password)}
    it {should validate_presence_of(:password).on(:create)}
  end
end