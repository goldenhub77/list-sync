class MainPolicy < ApplicationPolicy

  class ListScope < Scope
    def resolve
      if user.admin?
        super.all
      else
        user.list_collaborations
      end
    end
  end

  class UserScope < Scope
    def resolve
      if user.admin?
        super.all
      else
        puts "main_policy.rb NEEDS TO BE REFACTORED WHEN FRIENDS ARE IMPLEMENTED"
        super.all
        #friends not implemented yet
        # user.friends
      end
    end
  end

  def autocomplete?

  end

  def search?

  end

end
