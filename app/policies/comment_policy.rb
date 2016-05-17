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
    user == record.author
  end

  def destroy?
    user == record.author || (!user.nil? && user.admin?)
  end
end
