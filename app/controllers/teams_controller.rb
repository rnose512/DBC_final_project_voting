class TeamsController < ApplicationController
  include SessionsHelper

  def index
    if logged_in?
      @teams = Team.all
      render 'index'
    else
      flash[:notice] = "You do not have access to this page."
      redirect_to login_path
    end
  end

  def new
    if logged_in? && admin?
      @team = Team.new
      @users = User.all
      @pitch_rounds = PitchRound.where(round_id: 2)
    else
      flash[:notice] = "You do not have access to this page."
      redirect_to login_path
    end
  end

  def create
    if logged_in? && admin?
      @team = Team.new(team_params)
      if @team.save
        redirect_to teams_path
      else
        flash[:notice] = "The team did not get saved"
        render "new"
      end
    end
  end


  def show
    if logged_in?
      @team = Team.find(team_params)
      render 'show'
    else
      flash[:notice] = "You do not have access to this page."
      redirect_to login_path
    end
  end

  private
    def team_params
      params.require(:team).permit(:id)
    end
end


