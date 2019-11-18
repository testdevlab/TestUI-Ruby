require_relative '../testui_driver'
require_relative '../support/config'
require_relative '../support/elements'

configuration = Configuration.new
configuration.automationType = configuration.SELENIUM
configuration.remote = "http://10.2.5.18:8001/wd/hub"

driver = TestUIDriver.new(configuration)
begin
  driver.open("https://github.com/airbnb/ruby")
  TestUIElement.new(:xpath, "//span[normalize-space(text())='Pull requests']").click
  sleep(15)
rescue
  p "oops"
end
driver.close
