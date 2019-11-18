require_relative '../testui_driver'
require_relative '../support/config'

configuration = Configuration.new
configuration.appiumUrl = "http://localhost:4723/wd/hub"
configuration.emulatorName = "Nexus_One_API_26"
configuration.systemPort = 6789
configuration.androidAppPath = '/Users/edgarsavotins/Downloads/kayak.apk'
configuration.automationType = configuration.ANDROID_EMULATOR_APP

driver = TestUIDriver.new(configuration)
driver.open

TestUIElement.new(:id, 'something').click

driver.close
