const webdriver = require('selenium-webdriver');
async function runTestWithCaps (capabilities) {
  let driver = new webdriver.Builder()
    .usingServer('http://yashdhanuka_jh7JRC:uqKifuEYf7jyhbrW3xyv@hub-cloud.browserstack.com/wd/hub')
    .withCapabilities({
      ...capabilities,
      ...capabilities['browser'] && { browserName: capabilities['browser']}  // Because NodeJS language binding requires browserName to be defined
    })
    .build();
  await driver.get("http://www.duckduckgo.com");
  const inputField = await driver.findElement(webdriver.By.name("q"));
  await inputField.sendKeys("BrowserStack", webdriver.Key.ENTER); // this submits on desktop browsers
  try {
    await driver.wait(webdriver.until.titleMatches(/BrowserStack/i), 5000);
  } catch (e) {
    await inputField.submit(); // this helps in mobile browsers
  }
  try {
    await driver.wait(webdriver.until.titleMatches(/BrowserStack/i), 5000);
    console.log(await driver.getTitle());
    await driver.executeScript(
      'browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed","reason": "Title contains BrowserStack!"}}'
    );
  } catch (e) {
    await driver.executeScript(
      'browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed","reason": "Page could not load in time"}}'
    );
  }
  await driver.quit();
}

const build_name = BROWSERSTACK_BUILD_NAME
const browserstack_local = BROWSERSTACK_LOCAL
const identifier = BROWSERSTACK_LOCAL_IDENTIFIER
const capabilities1 = {
    'bstack:options' : {
        "deviceName": "iPhone XS",
        "osVersion": "15",
        "buildName" : build_name,
        "sessionName" : "Parallel test 1",
        "browserstack.local": browserstack_local,
        "browserstack.localIdentifier": identifier,
    },
    "browserName": "ios",
    }
 const capabilities2 = {
    'bstack:options' : {
        "os": "Windows",
        "osVersion": "10",
        "buildName" : build_name,
        "sessionName" : "Parallel test 2",
    },
    "browserName": "firefox",
    "browserVersion": "102.0",
    }
const capabilities3 = {
    'bstack:options' : {
        "os": "OS X",
        "osVersion": "Big Sur",
        "buildName" : "browserstack-build-1",
        "sessionName" : "Parallel test 3",
    },
    "browserName": "safari",
    "browserVersion": "14.1",
    }
runTestWithCaps(capabilities1);
runTestWithCaps(capabilities2);
runTestWithCaps(capabilities3);
