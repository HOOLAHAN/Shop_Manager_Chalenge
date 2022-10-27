# file: spec/post_repository_spec.rb

require 'post_repository'

describe PostRepository do

  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_posts_table
  end

  it 'returns a list of posts' do
    repo = PostRepository.new
    posts = repo.all
    expect(posts.length).to eq 2
    expect(posts[0].id).to eq '1'
    expect(posts[0].title).to eq 'day1'
    expect(posts[0].content).to eq 'some content'
    expect(posts[0].views).to eq '5'
    expect(posts[0].account_id).to eq '1'
  end

  it 'finds a single post' do
    repo = PostRepository.new
    posts = repo.find(1)
    expect(posts.title).to eq 'day1'
    expect(posts.content).to eq 'some content'
    expect(posts.views).to eq '5'
    expect(posts.account_id).to eq '1'
  end

  it 'creates a post' do
    repo = PostRepository.new
    new_post = Post.new
    new_post.title = 'new post'
    new_post.content = 'some new content'
    new_post.views = '10'
    new_post.account_id = '1'

    repo.create(new_post) #=> nil

    posts = repo.all
    last_post = posts.last

    expect(last_post.title).to eq 'new post'
    expect(last_post.content).to eq 'some new content'
    expect(last_post.views).to eq '10'
    expect(last_post.account_id).to eq '1'
  end
end



