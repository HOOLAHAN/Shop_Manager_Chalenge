# (in lib/item.rb)
class Item

  attr_accessor :id, :item, :price, :stock, :stocks_array

  def initialize
    @stocks_array = []
  end
end