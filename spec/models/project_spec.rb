require './spec/rails_helper'

RSpec.describe Project, type: :model do

  describe "status enum" do
    it "defines the correct integer mapping for statuses" do
      expect(Project.statuses[:pending]).to eql(0)
      expect(Project.statuses[:in_progress]).to eql(1)
      expect(Project.statuses[:completed]).to eql(2)
    end

    it "allows setting and reading the status using symbols" do
      project = Project.new(status: :pending)
      expect(project.status).to eq("pending")
      expect(project[:status]).to eq("pending")
    end
  end


  describe "associations" do
   it {should belong_to(:manager)}

  end
end