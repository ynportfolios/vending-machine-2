class Line
  attr_reader :id, :beverage
  attr_accessor :count

  def initialize(id, beverage, count)
    # ID
    @id = id
    # 飲料
    @beverage = beverage
    # 在庫数
    @count = count
  end
end
