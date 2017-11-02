# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.after :each do
    Warden.test_reset!
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
    timeout: 1.minute,
    inspector: true, # allows remote debugging by executing page.driver.debug
    phantomjs_logger: File.open(File::NULL, "w"), # don't print console.log calls in console
    phantomjs_options: ['--load-images=no', '--disk-cache=false'],
    window_size: [1600, 3000]
  )
end

Capybara.javascript_driver = :poltergeist

Capybara.exact = true