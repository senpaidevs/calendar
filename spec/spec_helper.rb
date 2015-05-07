require 'rack/test'
require_relative '../webapp/app'

module RSpecMixin
  include Rack::Test::Methods

  def app()
    Sinatra::Application
  end
end


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  config.include RSpecMixin
end

