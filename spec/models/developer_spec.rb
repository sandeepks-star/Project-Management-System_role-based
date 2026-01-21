require './spec/rails_helper'

RSpec.describe Developer, type: :model do
  describe "associations" do

    it {should have_and_belong_to_many(:projects).class_name('Project').join_table('projects_users').with_foreign_key('user_id')}

    it {should have_and_belong_to_many(:tasks).class_name('Task').join_table('tasks_users').with_foreign_key('user_id')}
  end
end