require '../game_of_life'
RSpec.describe '#game_of_life' do
    context 'one cell' do
        let(:grid) { GameOfLife::Grid.new([[0,0]]) }
        it 'dies' do
            expect(grid.tick().size).to eq(0) 
        end
    end
    context 'three cells in a row' do
        let(:grid) { GameOfLife::Grid.new([[0,0], [0,1], [0,2]]) }
        it 'just keeps the middle cell alive' do
            expect(grid.tick().size).to eq(1) 
        end
    end
    context 'a cell has four neighbours' do
        let(:grid) { GameOfLife::Grid.new([[0,1], [1, 0], [1,1],
                                          [1,2], [2,1]]) }

         it 'kills the middle cell' do
            expect(grid.tick().size).to eq(4)
         end                                
    end 


end


#    0 1 2 3 4 5
#  0   A
#  1 A A A
#  2   A
#  3
#  4
#  5

# Any live cell with two or three live neighbours survives.
# Any dead cell with three live neighbours becomes a live cell.
# All other live cells die in the next generation. 
# Similarly, all other dead cells stay dead.