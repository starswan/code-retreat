module GameOfLife
  # The simplest representation I can think of is a hash of x,y points
  # It has the advantage of easily being able to find the nearest neighbours
  # of every cell trivially e.g. Point(1, 1) has neighbours:
 
  Point = Struct.new(:x, :y)

  class Grid
    def initialize(data)
      @grid = data
    end

    def tick
      new_grid = @grid.select do |cell|
        [2, 3].include?(neighbours(cell[0], cell[1]))
      end
      Grid.new(new_grid)
    end
    
    def size
      @grid.size
    end
    
    private
    
    def neighbours cell_x, cell_y
      count = 0
      [-1, 0, 1].each do |x|
        [-1, 0, 1].each do |y|
          # [0,1]
          target_x = cell_x + x
          target_y = cell_y + y
          count += 1 if @grid.include? [target_x, target_y]
        end
      end
      #exclude self
      count - 1
    end  
      
  end
end