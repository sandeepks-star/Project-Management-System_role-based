require './spec/rails_helper'

RSpec.describe Task, type: :model do
  describe "enums" do
    it {should define_enum_for(:status).with_values([:pending, :in_progress, :completed])}
    it {should define_enum_for(:priority).with_values([:low, :medium, :high])}
  end

  describe "associations" do
    it {should belong_to(:project)}
    it {should have_and_belong_to_many(:developers).class_name("Developer").with_foreign_key("foreign_key").join_table("tasks_users")}
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
  end
end