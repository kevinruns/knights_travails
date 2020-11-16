# chess board
class Board
  attr_accessor :board, :board_size

  def initialize
    @board_size = 8
    @board = Array.new(@board_size){Array.new(@board_size, '-')}
  end

  def square_visited(coord)
    rank = coord[0]
    file = coord[1]
    return true if @board[rank][file] == 'x'
    @board[rank][file] = 'x'
    return false
  end

  def print_board
    print "\n"
    @board.each_with_index do |_row, i|
      print '    '
      @board[i].each_with_index do |_col, j|
        print " #{@board[i][j]} "
      end
      print "\n"
    end
    print "\n"
  end
end

# node
class Node
  attr_accessor :position, :parent

  def initialize(start = [0, 0], parent)
    @position = start
    @parent = parent
  end

end

# knight piece
class Knight
  attr_accessor :postiion

  def initialize
    @position = [0, 0]
  end

  def all_moves(position = @position)
    moves = []
    moves[0] = [position[0] + 2,position[1] + 1]
    moves[1] = [position[0] + 2,position[1] - 1]
    moves[2] = [position[0] - 2,position[1] + 1]
    moves[3] = [position[0] - 2,position[1] - 1]
    moves[4] = [position[0] + 1,position[1] + 2]
    moves[5] = [position[0] - 1,position[1] + 2]
    moves[6] = [position[0] + 1,position[1] - 2]
    moves[7] = [position[0] - 1,position[1] - 2]
    moves
  end
end

class Game

  def initialize
    @knight = Knight.new
    @board = Board.new
    @start = [0,0]
    @target = [0,0]
  end

  def move_piece(position)
    all_moves = @knight.all_moves(position)
    valid_moves = all_moves.select { |move| onboard(move) && !@board.square_visited(move) }
  end

  def onboard(coord)
    coord[0].between?(0, @board.board_size - 1) && coord[1].between?(0, @board.board_size - 1)
  end

  def check_inputs(start, target)
    onboard(start) && onboard(target) && start != target
  end

  # main method for assigning start and target and initiating moves
  def knight_moves(start, target)
    return 0 unless check_inputs(start, target)
    @board.print_board
    @start = start
    @target = target

    node = Node.new(start, nil)
    find_path(node)

  end

  def find_path(node)
    moves = move_piece(node.position)
    return if moves.length == 0
    p moves
# create node array? to process each turn????
    moves.each do |new_position|
      parent = node
      node = Node.new(new_position, parent)
      print "Node position #{node.position} \n"
      print "Node parent position #{node.parent.position} \n"

      if new_position == @target
        print "Congratulations target found \n"
        print_path(node)
        return
      else
        print "Go deeper #{node.position}\n"
        find_path(node)
      end
    end
  end

  def print_path(node)
    str = ""
    while node.parent
      str.prepend(node.position.to_s)
      node = node.parent
      print "Path: #{str} \n"
    end
    print "Path: #{str} \n"
  end
end

# board = Board.new
# board.print_board

# board.board[2][2] = 'x'
# board.print_board

# p board.square_visited([2,2])

game = Game.new
game.knight_moves([0,0],[3,3])

