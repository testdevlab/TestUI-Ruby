require 'appium_lib'
require_relative './config'

class DriverInitializer

  def initialize(configuration)
    # deviceTests
    # iOSTesting
    # androidDeviceName/emulatorName
    opts = define_opts(configuration)

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
    if configuration.automationName.isEmpty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:           'Android',
        automationName:         configuration.automationName
        deviceName:             configuration.androidDeviceName,
        udid:                   configuration.udid,
        systemPort:             configuration.systemPort,
        browser:                'chrome',
        chromedriverPort:       configuration.chromeDriverPort,
        chromedriverExecutable: configuration.chromeDriverPath,
        nativeWebScreenshot:    true,
        chromeOptions:          { "w3c" => false }
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_android_real_app(configuration)
    if configuration.automationName.isEmpty?
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
    if configuration.automationName.isEmpty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:            'Android',
          automationName:        configuration.automationName,
        deviceName:              configuration.androidDeviceName,
        avd:                     configuration.emulatorName,
        app:                     configuration.androidAppPath,
        appPackage:              configuration.appPackage,
        appActivity:             configuration.appActivity,
        systemPort:              configuration.systemPort,
        noReset:                 configuration.noReset,
        chromeDriverPort:        configuration.chromeDriverPort
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_android_emulator_app(configuration)
    if configuration.automationName.isEmpty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:       'Android',
        automationName:     configuration.automationName,
        deviceName:         configuration.androidDeviceName,
        avd:                configuration.emulatorName,
        app:                configuration.androidAppPath,
        appPackage:         configuration.appPackage,
        appActivity:        configuration.appActivity,
        systemPort:         configuration.systemPort,
        noReset:            configuration.noReset,
        chromeDriverPort:   configuration.chromeDriverPort
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_ios_browser(configuration)
    if configuration.automationName.isEmpty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:  'Android',
        automationName:configuration.automationName,
        deviceName:    configuration.iOSDeviceName,
        udid:          configuration.udid,
        app:           configuration.iOSAppPath,
        useNewWDA:     configuration.useNewWDA
        noReset:       configuration.noReset,
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_ios_app(configuration)
    if configuration.automationName.isEmpty?
      configuration.automationName = 'UiAutomator2'
    end
    return {
      caps: {
        platformName:  'Android',
        deviceName:    configuration.iOSDeviceName,
        udid:          configuration.udid,
        app:           configuration.iOSAppPath,
        useNewWDA:     configuration.useNewWDA
        noReset:       configuration.noReset,
      },
      appium_lib: {
        server_url: configuration.appiumUrl
      }
    }
  end

  def opts_selenium

  end


end








  opts = {
    caps: {
      platformName:  'Android',
      deviceName:    'something',
      # avd:           "#{ENV['DEVICE']}",
      # udid:           "#{ENV['DEVICE']}",
      app:           '/Users/edgarsavotins/Downloads/kayak.apk',
    },
    appium_lib: {
      server_url: "http://localhost:#{ENV['PORT']}/wd/hub"
    }
  }

  $driver = Appium::Driver.new(opts, true)
  Selenium::WebDriver.logger.level = :error
