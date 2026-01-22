require './spec/rails_helper'

RSpec.describe Project, type: :model do

  let(:project) {Project.create(name: "Hello RUby")}

  describe "status enum" do
    it do
      should define_enum_for(:status).
      with_values(pending:0, in_progress:1, completed:2).backed_by_column_of_type(:integer)
    end
  end

  describe "associations" do
    it "must belong to the manager" do
      should belong_to(:manager)
    end

    it "must have many tasks" do
      should have_many(:tasks)
    end

    it "returns an empty collection when no associated tasks are present" do
      expect(project.tasks).to be_empty
    end

    it "checks for the associated tasks to be present" do
      task1 = project.tasks.new(name: "task1")
      task2 = project.tasks.new(name: "task2")

      expect(project.tasks).to be_present
    end
  end


end