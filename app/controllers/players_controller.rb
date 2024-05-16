# frozen_string_literal: true
class PlayersController < ApplicationController

  def index
    @player = Player.new
    @players = Player.all
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to root_path
      flash[:success] = 'Jogador Salvo com sucesso'
    else
      flash[:error] = 'Erro ao salvar jogador'
      render 'new'
    end
  end

  def shuffle
    @players = Player.all
    @players = @players.sort_by { |player| player.rating + rand(0..1) }

    @team1 = []
    @team2 = []

    @count = @players.length - 1

    (@players.count/2).to_i.times do |index|
      if index % 2 == 0
        @team1.append(@players[index])
        @team2.append(@players[@count - index])
      else
        @team1.append(@players[@count - index])
        @team2.append(@players[index])
      end
    end
    @teams = { team1: @team1, team2: @team2 }
  end

  private

  def player_params
    params.require(:player).permit(:name, :rating)
  end
end
