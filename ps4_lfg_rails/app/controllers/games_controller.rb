class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.all
  end

  def show
    @events = @game.events
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    def set_game
      begin
      @game = Game.friendly.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      redirect_to "/404"
      end
    end

    def game_params
      params.require(:game).permit(:name)
    end
end
