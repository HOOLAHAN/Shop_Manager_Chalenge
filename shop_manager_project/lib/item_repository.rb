# (in lib/item_repository.rb)
class ItemRepository
  # Selecting a stock list of items
  # No arguments
  def stock_list
    # Executes the SQL query:
    # SELECT id, item, stock FROM items;
    # Returns an array of Item objects.

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
    # stocks_list.each do |cell|
    #   puts cell.values.join(" - ")
    # end
    return stocks_list
  end

  # Creates a single record by its name, price, stock
  # Three arguments: the id (item, price, stock)
  def create(new_item)
    # Executes the SQL query:
    # INSERT INTO items (id, item, price, stock) VALUES ($1, $2, $3, $4);
    # Returns nothing
    sql = 'INSERT INTO items (id, item, price, stock) VALUES ($1, $2, $3, $4);'
    sql_params = [new_item.id, new_item.item, new_item.price, new_item.stock]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

end