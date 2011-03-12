require_relative 'test_helper'

class RstatusTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:twitter, {
    :uid => '12345',
    :user_info => {
      :name => "Joe Public",
      :nickname => "joepublic",
      :urls => { :Website => "http://rstat.us" },
      :description => "A description",
      :image => "/images/something.png"
    }
  })
  

  def app() Rstatus end

  def setup
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_hello_world
    get '/'
    assert last_response.ok?
    #assert_equal "Hello, world!", last_response.body
  end

  def login
    get '/auth/twitter'
    follow_redirect!
  end

  def test_login_with_twitter
    login
    assert_equal "You're now logged in.", last_response.body
  end


end
