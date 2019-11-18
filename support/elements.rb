require_relative './driver_helper'

class TestUIElement
  def initialize(type, value)
    @type = type
    @value = value
    @driver = DriverHelper.get_driver
  end

  def get(wait_time: 30)
    exception = ""
    start = Time.now
    while (Time.now - start) < wait_time
      begin
        el = @driver.find_element(@type, @value)
        return el
      rescue => e
        exception = e
        p "again, type: #{@type}, value: #{@value}"
        sleep(0.1)
      end
    end
    raise "Element #{@value} is not found after #{wait_time} seconds \n Exception: #{exception}"
  end

  def get_list(wait_time: 30)
    exception = ""
    start = Time.now
    while (Time.now - start) < wait_time
      begin
        el = @driver.find_elements(@type, @value)
        return el unless el.empty?
      rescue => e
        exception = e
        p "again, type: #{@type}, value: #{@value}"
        sleep(0.1)
      end
    end
    raise "Element list #{@value} is empty after #{wait_time} seconds \n Exception: #{exception}"
  end

  def click
    element = get
    element.click
  end

  def set(keys)
    element = get
    element.send_keys(keys)
  end

  def enabled?
    element = get
    element.enabled?
  end

  def get_attribute(attribute)
    element = get
    element.attribute(attribute)
  end

  def clear
    element = get
    element.clear
  end

  def text
    element = get
    element.text
  end
end
