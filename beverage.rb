class Beverage
  attr_reader :name, :price

  def initialize(name, price)
    # 商品名
    @name = name
    # 価格
    @price = price
  end
end
