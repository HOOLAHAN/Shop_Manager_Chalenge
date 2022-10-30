# (in lib/order.rb)
class Order

  attr_accessor :id, :name, :date, :order_array

  def initialize
    @order_array = []
  end
end