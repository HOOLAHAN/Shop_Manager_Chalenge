# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE
Table: orders
Columns:
id | name | date
Table: items
Columns:
id | item | price | stock
Table: items_orders
Columns
item_id | order_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)
-- Write your SQL seed here. 
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)
TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO "public"."items" ("id", "item", "price", "stock") VALUES
(1, 'Bread', 135, 50),
(2, 'Milk', 90, 40),
(3, 'Coffee', 300, 30),
(4, 'Sugar', 500, 20),
(5, 'Banana', 60, 10),
(6, 'Butter', 200, 15),
(7, 'Tea', 350, 12);

INSERT INTO "public"."orders" ("id", "name", "date") VALUES
(1, 'Susan', '2022-01-01'),
(2, 'Sam', '2022-01-02'),
(3, 'Joe', '2022-01-03'),
(4, 'Greg', '2022-01-04');

INSERT INTO "public"."items_orders" ("item_id", "order_id") VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 2),
(7, 1),
(6, 3),
(2, 4),
(3, 4);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: items
# Model class
# (in lib/item.rb)
class Item
end
# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end

# Table name: orders
# Model class
# (in lib/order.rb)
class Order
end
# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: items
# Model class
# (in lib/item.rb)
class Item
  # Replace the attributes by your own columns.
  attr_accessor :id, :item, :price, :stock
end

# Table name: orders
# Model class
# (in lib/order.rb)
class Order
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :date
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: items
# Repository class
# (in lib/item_repository.rb)
class ItemRepository
  # Selecting a stock list of items
  # No arguments
  def stock_list
    # Executes the SQL query:
    # SELECT id, item, stock FROM items;
    # Returns an array of Item objects.
  end
  # Creates a single record by its name, price, stock
  # Three arguments: the id (item, price, stock)
  def create(new_item)
    # Executes the SQL query:
    # INSERT INTO items (item, price, stock) VALUES ($1, $2, $3);
    # Returns nothing
  end

end

# Table name: orders
# Repository class
# (in lib/order_repository.rb)
class OrderRepository
  # Selecting a stock list of orders
  # No arguments
  def order_history
    # Executes the SQL query:
    # SELECT id, name, date FROM orders;
    # Returns an array of Order objects.
  end
  # Gets a single record by its ID
  # One argument: the id (number)
  def create(new_order)
    # Executes the SQL query:
    # INSERT INTO orders (name, date) VALUES ($1, $2);
    # Returns nothing
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
# 1
# Get stock list of items
repo = ItemRepository.new
items = repo.stock_list
items.length # =>  7
items[0].id # =>  1
items[0].item # =>  'Bread'
items[0].price # =>  135
items[0].stock # =>  50
items[1].id # =>  2
items[1].item # =>  'Milk'
items[1].price # =>  90
items[1].stock # =>  40

# 2
# Create an item
repo = ItemRepository.new
new_item = Item.new
new_item.item = 'Jam'
new_item.price = 150
new_item.stock = 20
repo.create(new_item) #=> nil
items = repo.stock_list
last_item = items.last

last_item.item # =>  'Jam'
last_item.price # =>  150
last_item.stock # =>  20

# 3 
# Get a list of orders

repo = OrderRepository.new
orders = repo.order_history
orders.length # =>  4
orders[0].id # =>  1
orders[0].name # =>  'Susan'
orders[0].date # =>  '2022-01-01'
orders[1].id # =>  2
orders[1].name # =>  'Sam'
orders[1].date # =>  '2022-01-02'

# 4
# Create an order

repo = OrderRepository.new
new_order = Order.new
new_order.item = 'Frank'
new_order.date = '2022-01-05'
repo.create(new_order) #=> nil
orders = repo.order_history
last_order = orders.last

last_order.name # =>  'Frank'
last_order.date # =>  '2022-01-05'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE
# file: spec/item_repository_spec.rb
def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end
describe ItemRepository do
  before(:each) do 
    reset_items_table
  end
  # (your tests will go here).
end

# EXAMPLE
# file: spec/order_repository_spec.rb
def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end
describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end
  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._