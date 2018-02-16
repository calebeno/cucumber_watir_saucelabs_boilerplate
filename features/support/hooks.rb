$BROWSER_TYPE = ENV['BROWSER_TYPE'].to_s
$BROWSER_TYPE = 'chrome' if ($BROWSER_TYPE == nil || $BROWSER_TYPE == '')
$PNG_LOCATION =  "#{Dir.pwd}/test_reports/screenshots/#{$BROWSER_TYPE}"

Before do
    if($driver == nil)
        setup_screenshots_directory
        clean_screenshots_directory
        setup_browser
        maximize_browser
        $page_loader = PageLoader.new
    end
    if ($glyptic_strips == nil)
        $glyptic_strips = GlypticStrips.new
    end
end

AfterStep("@pause") do
  puts "Press any key to continue..."
  STDIN.getc
end

AfterStep do
  $glyptic_strips.take_strip_frame($driver, :watir, $PNG_LOCATION)
end

After do |scenario|
    begin
        relative_location = "./screenshots/#{$BROWSER_TYPE}"
        puts $glyptic_strips.create_strip(scenario, $PNG_LOCATION, relative_location, $driver, :watir, 6)
    rescue
        if scenario.failed?
            timestamp = Time.now.to_s.gsub(/:/, '-')
            failure_screenshot = "#{Dir.pwd}/test_reports/screenshots/#{timestamp}.png"
            $driver.screenshot.save(failure_screenshot)
            puts "See screenshot for failure :: #{failure_screenshot}<br><a href='#{failure_screenshot}'><img width='200' src='#{failure_screenshot}'/></a>"
        end
    end
end

def setup_screenshots_directory
    FileUtils.mkdir_p($PNG_LOCATION)
end

def clean_screenshots_directory
    FileUtils.rm_rf(Dir.glob("#{$PNG_LOCATION}/*"))
end

def setup_browser
  set_driver_path()
  if ($BROWSER_TYPE != nil && $BROWSER_TYPE != '')
    $driver = Watir::Browser.new $BROWSER_TYPE.to_sym
  else
    $driver = Watir::Browser.new :chrome
  end
end

def set_driver_path
    case $BROWSER_TYPE
      when 'ie'
          ie_path = File.join("#{Dir.pwd}/vendor/drivers/ie/64bit/3.3/IEDriverServer.exe")
          Selenium::WebDriver::IE.driver_path = ie_path
      when 'firefox'
          firefox_path = File.join("#{Dir.pwd}/vendor/drivers/firefox/geckodriver.exe")
          Selenium::WebDriver::Firefox.driver_path = firefox_path
      else
          chromedriver_path = File.join("#{Dir.pwd}/vendor/drivers/chrome/64bit/2.29/chromedriver.exe")
          Selenium::WebDriver::Chrome.driver_path = chromedriver_path
      end
end

def maximize_browser
    $driver.window.maximize
end
