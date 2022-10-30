# (in lib/item.rb)
class Item

  attr_accessor :id, :item, :price, :stock, :stock_array

  def initialize
    @stock_array = []
  end
end