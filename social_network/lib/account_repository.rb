# Repository class
# (in lib/account_repository.rb)

require_relative './account'

class AccountRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email, username FROM accounts;
    # Returns an array of Account objects.
    sql = 'SELECT id, email, username FROM accounts;'
    result_set = DatabaseConnection.exec_params(sql, [])
    accounts = []
    result_set.each do |account|
      account = Account.new
      account.id = account['id']
      account.email = account['email']
      account.username = account['username']
      accounts << account
    end
    return accounts
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email, username FROM accounts WHERE id = $1;
    # Returns a single Account object.
  end
  
  # creates an account
  # with an account object
  def create(account)
  # Executes the SQL query:
  # INSERT INTO accounts (email, username) VALUES ($1, $2);

  #returns nothing
  end

  # delete an account
  # with an account object
  def delete(id)
  # Executes the SQL query:
  # DELETE FROM accounts WHERE id = $1;

  # returns nothing
  end
end
