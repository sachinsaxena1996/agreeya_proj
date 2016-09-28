#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'global_constant'
class SavePrincess
	def create_grid(n)
		row = Array(0..n-1)
		row.fill('-')
		grid = []
		row.length.times do
			grid << row
		end
		grid
	end

	def place_princess(grid, princess_position)
		row_with_princess = []
		row_with_princess << 'p'
		# ind = grid.length - 1
		(grid.length - 1).times do
			row_with_princess << '-'
		end	
		grid.pop
		if princess_position == GlobalConstant::TOP_LEFT
			grid.insert(0,row_with_princess)
		elsif princess_position == GlobalConstant::TOP_RIGHT
			grid.insert(0,row_with_princess.reverse)
		elsif princess_position == GlobalConstant::BOTTOM_LEFT
			grid.insert((grid.length - 1), row_with_princess)
		elsif princess_position == GlobalConstant::BOTTOM_RIGHT
			grid.insert((grid.length - 1), row_with_princess.reverse)
		end
		grid
	end

	def place_bot(grid)
		grid_length = grid.length
		row_with_bot = []
		mid = (grid_length - 1)/2
		grid_length.times do 
			row_with_bot << '-'
		end
		row_with_bot[mid] = GlobalConstant::BOT
		grid.insert(mid, row_with_bot)
		grid.pop
		grid
	end

	def show_input(grid_with_princess_and_bot)
		puts grid_with_princess_and_bot.length
		grid_with_princess_and_bot.each do |input_grid_row|
			p input_grid_row
		end
	end

	[:move_left, :move_right, :move_up, :move_down].each do |method_name|
		define_method(method_name) {|n|
			path = ""
			((n - 1)/2).times do
				puts method_name.to_s.upcase.split('_')[1]
				path = path + ' ' + method_name.to_s.upcase.split('_')[1]
			end
			return path
		}
	 end

	def display_path_to_princess(n, grid_with_princess_and_bot)
		first_suspected_row = grid_with_princess_and_bot.first
		second_suspected_row = grid_with_princess_and_bot.last
		path = ""
		if first_suspected_row.first == GlobalConstant::PRINCESS
			path = move_up(n)
			path =  path + move_left(n)
		elsif first_suspected_row.last == GlobalConstant::PRINCESS
			path = move_up(n)
			path =  path + move_right(n)
		elsif second_suspected_row.first == GlobalConstant::PRINCESS
			path = move_down(n)
			path =  path + move_left(n)
		elsif second_suspected_row.last == GlobalConstant::PRINCESS
			path = move_down(n)
			path =  path + move_right(n)
		end
		path.lstrip
	end

	def create_grid_and_display_princess_path(n, princess_position)
		if(n % 2 == 0) || (n.class != Fixnum) || (n < 0)
			puts GlobalConstant::ERROR_ODD_INT_3_TO_100
			return GlobalConstant::ERROR_ODD_INT_3_TO_100
		elsif princess_position != GlobalConstant::TOP_LEFT && princess_position != GlobalConstant::TOP_RIGHT &&
			princess_position != GlobalConstant::BOTTOM_LEFT && princess_position != GlobalConstant::BOTTOM_RIGHT
			puts GlobalConstant::INVALID_PRINCESS_POSITION
			return GlobalConstant::INVALID_PRINCESS_POSITION
		else
			grid = create_grid(n)
			grid_with_princess = place_princess(grid, princess_position)
			grid_with_princess_and_bot = place_bot(grid_with_princess)
			show_input(grid_with_princess_and_bot)
			display_path_to_princess(n, grid_with_princess_and_bot)
		end
	end
end
#ARGV[0] is n in (n * n) array , ARGV[1] is the princess position can be: Top Left, Top Right, Bottom Left or Bottom Right
SavePrincess.new.create_grid_and_display_princess_path(ARGV[0].to_i, ARGV[1])

