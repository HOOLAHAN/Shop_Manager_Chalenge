# (in lib/order_repository.rb)


class OrderRepository
  # Selecting a stock list of orders
  # No arguments
  def order_history
    # Executes the SQL query:
    # SELECT id, name, date FROM orders;
    # Returns an array of Order objects.
    sql = 'SELECT id, name, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    order_history = []
    result_set.each do |record|
      list = Order.new
      list.id = record['id']
      list.name = record['name']
      list.date = record['date']
      order_history << list
    end
    return order_history
  end
  # Gets a single record by its ID
  # One argument: the id (number)
  def create(new_order)
    # Executes the SQL query:
    # INSERT INTO orders (name, date) VALUES ($1, $2);
    # Returns nothing
  end

end