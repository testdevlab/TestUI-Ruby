class Configuration
  attr_accessor :browser, :baseUrl, :timeout, :appPackage, :appActivity, :deviceTests,
    :useEmulators, :driver, :baseAppiumPort, :baseAppiumBootstrapPort, :useAllure,
    :iOSVersion, :launchAppTimeout, :iOSAppPath, :iOSDeviceName, :androidDeviceName,
    :iOSTesting, :androidAppPath, :androidVersion, :chromeDriverPath,
    :installMobileChromeDriver, :appiumUrl, :emulatorName, :xcodeOrgId,
    :xcodeSigningId, :udid, :bundleId, :updatedWDABundleId,
    :addMobileDesiredCapabilities, :automationName, :useNewWDA, :serverLogLevel,
    :screenshotPath, :timeStartAppiumServer, :cleanStart, :testUILogLevel,
    :chromeDriverPort, :systemPort, :automationType, :noReset, :remote, :os,
    :osVersion, :resolution, :sessionName, :browserVersion

  attr_reader :ANDROID_REAL_BROWSER, :ANDROID_EMULATOR_BROWSER,
  :ANDROID_REAL_APP, :ANDROID_EMULATOR_APP, :SELENIUM,
  :IOS_BROWSER, :IOS_APP

  def initialize
    # global
    @ANDROID_REAL_BROWSER = 'android_browser'.freeze
    @ANDROID_EMULATOR_BROWSER = 'android_emulator_browser'.freeze
    @ANDROID_REAL_APP = 'android_browser_app'.freeze
    @ANDROID_EMULATOR_APP = 'android_emulator_app'.freeze
    @SELENIUM = 'selenium'.freeze
    @IOS_BROWSER = 'ios_browser'.freeze
    @IOS_APP = 'ios_browser'.freeze

    @baseUrl = nil
    @timeout = 5
    @useAllure = false
    @chromeDriverPath = nil
    @screenshotPath = nil
    @cleanStart = true
    # @testUILogLevel = LogLevel.INFO
    # @addMobileDesiredCapabilities = new DesiredCapabilities()


    # selenium
    @browser = "chrome"
    @browserVersion = nil
    @remote = nil
    @os = nil
    @osVersion = nil
    @resolution = nil
    @sessionName = nil



    # mobile
    @driver = 1
    @baseAppiumPort = 9586
    @baseAppiumBootstrapPort = 5333
    @launchAppTimeout = 20000
    @appiumUrl = nil
    @automationName = nil
    @serverLogLevel = "error"
    @timeStartAppiumServer = 20
    @noReset = false
    @automationType = @ANDROID_REAL_APP


    # android
    @useEmulators = true
    @installMobileChromeDriver = true

    @appPackage = nil
    @appActivity = nil
    @androidDeviceName = nil
    @androidAppPath = nil
    @androidVersion = nil
    @emulatorName = nil

    @chromeDriverPort = 0
    @systemPort = 0


    # ios
    @iOSVersion = nil
    @iOSAppPath = nil
    @iOSDeviceName = nil
    @xcodeOrgId = nil
    @xcodeSigningId = nil
    @udid = nil
    @bundleId = nil
    @updatedWDABundleId = nil
    @useNewWDA = true
    @wdaLocalPort = nil
  end
end
