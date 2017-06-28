class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if params[:admin]
      @user.admin = 1
      @user.save
    end
    session[:user_id] = @user.id
    redirect_to @user
  end

  def show
    if logged_in?
      @user = User.find(params[:id])
      if params[:on_ride]
        ride = Ride.find_or_create_by(user_id: @user.id, attraction_id: params[:attraction_id])
        attraction = Attraction.find_by(id: params[:attraction_id])

        @user = ride.take_ride if ride.present?

        if @user.is_a? String
          flash[:alert] = @user
          @user = User.find(params[:id])
        else
          flash[:alert] = "Thanks for riding the #{attraction.name}!"
        end
      end
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :height, :nausea, :happiness, :tickets, :admin)
  end
end
