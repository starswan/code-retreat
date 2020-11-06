module GameOfLife
  # The simplest representation I can think of is a hash of x,y points
  # It has the advantage of easily being able to find the nearest neighbours
  # of every cell trivially e.g. Point(1, 1) has neighbours:
  # (0,0), (0, 1), (0, 2)
  # (1, 0), (1, 1), (1, 2)
  # (2, 0), (2, 1) and (2, 2)
  Point = Struct.new(:x, :y)

  class Grid
    def initialize grid
      @grid = grid
    end

    def tick
      survivors = @grid.select { |x, y| neighbours(x, y)== 2 || neighbours(x,y) == 3 }
      @grid = survivors
    end  

    def neighbours x, y
      counter = 0
      counter += count_value x-1, y-1
      counter += count_value x-1, y
      counter += count_value x-1, y+1
      
      counter += count_value x, y-1
      counter += count_value x, y + 1

      counter += count_value x+1, y-1
      counter += count_value x+1, y
      counter += count_value x+1, y+1
      counter 
    end

    def count_value x, y
      @grid.include?([x, y]) ? 1 : 0 
    end  

    def cells
      @grid
    end

    def empty?
      @grid.empty?
    end  
  end
end