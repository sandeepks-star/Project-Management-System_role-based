require './spec/rails_helper'

RSpec.describe Project, type: :model do

  let(:manager) {User.create!(name: "manager1", email: "manager1@gmail.com", password: "Test@1234", type: "Manager")}
  let(:developer) {User.create!(name: "developer1", email: "developer1@gmail.com", password: "Test@1234", type: "Developer")}
  let(:project) {manager.projects.create!(name: "Hello Ruby", start_date:"10/01/2026", end_date: "20/01/2026")}

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
      task1 = project.tasks.create!(name: "task1", description: "dsfasfds")
      task2 = project.tasks.create!(name: "task2", description: "dsfasfds")

      expect(project.tasks).to be_present
    end

    it "ensure that the associated tasks get deleted when the parent object is deleted" do
      task1 = project.tasks.create!(name: "task1", description: "dsfasfds")
      expect{project.destroy}.to change{Task.count}.by(-1)
    end

    it "have many attached avatars" do
      have_many_attached(:avatars)
    end

    it "returns an empty avatar collection when no avatar is set in project" do
      expect(project.avatars).to be_empty
    end

    it "ensures that a project may have many developers and vice-versa" do
      have_and_belong_to_many(:developers).class_name("User").with_foreign_key("project_id")
    end

    it "returns empty developers coolection when no developer is assigned to the project" do
      expect(project.developers).to be_empty
    end

    it "expects that the developers are assigned correctly to the project" do
      project.developers=[developer]
      expect(project.developers).to be_present
    end
  end

  describe "validations" do
    it "ensures that the project name is present" do
      expect(project.name).to be_present
    end

    it "ensures that the names of the project are unique" do
      project2 = Project.new(name: "Hello Ruby")
      expect(project2).not_to be_valid
    end

    context "when start_date is less than end_date" do
      before do
        project.start_date = "10/01/2026"
        project.end_date = "20/01/2026"
      end

      it "should pass the custom start_date and end_date validation" do
        project.save
        expect(project).to be_valid
      end
    end

    context "when start_date is greater than end_date" do
      before do
        project.start_date = "20/01/2026"
        project.end_date = "10/01/2026"
      end

      it "should pass the custom start_date and end_date validation" do
        project.save
        expect(project).not_to be_valid
      end
    end

    context "when start_date is equal to end_date" do
      before do
        project.start_date = "10/01/2026"
        project.end_date = "10/01/2026"
      end

      it "should pass the custom start_date and end_date validation" do
        project.save
        expect(project).to be_valid
      end
    end
  end

  context "when status of all tasks is completed and the projects status is being changed to completed" do
    before do
      project.tasks.create!(name: "task1", description: "dsfasfds", status: "completed")
      project.tasks.create!(name: "task1", description: "dsfasfds", status: "completed")
    end

    it "allows the project status to be completed" do
      project.status = "completed"
      expect(project).to be_valid
    end
  end

  context "when the status of some of the associated tasks is not completed" do
    before do
      project.tasks.create(name: "task1", description: "dsfasfds", status: "in_progress")
    end

    it "not allows the project status to be completed" do
      project.status = "completed"
      expect(project).not_to be_valid
    end
  end

  context "when there are not associated tasks of the project" do
    it "allows the project status to be completed" do
      project.status = "completed"
      expect(project).to be_valid
    end
  end
end
