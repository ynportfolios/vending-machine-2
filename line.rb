class Line
  attr_reader :id, :beverage, :count

  def initialize(id, beverage, count)
    # ID
    @id = id
    # 飲料
    @beverage = beverage
    # 在庫数
    @count = count
  end

  def display_line_information
    puts "#{@id}｜#{@beverage.name}｜#{@beverage.price}｜#{@count}"
  end

  def decrease_count
    @count -= 1
  end

  def price
    @beverage.price
  end

  def buyable?(money)
    (self.beverage.price <= money) && self.count.positive?
  end
end
