require './save_princess'
require './global_constant'
describe SavePrincess do
	 
	 describe 'instance methods' do
			describe '#create_grid(n)' do
				it "creates and returns a grid of (n * n)" do
					 save_princess = SavePrincess.new
					 grid = save_princess.create_grid(5)
					 expect(grid.flatten.length).to eq 25
				end
			end
	
			describe 'create_grid_and_display_princess_path' do
					before(:each) do
						@save_princess = SavePrincess.new
					end

					it "returns error if the value of n is even" do
							return_value = @save_princess.create_grid_and_display_princess_path(4, GlobalConstant::TOP_LEFT)
							expect(return_value).to eq GlobalConstant::ERROR_ODD_INT_3_TO_100
					end

					it "returns error if the value of n is less than 0" do
						return_value = @save_princess.create_grid_and_display_princess_path(-4, GlobalConstant::TOP_LEFT)
						expect(return_value).to eq GlobalConstant::ERROR_ODD_INT_3_TO_100
					end

					it "returns error if the value of n is non integer" do
						return_value = @save_princess.create_grid_and_display_princess_path(9.4, GlobalConstant::TOP_LEFT)
						expect(return_value).to eq GlobalConstant::ERROR_ODD_INT_3_TO_100
					end

					it "returns error if the value of princess_position is Invalid" do
						return_value = @save_princess.create_grid_and_display_princess_path(9, 'Top Right Left')
						expect(return_value).to eq GlobalConstant::INVALID_PRINCESS_POSITION
					end
			end

			describe 'place_princess' do
					before(:each) do
						@save_princess = SavePrincess.new
						@grid = @save_princess.create_grid(3)
					end

					it "places princess on top left if princess_position in input is Top Left" do
							return_grid = @save_princess.place_princess(@grid, GlobalConstant::TOP_LEFT)
							expect(return_grid[0][0]).to eq GlobalConstant::PRINCESS
					end

					it "places princess on top right if princess_position in input is Top Right" do
							return_grid = @save_princess.place_princess(@grid, GlobalConstant::TOP_RIGHT)
							expect(return_grid[0].last).to eq GlobalConstant::PRINCESS
					end

					it "places princess on bottom left if princess_position in input is Bottom Left" do
							#pending
					end
			end

			describe '#place_bot(grid)' do
					before(:each) do
						@save_princess = SavePrincess.new
						@grid = @save_princess.create_grid(3)
					end
					it "takes a (n*n) grid as input and places bot at center of grid" do
							return_grid = @save_princess.place_bot(@grid)
							expect(return_grid[1][1]).to eq GlobalConstant::BOT
					end
			end

			describe '#display_path_to_princess(n, grid_with_princess_and_bot)' do
					before(:each) do
						@n = 3
						@save_princess = SavePrincess.new
						@grid = @save_princess.create_grid(@n)
						@grid_with_princess = @save_princess.place_princess(@grid, GlobalConstant::TOP_LEFT)
						@grid_with_princess_and_bot = @save_princess.place_bot(@grid_with_princess)
					end
					it "takes a n, grid_with_princess_and_bot as input and returns path to princess" do
							return_path = @save_princess.display_path_to_princess(@n, @grid_with_princess_and_bot)
							expect(return_path).to eq "UP LEFT"
					end
			end
		end
end