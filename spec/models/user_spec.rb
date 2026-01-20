require_relative '../rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should_not allow_value(123).for(:name)}
    it {should_not allow_value('John123').for(:name)}
    it {should_not allow_value('').for(:name)}
    it {should_not allow_value(nil).for(:name)}
    it {should_not validate_absence_of(:name)}
    it {should validate_presence_of (:name)}

    it {should_not allow_value('abc.com').for(:email)}
    it {should_not allow_value('abc.at.com').for(:email)}
    it {should_not allow_value('').for(:email)}
    it {should_not allow_value(nil).for(:email)}
    it {should_not validate_absence_of(:email)}
    it {should validate_presence_of (:email)}

    it {should_not allow_value('asfd12334').for(:password)}
    it {should_not allow_value('8374834').for(:password)}
    it {should_not allow_value('').for(:password)}
    it {should_not allow_value(nil).for(:password)}
    it {should_not validate_absence_of(:password)}
    it {should validate_presence_of (:password)}
  end
end