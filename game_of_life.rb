module GameOfLife
  # The simplest representation I can think of is a hash of x,y points
  # It has the advantage of easily being able to find the nearest neighbours
  # of every cell trivially e.g. Point(1, 1) has neighbours:
  # (0,0), (0, 1), (0, 2)
  # (1, 0), (1, 2)
  # (2, 0), (2, 1) and (2, 2)
  Point = Struct.new(:x, :y)

  class Grid
    def initialize(grid)
      @grid = grid
    end

    def tick
      # create a new generation
      # admit surviving cells
      survivors = []
      # iterate over each cell
      @grid.each do |cell|
        # cell ~ [1, 2]
        if neighbours(cell) == 2 || neighbours(cell) == 3
          survivors << cell
        end
      end
      # for each cell
      # count the neighbours
      # if there are two or three neighbours, the cell survives

      GameOfLife::Grid.new(survivors)
    end

    def neighbours(cell)
      x, y = cell
      # x - 1 y - 1
      #
      # [ [1,1], [0,0]  ]
      total_neighbours = 0
      # does the grid contain the cell at 0,0?
      @grid

    end

    def population
      @grid.length
    end

    def cells
      @grid
    end
  end
end

