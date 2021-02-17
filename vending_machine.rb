require './beverage'
require './line'

class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている売上金額は0円
    @earn_money = 0
    # 最初の自動販売機に入っている投入金額は0円
    @slot_money = 0
    # 飲料を格納する配列
    @beverages = []
    beverage = Beverage.new('コーラ', 120)
    # 初期状態で、コーラ（値段:120円、名前”コーラ”）を5本格納している。
    @beverages << Line.new(0, beverage, 5)
  end

  # 現在の売上金額を取得できる。
  def current_earn_money
    # 自動販売機に入っている売上を表示する
    @earn_money
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money
    puts '金額を入力してください（｜10｜50｜100｜500｜1000｜のみ使用できます）'
    money = gets.to_i
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)

    # 自動販売機にお金を入れる
    @slot_money += money
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  # 払い戻し操作では現在の投入金額からジュース購入金額を引いた釣り銭を出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end

  # 格納されているジュースの情報（値段と名前と在庫）を取得できる。
  def beverages_infomation
    puts 'ID｜商品名｜価格｜在庫数'
    @beverages.each do |line|
      puts "#{line.id}｜#{line.beverage.name}｜#{line.beverage.price}｜#{line.count}"
    end
  end

  # 投入金額、在庫の点で、コーラが購入できるかどうかを取得できる。
  # ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、ジュースの在庫を減らし、売り上げ金額を増やす。
  # 投入金額が足りない場合もしくは在庫がない場合、購入操作を行っても何もしない。
  # 投入金額、在庫の点で購入可能なドリンクのリストを取得できる。
  # ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、釣り銭（投入金額とジュース値段の差分）を出力する。
  def buy_beverage
    # 購入できる飲料のIDを格納する配列
    beverage_ids = []
    puts 'ID｜商品名｜価格｜購入可否'
    @beverages.each do |line|
      print "#{line.id}｜#{line.beverage.name}｜#{line.beverage.price}"
      if (line.beverage.price <= @slot_money) && line.count.positive?
        beverage_ids << line.id
        puts '｜購入できます'
      else
        puts '｜購入できません'
      end
    end
    puts 'IDを入力してください'
    beverage_id = gets.to_i
    return false unless beverage_ids.include?(beverage_id)

    @beverages[beverage_id].count = @beverages[beverage_id].count - 1
    @earn_money += @beverages[beverage_id].beverage.price
    @slot_money -= @beverages[beverage_id].beverage.price
    puts @slot_money
  end

  # ジュースを3種類管理できるようにする。
  def slot_beverage
    puts '商品名を入力してください'
    name = gets.chomp
    puts '価格を入力してください'
    price = gets.to_i
    puts '個数を入力してください'
    count = gets.to_i
    beverage = Beverage.new(name, price)
    @beverages << Line.new(@beverages.last.id + 1, beverage, count)
  end
end
