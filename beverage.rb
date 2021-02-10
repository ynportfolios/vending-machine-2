class Beverage
  attr_reader :id, :name, :price
  attr_accessor :count

  def initialize(id, name, price, count)
    # ID
    @id = id
    # 商品名
    @name = name
    # 価格
    @price = price
    # 在庫数
    @count = count
  end
end
