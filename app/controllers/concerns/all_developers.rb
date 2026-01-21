module AllDevelopers
  extend ActiveSupport::Concern

  included do
    before_action :show_all_developers, only: [ :new, :create, :edit, :update ]
  end

  def show_all_developers
    @developers = Developer.all
  end
end
