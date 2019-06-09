# frozen_string_literal: true

require_relative "game"
require_relative "game_interface"

game = Game.new
game_interface = GameInterface.new(game: game)

game_interface.run
