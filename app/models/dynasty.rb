class Dynasty < ActiveRecord::Base
  belongs_to :user
  has_many :games
  has_many :rankings
  has_many :teams
  has_many :players
  has_many :prospects

  def user_teams
    return self.teams.where.not(:user_id => nil)
  end
  
  def users
    user_teams.map do |team|
      User.find_by_id(team.user_id) unless team.user_id.nil?
    end
  end

end
