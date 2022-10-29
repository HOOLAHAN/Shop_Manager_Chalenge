# file: spec/post_repository_spec.rb

require 'post_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_2' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  it 'finds posts by tag' do
    repo = PostRepository.new
    posts = repo.find_by_tag('coding')
    expect(posts.length).to eq 4
    expect(posts[0].id).to eq 1
    expect(posts[0].name).to eq 'How to use Git'
    expect(posts[1].id).to eq 2
    expect(posts[1].name).to eq 'Ruby Classes'
    expect(posts[2].id).to eq 3
    expect(posts[2].name).to eq 'Using IRB'
    expect(posts[3].id).to eq 7
    expect(posts[3].name).to eq 'SQL basics'
  end
end