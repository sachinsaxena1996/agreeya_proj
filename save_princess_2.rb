#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'global_constant'

class SavePrincess_2
	def create_grid(n)
		row = Array(0..n-1)
		row.fill('-')
		grid = []
		row.length.times do
			grid << row
		end
		grid
	end

	def place_princess(grid)
		row_with_princess = []
		row_with_princess << GlobalConstant::PRINCESS
		(grid.length - 1).times do
			row_with_princess << '-'
		end	
		grid.pop
		grid << row_with_princess
		grid = grid.shuffle
		grid
	end

	def place_bot(grid, bot_x_position, bot_y_position)
		row_with_bot = []
		count = 0
		grid.length.times do
			if(count == bot_y_position)
				row_with_bot << GlobalConstant::BOT
			else
				row_with_bot << '-'
			end
			count = count + 1
		end
		grid.delete_at(bot_x_position)
		grid.insert(bot_x_position, row_with_bot)
		grid
	end

	def show_input(grid_with_princess_and_bot)
		puts grid_with_princess_and_bot.length
		grid_with_princess_and_bot.each do |input_grid_row|
			p input_grid_row
		end
	end

	[:move_left, :move_right, :move_up, :move_down].each do |method_name|
		define_method(method_name) {
			puts method_name.to_s.upcase.split('_')[1]
			path =  method_name.to_s.upcase.split('_')[1]
			return path
		}
	end

	def nextMove(n, grid_with_princess_and_bot, bot_x_position, bot_y_position)
		princess_row = 0
		princess_column = 0
		grid_with_princess_and_bot.each_with_index do |grid_row, index|
			if grid_row.include?('p')
				princess_row = index
				princess_column = grid_row.index(GlobalConstant::PRINCESS)
			end
		end
		if princess_column < bot_y_position
			path = move_left
		elsif princess_column > bot_y_position
			path = move_right
		elsif princess_row < bot_x_position
			path = move_up
		elsif princess_row > bot_x_position
			path = move_down
		end
		path
	end

	def create_grid_and_display_princess_path(n, bot_x_position, bot_y_position)
		bot_x_position =  bot_x_position.to_i
		bot_y_position = bot_y_position.to_i
		if (n.class != Fixnum) || (n < 2) || (n > 100)
			puts GlobalConstant::ERROR_INT_2_TO_100
			return GlobalConstant::ERROR_INT_2_TO_100
		elsif (bot_x_position > n-1) || (bot_x_position < 0) || (bot_y_position > n-1) || (bot_y_position < 0)
			puts GlobalConstant::ERROR_INVALID_BOT_POSITION + " #{(0..n-1).to_a}"
			return GlobalConstant::ERROR_INVALID_BOT_POSITION + " #{(0..n-1).to_a}"
		else
			grid = create_grid(n)
			grid_with_princess = place_princess(grid)
			grid_with_princess_and_bot = place_bot(grid_with_princess, bot_x_position, bot_y_position)
			show_input(grid_with_princess_and_bot)
			nextMove(n, grid_with_princess_and_bot, bot_x_position, bot_y_position)
		end
	end
end
#ARGV[0] is n in (n * n) array , ARGV[1] and ARGV[2] is the BOT's position in grid
SavePrincess_2.new.create_grid_and_display_princess_path(ARGV[0].to_i, ARGV[1], ARGV[2])

