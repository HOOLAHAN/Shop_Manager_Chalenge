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

  it 'initially a welcome message and menu is printed asking user for input' do
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

  xit 'when the user inputs 1 it prints a list of shop items' do
    io = double :io
    # expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    # expect(io).to receive(:puts).with("What would you like to do?").ordered
    # expect(io).to receive(:puts).with("1 = list all shop items").ordered
    # expect(io).to receive(:puts).with("2 = create a new item").ordered
    # expect(io).to receive(:puts).with("3 = list all orders").ordered
    # expect(io).to receive(:puts).with("4 = create a new order").ordered
    # expect(io).to receive(:puts).with("5 = exit").ordered
    expect(io).to receive(:gets).and_return("1").ordered

    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run 
  end

  xit 'when the user inputs 2 it lets the user add an item to the stock list' do
    io = double :io
    # expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    # expect(io).to receive(:puts).with("What would you like to do?").ordered
    # expect(io).to receive(:puts).with("1 = list all shop items").ordered
    # expect(io).to receive(:puts).with("2 = create a new item").ordered
    # expect(io).to receive(:puts).with("3 = list all orders").ordered
    # expect(io).to receive(:puts).with("4 = create a new order").ordered
    # expect(io).to receive(:puts).with("5 = exit").ordered
    expect(io).to receive(:gets).and_return("2").ordered

    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run 
  end

  xit 'when the user inputs 3 it prints out a list of orders' do
    io = double :io
    # expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    # expect(io).to receive(:puts).with("What would you like to do?").ordered
    # expect(io).to receive(:puts).with("1 = list all shop items").ordered
    # expect(io).to receive(:puts).with("2 = create a new item").ordered
    # expect(io).to receive(:puts).with("3 = list all orders").ordered
    # expect(io).to receive(:puts).with("4 = create a new order").ordered
    # expect(io).to receive(:puts).with("5 = exit").ordered
    expect(io).to receive(:gets).and_return("3").ordered
    expect(io).to receive(:puts).with("").ordered
    expect(io).to receive(:puts).with("").ordered
    expect(io).to receive(:puts).with("").ordered
    expect(io).to receive(:puts).with("").ordered
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run 
  end

  xit 'when the user inputs 4 it lets the user add an order' do
    io = double :io
    # expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
    # expect(io).to receive(:puts).with("What would you like to do?").ordered
    # expect(io).to receive(:puts).with("1 = list all shop items").ordered
    # expect(io).to receive(:puts).with("2 = create a new item").ordered
    # expect(io).to receive(:puts).with("3 = list all orders").ordered
    # expect(io).to receive(:puts).with("4 = create a new order").ordered
    # expect(io).to receive(:puts).with("5 = exit").ordered
    expect(io).to receive(:gets).and_return("4").ordered
    expect(io).to receive(:puts).with("").ordered
    expect(io).to receive(:puts).with("").ordered
    expect(io).to receive(:puts).with("").ordered
    expect(io).to receive(:puts).with("").ordered
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new
    app = Application.new('shop_manager_test', io, item_repository, order_repository)
    app.run 
  end

  xit 'when the user inputs 5 it exits the program' do
    result = Application.new
    io = double :io
    expect(io).to receive(:gets).and_return("5")
    expect(io).to receive(:puts).with("Goodbye.")
    expect(result.app).to eq false
  end

  # write test for input other than 1-5
end
