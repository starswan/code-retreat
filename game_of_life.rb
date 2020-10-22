module GameOfLife
  # The simplest representation I can think of is a hash of x,y points
  # It has the advantage of easily being able to find the nearest neighbours
  # of every cell trivially e.g. Point(1, 1) has neighbours:
  # (0,0), (0, 1), (0, 2)
  # (1, 0), (1, 2)
  # (2, 0), (2, 1) and (2, 2)
  Point = Struct.new(:x, :y)

  class Grid
    def initialize
      @grid = {}
    end
  end
end