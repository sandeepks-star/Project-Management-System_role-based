require './spec/rails_helper'

RSpec.describe Task, type: :model do
  describe "status and priority enums" do
    it do
      should define_enum_for(:status).with_values(pending:0, in_progress:1, completed:2).backed_by_column_of_type(:integer)

      should define_enum_for(:priority).with_values(low:0, medium:1, high:2).backed_by_column_of_type(:integer)
    end


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