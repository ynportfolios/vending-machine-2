require './beverage'
require './line'

class Stock
  attr_reader :error_message

  def initialize
    # 飲料を格納する配列
    @lines = []
    beverage = Beverage.new('コーラ', 120)
    # 初期状態で、コーラ（値段:120円、名前”コーラ”）を5本格納している。
    # rubyは型がないので、適切な名前をつけないと混乱する
    add_line(beverage, 5)
  end

  def add_line(beverage, count)
    @lines << Line.new(@lines.size + 1, beverage, 5)
  end

  def get_line(line_id)
    @lines[line_id]
  end

  def buy(line_id)
    line = get_line(line_id)

    return false unless line.buyable?

    line.decrease_count
    true
  end
end
