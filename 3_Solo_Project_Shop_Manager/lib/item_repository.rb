# (in lib/item_repository.rb)

class ItemRepository

  def stock_list_array
    sql = 'SELECT id, item, price, stock FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    stocks_list = []
    result_set.each do |record|
      list = Item.new
      list.id = record['id']
      list.item = record['item']
      list.price = record['price']
      list.stock = record['stock']
      stocks_list << list
    end
    return stocks_list
  end

  def stock_list
    sql = 'SELECT id, item, price, stock FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    return result_set
  end

  def add_item(id, item_name, item_price, item_stock)
    sql = 'INSERT INTO items (id, item, price, stock) VALUES ($1, $2, $3, $4);'
    sql_params = [id, item_name, item_price, item_stock]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def print_an_item(id)
    sql = 'SELECT id, item, price FROM items WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return result_set
  end

  def select_price(id)
    sql = 'SELECT price FROM items WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return result_set[0]['price']
  end

end