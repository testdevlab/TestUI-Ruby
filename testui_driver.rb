require_relative './support/driver'
require_relative './support/driver_helper'

class TestUIDriver
  attr_accessor :driver
  def initialize(configuration)
    @driver = DriverInitializer.new(configuration).get_driver
    @configuration = configuration
    if @configuration.automationType == @configuration.SELENIUM
      @appium = false
    else
      @appium = true
    end
  end

  def open(url = nil)
    @appium ? @driver.start_driver : open_selenium(url)
    DriverHelper.set_driver(@driver)
    p @driver.methods
  end

  def open_selenium(url)
    raise "URL is empty!" if url.nil?
    @driver.navigate.to(url)
  end

  def close
    @appium ? @driver.driver_quit : @driver.quit
  end
end
