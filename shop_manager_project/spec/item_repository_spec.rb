# File: spec/item_repository_spec.rb

require 'item_repository'
require 'item'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end
  
  it 'Gets a stock list of items' do
    repo = ItemRepository.new
    items = repo.stock_list
    expect(items.length).to eq 7
    expect(items[0].id).to eq '1'
    expect(items[0].item).to eq 'Bread'
    expect(items[0].price).to eq '135'
    expect(items[0].stock).to eq '50'
    expect(items[1].id).to eq '2'
    expect(items[1].item).to eq 'Milk'
    expect(items[1].price).to eq '90'
    expect(items[1].stock).to eq '40'
  end

  it 'Creates an item' do
    repo = ItemRepository.new
    new_item = Item.new
    new_item.item = 'Jam'
    new_item.price = '150'
    new_item.stock = '20'
    repo.create(new_item) #=> nil
    items = repo.stock_list
    last_item = items.last

    expect(last_item.item).to eq 'Jam'
    expect(last_item.price).to eq '150'
    expect(last_item.stock).to eq '20'
  end

end