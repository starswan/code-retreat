require './game_of_life'
RSpec.describe '#game_of_life' do
  context 'a grid with a single cell' do
    let(:grid) { GameOfLife::Grid.new([[1,1]]) }
    let(:new_grid) { grid.tick}

    it 'has one cell in the current generation' do
      expect(grid.population).to eq(1)
    end

    it 'has no cells in the next generation' do
      expect(new_grid.population).to eq(0)
    end

    it 'tick returns a new instance of Grid' do
      expect(grid === new_grid).to be(false)
    end

    it '#cells returns the actual grid' do
      expect(grid.cells).to eq( [[1,1]] )
    end
  end

  context 'a grid with three cells in a row' do
    let(:grid) { GameOfLife::Grid.new([[1,1], [2,1], [3,1]]) }
    let(:new_grid) { grid.tick}

    it 'has three cells in the current generation' do
      expect(grid.cells).to eq([[1, 1], [2, 1], [3, 1]])
    end

    it 'has one cell in the next generation' do
      expect(new_grid.population).to eq(1)
    end

    it 'the surviving cell is the middle one' do
      expect(new_grid.cells).to eq([[2,1]])
    end
  end
end


#    0 1 2 3 4 5
#  0 T
#  1   C A A
#  2
#  3
#  4
#  5

# if A.neighbours < 2 == dies

# Any live cell with fewer than two live neighbours dies, as if by underpopulation.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overpopulation.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
