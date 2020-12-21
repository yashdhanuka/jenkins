require 'rubygems'
require 'selenium-webdriver'

username = ENV["BROWSERSTACK_USERNAME"]
access_key = ENV["BROWSERSTACK_ACCESS_KEY"]
build_name = ENV["BROWSERSTACK_BUILD_NAME"]

caps = Selenium::WebDriver::Remote::Capabilities.new
caps["os"] = "Windows"
caps["os_version"] = "10"
caps["browser"] = "chrome"
caps["browser_version"] = "latest"
caps["name"] = "BStack-[Jenkins] Sample Test" # test name
caps["build"] = build_name # CI/CD job name using BROWSERSTACK_BUILD_NAME env variable
caps["browserstack.user"] = username
caps["browserstack.key"] = access_key

driver = Selenium::WebDriver.for(:remote,
  :url => "https://hub-cloud.browserstack.com/wd/hub",
  :desired_capabilities => caps)

for i in 1..10
	driver.get 'https://www.google.com/'
	print "i got in"
	element = driver.find_element(:name, 'q')
	element.send_keys "BrowserStack"
	element.submit
	#sleep 2
	#puts driver.title
end
#driver.execute_script("browserstack_executor: {\"action\": \"setSessionName\", \"arguments\": {\"name\": \"rest_api_session\", \"status\": \"failed\", \"reason\": \"verification\" }}")
driver.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status": "failed", "reason": "Title Verification Passed."}}')
driver.quit
