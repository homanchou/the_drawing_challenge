class Admin::ManageChallengesController < Admin::AdminController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]


  def index
    @challenges = Challenge.order(start_at: :desc).page params[:page]
  end

  def show
    respond_with(@challenge)
  end

  def new
    @challenge = Challenge.new(start_at: Time.now.beginning_of_day, end_at: Time.now.end_of_day)
  end

  def edit
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.save
    redirect_to admin_manage_challenges_path
  end

  def update
    @challenge.update(challenge_params)
    redirect_to admin_manage_challenges_path
  end

  def destroy
    @challenge.destroy
    redirect_to admin_manage_challenges_path
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    def challenge_params
      params.require(:challenge).permit(:title, :start_at, :end_at, :description)
    end
end
