require 'appium_lib'
require 'webdrivers'
require 'selenium-webdriver'
require 'pp'
require_relative './config'

class DriverInitializer
  def initialize(configuration)
    opts = define_opts(configuration)
    pp opts
    if configuration.automationType == configuration.SELENIUM
      @driver = initialize_selenium_driver(configuration, opts)
    else
      @driver = initialize_appium_driver(opts)
    end
  end

  def get_driver
    @driver
  end

  def define_opts(configuration)
    case configuration.automationType
    when configuration.ANDROID_REAL_BROWSER
      return opts_android_real_browser(configuration)
    when configuration.ANDROID_EMULATOR_BROWSER
      return opts_android_emulator_browser(configuration)
    when configuration.ANDROID_REAL_APP
      return opts_android_real_app(configuration)
    when configuration.ANDROID_EMULATOR_APP
      return opts_android_emulator_app(configuration)
    when configuration.SELENIUM
      return opts_selenium(configuration)
    when configuration.IOS_BROWSER
      return opts_ios_browser(configuration)
    when configuration.IOS_APP
      return opts_ios_app(configuration)
    else
      raise "Bad automationType: #{configuration.automationType}"
    end

    if configuration.deviceTests
      if configuration.iOSTesting
        return opts_ios
      else
        if not configuration.udid.empty?
          return opts_android_real
        elsif not configuration.emulatorName.empty?
          return opts_android_emulator
        else
          raise "Both androidDeviceName and emulatorName are empty!"
        end
      end
    else
      return opts_selenium
    end
  end

  def opts_android_real_browser(configuration)
    if configuration.automationName.empty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:           'Android',
        automationName:         configuration.automationName,
        deviceName:             configuration.androidDeviceName,
        udid:                   configuration.udid,
        systemPort:             configuration.systemPort,
        browser:                'chrome',
        chromedriverPort:       configuration.chromeDriverPort,
        chromedriverExecutable: configuration.chromeDriverPath,
        nativeWebScreenshot:    true,
        chromeOptions:          { "w3c" => false },
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_android_real_app(configuration)
    if configuration.automationName.empty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:           'Android',
        automationName:         configuration.automationName,
        deviceName:             configuration.androidDeviceName,
        udid:                   configuration.udid,
        app:                    configuration.androidAppPath,
        androidInstallPath:     configuration.androidAppPath,
        appPackage:             configuration.appPackage,
        appActivity:            configuration.appActivity,
        systemPort:             configuration.systemPort,
        noReset:                configuration.noReset,
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_android_emulator_browser(configuration)
    if configuration.automationName.empty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:            'Android',
        automationName:          configuration.automationName,
        deviceName:              configuration.emulatorName,
        avd:                     configuration.emulatorName,
        systemPort:              configuration.systemPort,
        noReset:                 configuration.noReset,
        chromeDriverPort:        configuration.chromeDriverPort,
        browserName:             'chrome',
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_android_emulator_app(configuration)
    if configuration.automationName.empty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:       'Android',
        automationName:     configuration.automationName,
        deviceName:         configuration.emulatorName,
        avd:                configuration.emulatorName,
        app:                configuration.androidAppPath,
        appPackage:         configuration.appPackage,
        appActivity:        configuration.appActivity,
        systemPort:         configuration.systemPort,
        noReset:            configuration.noReset,
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_ios_browser(configuration)
    if configuration.automationName.empty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:  'Android',
        automationName:configuration.automationName,
        deviceName:    configuration.iOSDeviceName,
        udid:          configuration.udid,
        app:           configuration.iOSAppPath,
        useNewWDA:     configuration.useNewWDA,
        noReset:       configuration.noReset,
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_ios_app(configuration)
    if configuration.automationName.empty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:  'Android',
        deviceName:    configuration.iOSDeviceName,
        udid:          configuration.udid,
        app:           configuration.iOSAppPath,
        useNewWDA:     configuration.useNewWDA,
        noReset:       configuration.noReset,
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_selenium(configuration)
    caps = Selenium::WebDriver::Remote::Capabilities.new
    caps[:browser_name] = configuration.browser
    configuration.browserVersion ? caps[:version] = configuration.browserVersion : nil
    configuration.os ? caps[:platform] = configuration.os : nil
    configuration.osVersion ? caps[:os_version] = configuration.osVersion : nil
    configuration.resolution ? caps[:resolution] = configuration.resolution : nil
    configuration.sessionName ? caps[:name] = configuration.sessionName : nil
    return caps
  end

  def initialize_selenium_driver(configuration, opts)
    if configuration.remote.empty?
      case configuration.browser
      when 'chrome'
        return Selenium::WebDriver.for :chrome
      else
        raise "Bad browser name: #{configuration.browser}"
      end
    else
      case configuration.browser
      when 'chrome'
        return Selenium::WebDriver.for :remote, url: configuration.remote, desired_capabilities: opts
      else
        raise "Bad browser name: #{configuration.browser}"
      end
    end
  end

  def initialize_appium_driver(opts)
    driver = Appium::Driver.new(opts, true)
    Selenium::WebDriver.logger.level = :error
    return driver
  end
end
