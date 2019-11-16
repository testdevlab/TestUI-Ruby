class Configuration
  attr_accessor :browser, :baseUrl, :timeout, :appPackage, :appActivity, :deviceTests,
    :useEmulators, :driver, :baseAppiumPort, :baseAppiumBootstrapPort, :useAllure,
    :iOSVersion, :launchAppTimeout, :iOSAppPath, :iOSDeviceName, :androidDeviceName,
    :iOSTesting, :androidAppPath, :androidVersion, :chromeDriverPath,
    :installMobileChromeDriver, :appiumUrl, :emulatorName, :xcodeOrgId,
    :xcodeSigningId, :udid, :bundleId, :updatedWDABundleId,
    :addMobileDesiredCapabilities, :automationName, :useNewWDA, :serverLogLevel,
    :screenshotPath, :timeStartAppiumServer, :cleanStart, :testUILogLevel,
    :chromeDriverPort, :systemPort

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

    @baseUrl = ""
    @timeout = 5
    @useAllure = false
    @chromeDriverPath = ""
    @screenshotPath = ""
    @cleanStart = true
    # @testUILogLevel = LogLevel.INFO
    # @addMobileDesiredCapabilities = new DesiredCapabilities()


    # selenium
    @browser = "chrome"


    # mobile
    @deviceTests = true
    @driver = 1
    @baseAppiumPort = 9586
    @baseAppiumBootstrapPort = 5333
    @launchAppTimeout = 20000
    @appiumUrl = ""
    @automationName = ""
    @serverLogLevel = "error"
    @timeStartAppiumServer = 20
    @noReset = false
    @automationType = @ANDROID_REAL_APP


    # android
    @useEmulators = true
    @installMobileChromeDriver = true

    @appPackage = ""
    @appActivity = ""
    @androidDeviceName = ""
    @androidAppPath = ""
    @androidVersion = ""
    @emulatorName = ""

    @chromeDriverPort = 0
    @systemPort = 0


    # ios
    @iOSVersion = ""
    @iOSAppPath = ""
    @iOSDeviceName = ""
    @iOSTesting = false
    @xcodeOrgId = ""
    @xcodeSigningId = ""
    @udid = ""
    @bundleId = ""
    @updatedWDABundleId = ""
    @useNewWDA = true
    @wdaLocalPort = nil
  end
end
