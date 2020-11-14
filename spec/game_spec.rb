require './game_of_life'

RSpec.describe '#game_of_life' do
  it 'has a constructor' do
    expect(GameOfLife::Grid.new.size).to eq(0)
  end
end