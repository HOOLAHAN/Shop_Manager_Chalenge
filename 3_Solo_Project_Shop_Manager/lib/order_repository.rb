# File: lib/order_repository.rb

require_relative '../app'

class OrderRepository

  def list_all_orders
    sql = 'SELECT id, name, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    return result_set
  end

  def order_history
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

  def create(new_order)
    sql = 'INSERT INTO orders (id, name, date) VALUES ($1, $2, $3);'
    sql_params = [new_order.id, new_order.name, new_order.date]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def add_order(order_id, customer_name, order_date)
    sql1 = 'INSERT INTO orders (id, name, date) VALUES ($1, $2, $3);'
    sql_params = [order_id, customer_name, order_date]
    result_set = DatabaseConnection.exec_params(sql1, sql_params)
  end

  def add_to_items_orders(item, order_id)
    item_id = item
    sql_params = [item_id, order_id]
    sql2 = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);'
    result_set2 = DatabaseConnection.exec_params(sql2, sql_params)
    return nil
  end
  
  def get_all_orders
    @items_orders_list = []
    sql = 'SELECT * FROM items_orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
  end

end