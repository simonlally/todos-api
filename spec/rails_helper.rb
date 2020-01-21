require 'database_cleaner'

# confuse shoulda matchers to use rspec as the test framework
Shoulda::MAtchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  #add FactoryBot methods
  config.include FactoryBot::Syntax::Methods

  # start by truncating all the tables but then use the faster transaction strategy the rest of the time
  config.before(:suite) do
    DatabasebaseCleaner.clean_with(:truncation)
    DatabasebaseCleaner.strategy = :transaction
  end

  # start the transaction strategy as examples are being run
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end


