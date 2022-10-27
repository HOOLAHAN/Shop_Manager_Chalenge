# file: spec/account_repository_spec.rb

require 'account_repository'

describe AccountRepository do
  
  def reset_accounts_table
    seed_sql = File.read('spec/seeds_accounts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_accounts_table
  end
  # (your tests will go here).

  it 'returns a list of accounts' do
    repo = AccountRepository.new
    accounts = repo.all
    expect(accounts.length).to eq 2
    expect(accounts[0].id).to eq 1
    expect(accounts[0].email).to eq 'joe@test.com'
    expect(accounts[0].username).to eq 'joelander'
    
    # expect(accounts[1].id).to eq 2
    # expect(accounts[1].username).to eq 'iainhoolahan'
    # expect(accounts[1].email).to eq 'iain@test.com'
  end

end