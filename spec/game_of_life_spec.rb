require 'game_of_life'

RSpec.describe 'gameoflife' do
    # if a live cell has 2 or 3 neighbours it lives otherwise it dies
    # If a dead cell has 3 neighbours it lives (birth)   
    it 'dies if 1 cell exists' do
        grid = GameOfLife::Grid.new( [[0, 0]])
        grid.tick
        expect(grid).to be_empty
    end
    it 'block of 4 survives' do
        grid = GameOfLife::Grid.new( [[0, 0], [0, 1], [1, 0], [1, 1]] )
        grid.tick
        expect(grid.cells).to eq([[0, 0], [0, 1], [1, 0], [1, 1]])
    end
    it 'traffic light demonstrates births' do
        grid = GameOfLife::Grid.new( [[1, 0], [1, 1], [1, 2]] )
        grid.tick
        expect(grid.cells).to match_array([[0, 1], [1, 1], [2, 1]])
    end

    describe '#neighbours' do
        it 'counts all neighbours' do
            grid = GameOfLife::Grid.new( [[0, 0], [0, 1], [1, 0], [1, 1]] )
            expect(grid.neighbours(0, 1)).to eq(3)
        end
    end
end

#   A A X Y
#   A A Y Y
#   A A A A