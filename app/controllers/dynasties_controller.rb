class DynastiesController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @dynasties = Dynasty.all
    authorize Dynasty
  end

  def show
    @dynasty = Dynasty.find(params[:id])
    authorize @dynasty
  end

  def update
    @dynasty = Dynasty.find(params[:id])
    authorize @dynasty
    if @dynasty.update_attributes(secure_params)
      redirect_to dynasties_path, :notice => "Dynasty updated."
    else
      redirect_to dynasties_path, :alert => "Unable to update dynasty."
    end
  end

  def destroy
    dynasty = Dynasty.find(params[:id])
    authorize user
    dynasty.destroy
    redirect_to dynasty_path, :notice => "Dyansty deleted."
  end

  private

  def secure_params
    params.require(:dynasty).permit(:name)
    params.require(:dynasty).permit(:season)
    params.require(:dynasty).permit(:week)
  end

end
