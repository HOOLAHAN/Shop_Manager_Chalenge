# file: spec/order_repository_spec.rb

require 'order_repository'
require 'order'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end
  
  it 'Gets a list of orders' do
    repo = OrderRepository.new
    orders = repo.order_history
    expect(orders.length).to eq 4
    expect(orders[0].id).to eq '1'
    expect(orders[0].name).to eq 'Susan'
    expect(orders[0].date).to eq '2022-01-01'
    expect(orders[1].id).to eq '2'
    expect(orders[1].name).to eq 'Sam'
    expect(orders[1].date).to eq '2022-01-02'
  end

  it 'Creates an order' do
    repo = OrderRepository.new
    new_order = Order.new
    new_order.id = '5'
    new_order.name = 'Frank'
    new_order.date = '2022-01-05'
    repo.create(new_order) #=> nil
    orders = repo.order_history
    last_order = orders.last
    expect(new_order.id).to eq '5'
    expect(last_order.name).to eq 'Frank'
    expect(last_order.date).to eq'2022-01-05'
  end
end