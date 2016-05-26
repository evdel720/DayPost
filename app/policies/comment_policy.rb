class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    !user.nil?
  end

  def update?
    user && user == record.author
  end

  def destroy?
    user && user == record.author || (!user.nil? && user.admin?)
  end
end
