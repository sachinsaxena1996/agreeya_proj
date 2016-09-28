require './save_princess_2'
require './global_constant'
describe SavePrincess_2 do
	 
	 describe 'instance methods' do
			describe '#create_grid(n)' do
				it "creates and returns a grid of (n * n)" do
					 save_princess = SavePrincess_2.new
					 grid = save_princess.create_grid(5)
					 expect(grid.flatten.length).to eq 25
				end
			end
	 
			describe 'create_grid_and_display_princess_path(n, bot_x_position, bot_y_position)' do
				before(:each) do
						@save_princess = SavePrincess_2.new
				end

				it "returns error if the value of n is less than 2" do
					return_value = @save_princess.create_grid_and_display_princess_path(1 , 1, 1)
					expect(return_value).to eq GlobalConstant::ERROR_INT_2_TO_100
				end

				it "returns error if the value of n is more than 100" do
					return_value = @save_princess.create_grid_and_display_princess_path(101, 1, 1)
					expect(return_value).to eq GlobalConstant::ERROR_INT_2_TO_100
				end

				it "returns error if the value of n is non integer" do
					return_value = @save_princess.create_grid_and_display_princess_path(2.2, 1, 1)
					expect(return_value).to eq GlobalConstant::ERROR_INT_2_TO_100
				end

				it "returns error if the value of bot_x_position is less than 0" do
					return_value = @save_princess.create_grid_and_display_princess_path(3, -1, 0)
					expect(return_value).to eq GlobalConstant::ERROR_INVALID_BOT_POSITION + " #{(0..2).to_a}"
				end

				it "returns error if the value of bot_y_position is less than 0" do
					return_value = @save_princess.create_grid_and_display_princess_path(3, 1, -1)
					expect(return_value).to eq GlobalConstant::ERROR_INVALID_BOT_POSITION + " #{(0..2).to_a}"
				end

				it "returns error if the value of bot_x_position is greater than n-1" do
					return_value = @save_princess.create_grid_and_display_princess_path(3, 3, 0)
					expect(return_value).to eq GlobalConstant::ERROR_INVALID_BOT_POSITION + " #{(0..2).to_a}"
				end

				it "returns error if the value of bot_y_position is greater than n-1" do
					return_value = @save_princess.create_grid_and_display_princess_path(3, 2, 3)
					expect(return_value).to eq GlobalConstant::ERROR_INVALID_BOT_POSITION  + " #{(0..2).to_a}"
				end
			end

			describe 'place_princess(grid)' do
					before(:each) do
						@save_princess = SavePrincess_2.new
						@grid = @save_princess.create_grid(3)
					end

					it "places princess in grid randomly" do
							return_grid_1 = @save_princess.place_princess(@grid)
							return_grid_2 = @save_princess.place_princess(@grid)
							expect(return_grid_1).not_to eq(return_grid_2)
					end
			end

			describe '#place_bot(grid, bot_x_position, bot_y_position)' do
					before(:each) do
						@save_princess = SavePrincess_2.new
						@grid = @save_princess.create_grid(3)
					end
					it "takes  grid, bot_x_position and bot_y_position as input and places bot as per input" do
							return_grid = @save_princess.place_bot(@grid, 1, 1)
							expect(return_grid[1][1]).to eq GlobalConstant::BOT
					end
			end

			describe '#nextMove(n, grid_with_princess_and_bot, bot_x_position, bot_y_position)' do
					before(:each) do
						@n = 3
						@save_princess = SavePrincess_2.new
						@grid = @save_princess.create_grid(@n)
						@grid_with_princess = @save_princess.place_princess(@grid)
						@grid_with_princess_and_bot = @save_princess.place_bot(@grid_with_princess,1, 1)
					end
					it "takes  n, grid_with_princess_and_bot, bot_x_position and bot_y_position as input and returns path to princess" do
							return_path = @save_princess.nextMove(@n, @grid_with_princess_and_bot, 1, 1)
							expect(["UP", "DOWN","LEFT","RIGHT"]).to include(return_path)
					end
			end
		end
end