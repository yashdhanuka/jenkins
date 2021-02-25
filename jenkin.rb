require 'rubygems'
require 'selenium-webdriver'

username = "qig1"
access_key = "v6hyyyxtcwmpSMDzdPWD"
build_name = ENV["BROWSERSTACK_BUILD_NAME"]
browserstack_local = ENV["BROWSERSTACK_LOCAL"]
identifier = ENV["BROWSERSTACK_LOCAL_IDENTIFIER"]

caps = Selenium::WebDriver::Remote::Capabilities.new
caps["os"] = "Windows"
caps["os_version"] = "10"
caps["browser"] = "chrome"
caps["browser_version"] = "latest"
caps["name"] = "BStack-[Jenkins] Sample Test" # test name
caps["build"] = build_name # CI/CD job name using BROWSERSTACK_BUILD_NAME env variable
caps["browserstack.user"] = username
caps["browserstack.key"] = access_key
caps["browserstack.local"] = browserstack_local
caps["browserstack.localIdentifier"] = identifier

driver = Selenium::WebDriver.for(:remote,
  :url => "https://hub-k8s-wtf2.bsstag.com:80/wd/hub",
  :desired_capabilities => caps)

#for i in 1..2
	driver.get 'https://www.google.com/'
	print "i got in"
#end
#driver.execute_script("browserstack_executor: {\"action\": \"setSessionName\", \"arguments\": {\"name\": \"rest_api_session\", \"status\": \"failed\", \"reason\": \"verification\" }}")
driver.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status": "failed", "reason": "Title Verification Passed."}}')
driver.quit
