# file: app.rb

require_relative 'lib/item'
require_relative 'lib/item_repository'
require_relative 'lib/order'
require_relative 'lib/order_repository'
require_relative 'lib/database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item = ItemRepository.new
    @order = OrderRepository.new
  end

  def print_menu
    @io.puts "Welcome to the shop management program!"
    @io.puts "What would you like to do?"
    @io.puts "1 = list all shop items"
    @io.puts "2 = create a new item"
    @io.puts "3 = list all orders"
    @io.puts "4 = create a new order"
    @io.puts "5 = exit"
  end

  def run
    print_menu
    user_input = @io.gets.chomp
    if user_input == "1"
      return print_all_items
    elsif user_input == "2"
      return add_stock_item
    elsif user_input == "3"
      return print_all_orders
    elsif user_input == "4"
      return create_new_order
    elsif user_input == "5"
      @io.puts "Goodbye."
      return false
    else
      @io.puts "Input error."
    end
  end

  def print_all_items # OPTION 1
    @item.stock_list.each do |cell|
      @io.puts cell.values.join(" - ")
    end
  end

  def add_stock_item # OPTION 2
    @io.puts "Please enter item name:"
    item_name = @io.gets.chomp
    @io.puts "Please enter item unit price in pence:"
    item_price = @io.gets.chomp
    @io.puts "Please enter item stock quantity:"
    item_stock = @io.gets.chomp
    id = (@item.stock_list.ntuples + 1).to_s
    @item.add_item(id, item_name, item_price, item_stock)
    @io.puts "You have added #{item_stock} x #{item_name} to the stocklist with a unit price of #{item_price}p/item"
  end
  
  def print_all_orders # OPTION 3
    @order.list_all_orders.each do |cell|
      @io.puts cell.values.join(" - ")
    end
  end
  
  def create_new_order # OPTION 4
    @order_array = []
    total_in_shop = @item.stock_list_array.length
    @io.puts "Please enter customer name:"
    customer_name = @io.gets.chomp
    order_date = Time.new.strftime("%Y/%m/%d")
    until false do
      @io.puts "Please confirm item number to be added to order. To complete type 'stop'"
      item = @io.gets.chomp
      if item == 'stop'
        break
      elsif  item.to_i > total_in_shop || item.to_i < 1
        @io.puts "Please enter a valid item number"
      else
        @order_array << item
      end
    end
    @io.puts "Here is your order:"
    @order_array.each do |item|
      print_item_in_basket(item)
    end
    total = []
    @order_array.each do |item|
      total << @item.select_price(item).to_f
    end
    @io.puts "TOTAL: £#{total.sum/100}"
    
    order_id = @order.list_all_orders.ntuples + 1
    @order.add_order(order_id, customer_name, order_date)
    @order_array.each do |item|
      @order.add_to_items_orders(item, order_id)
    end
  end 

  def print_item_in_basket(id)
    @item.print_an_item(id).each do |cell|
      @io.puts cell.values.join(" - ")
    end
  end

end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end