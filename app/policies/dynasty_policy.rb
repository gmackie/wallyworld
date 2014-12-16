class DynastyPolicy
  attr_reader :current_user, :dynasty

  def initialize(current_user, dynasty)
    @current_user = current_user
    @dynasty = dynasty
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? or @current_user == @dynasty.user
  end

  def update?
    @current_user.admin? or @current_user == @dynasty.user
  end

  def destroy?
    @current_user.admin? or @current_user == @dynasty.user
  end

end

