class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(secure_params)
      redirect_to teams_path, :notice => "Team updated."
    else
      redirect_to teams_path, :alert => "Unable to update team."
    end
  end

  private

  def secure_params
  #  params.require(:user).permit(:role)
  end

end

