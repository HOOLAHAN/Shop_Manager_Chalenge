# File: spec/app_spec.rb

require_relative '../app'

describe Application do

  def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
  end

  before(:each) do
    reset_tables
  end

  context 'initially a welcome message and menu is printed asking user for input' do
    it 'when the user inputs 1 it prints a list of shop items' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
      expect(io).to receive(:puts).with("What would you like to do?").ordered
      expect(io).to receive(:puts).with("1 = list all shop items").ordered
      expect(io).to receive(:puts).with("2 = create a new item").ordered
      expect(io).to receive(:puts).with("3 = list all orders").ordered
      expect(io).to receive(:puts).with("4 = create a new order").ordered
      expect(io).to receive(:puts).with("5 = exit").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("1 - Bread - 135 - 50").ordered
      expect(io).to receive(:puts).with("2 - Milk - 90 - 40").ordered
      expect(io).to receive(:puts).with("3 - Coffee - 300 - 30").ordered
      expect(io).to receive(:puts).with("4 - Sugar - 500 - 20").ordered
      expect(io).to receive(:puts).with("5 - Banana - 60 - 10").ordered
      expect(io).to receive(:puts).with("6 - Butter - 200 - 15").ordered
      expect(io).to receive(:puts).with("7 - Tea - 350 - 12").ordered
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.run
    end

    it 'when the user inputs 2 it lets the user add an item to the stock list' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
      expect(io).to receive(:puts).with("What would you like to do?").ordered
      expect(io).to receive(:puts).with("1 = list all shop items").ordered
      expect(io).to receive(:puts).with("2 = create a new item").ordered
      expect(io).to receive(:puts).with("3 = list all orders").ordered
      expect(io).to receive(:puts).with("4 = create a new order").ordered
      expect(io).to receive(:puts).with("5 = exit").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Please enter item name:").ordered
      expect(io).to receive(:gets).and_return("Coca Cola").ordered
      expect(io).to receive(:puts).with("Please enter item unit price in pence:").ordered
      expect(io).to receive(:gets).and_return("150").ordered
      expect(io).to receive(:puts).with("Please enter item stock quantity:").ordered
      expect(io).to receive(:gets).and_return("50").ordered
      expect(io).to receive(:puts).with("You have added 50 x Coca Cola to the stocklist with a unit price of 150p/item").ordered
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.run
      last_item = item_repository.stock_list_array.last
      expect(last_item.item).to eq "Coca Cola"
      expect(last_item.price).to eq "150"
      expect(last_item.stock).to eq "50"
    end

    it 'when the user inputs 3 it prints out a list of orders' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
      expect(io).to receive(:puts).with("What would you like to do?").ordered
      expect(io).to receive(:puts).with("1 = list all shop items").ordered
      expect(io).to receive(:puts).with("2 = create a new item").ordered
      expect(io).to receive(:puts).with("3 = list all orders").ordered
      expect(io).to receive(:puts).with("4 = create a new order").ordered
      expect(io).to receive(:puts).with("5 = exit").ordered
      expect(io).to receive(:gets).and_return("3").ordered
      expect(io).to receive(:puts).with("1 - Susan - 2022-01-01").ordered
      expect(io).to receive(:puts).with("2 - Sam - 2022-01-02").ordered
      expect(io).to receive(:puts).with("3 - Joe - 2022-01-03").ordered
      expect(io).to receive(:puts).with("4 - Greg - 2022-01-04").ordered
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.run 
    end

    it 'when the user inputs 4 it lets the user add an order' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
      expect(io).to receive(:puts).with("What would you like to do?").ordered
      expect(io).to receive(:puts).with("1 = list all shop items").ordered
      expect(io).to receive(:puts).with("2 = create a new item").ordered
      expect(io).to receive(:puts).with("3 = list all orders").ordered
      expect(io).to receive(:puts).with("4 = create a new order").ordered
      expect(io).to receive(:puts).with("5 = exit").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("Please enter customer name:").ordered
      expect(io).to receive(:gets).and_return("Jacob").ordered
      expect(io).to receive(:puts).with("Please confirm item number to be added to order. To complete type 'stop'").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("Please confirm item number to be added to order. To complete type 'stop'").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("Please confirm item number to be added to order. To complete type 'stop'").ordered
      expect(io).to receive(:gets).and_return("stop").ordered
      expect(io).to receive(:puts).with("Here is your order:").ordered
      expect(io).to receive(:puts).with("1 - Bread - 135").ordered
      expect(io).to receive(:puts).with("2 - Milk - 90").ordered
      expect(io).to receive(:puts).with("TOTAL: £2.25").ordered
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.run
      last_order = order_repository.order_history.last
      expect(last_order.name).to eq "Jacob"
      expect(last_order.date).to eq Time.new.strftime("%Y-%m-%d")
    end
  end

  it 'when the user inputs 5 it exits the program with message' do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with("1 = list all shop items").ordered
    expect(io).to receive(:puts).with("2 = create a new item").ordered
    expect(io).to receive(:puts).with("3 = list all orders").ordered
    expect(io).to receive(:puts).with("4 = create a new order").ordered
    expect(io).to receive(:puts).with("5 = exit").ordered
    expect(io).to receive(:gets).and_return("5")
    expect(io).to receive(:puts).with("Goodbye.")
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run 
  end

  it 'when the users input is not 1-5 it exits the program with message' do
    io = double :io
    expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    expect(io).to receive(:puts).with("What would you like to do?").ordered
    expect(io).to receive(:puts).with("1 = list all shop items").ordered
    expect(io).to receive(:puts).with("2 = create a new item").ordered
    expect(io).to receive(:puts).with("3 = list all orders").ordered
    expect(io).to receive(:puts).with("4 = create a new order").ordered
    expect(io).to receive(:puts).with("5 = exit").ordered
    expect(io).to receive(:gets).and_return("6")
    expect(io).to receive(:puts).with("Input error.")
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run
  end

  it 'when an order is created it updates the items_order join table' do
    order_repository = OrderRepository.new
    result = order_repository.get_all_orders
    expect(result.ntuples).to eq 10 # THE SEED DATA STARTS WITH 10 ENTRIES IN THE ITEMS_ORDERS TABLE
    io = double :io
    expect(io).to receive(:puts).with("Please enter customer name:").ordered
    expect(io).to receive(:gets).and_return("Jiimmy").ordered
    expect(io).to receive(:puts).with("Please confirm item number to be added to order. To complete type 'stop'").ordered
    expect(io).to receive(:gets).and_return("1").ordered
    expect(io).to receive(:puts).with("Please confirm item number to be added to order. To complete type 'stop'").ordered
    expect(io).to receive(:gets).and_return("2").ordered
    expect(io).to receive(:puts).with("Please confirm item number to be added to order. To complete type 'stop'").ordered
    expect(io).to receive(:gets).and_return("stop").ordered
    expect(io).to receive(:puts).with("Here is your order:").ordered
    expect(io).to receive(:puts).with("1 - Bread - 135").ordered
    expect(io).to receive(:puts).with("2 - Milk - 90").ordered
    expect(io).to receive(:puts).with("TOTAL: £2.25").ordered
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    new_test_2 = Application.new('shop_manager_test', io, item_repository, order_repository)
    new_test_2.create_new_order
    result_2 = order_repository.get_all_orders
    expect(result_2.ntuples).to eq 12 # ITEMS_ORDERS TABLE CONFIRMS TWO ITEMS HAVE BEEN ORDERED
  end

end
