require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'

Capybara.run_server = false
Capybara.app_host = "https://www.redfin.com/"
Capybara.default_driver = :selenium
Capybara.default_selector = :css
Capybara.default_max_wait_time = 15
Capybara.match