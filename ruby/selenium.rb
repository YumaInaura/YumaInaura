require 'selenium-webdriver'

# options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')

# options = Selenium::WebDriver::Firefox::Options.new
driver = Selenium::WebDriver.for :chrome

# driver = Selenium::WebDriver.for :chrome, options: options

# driver.manage.timeouts.implicit_wait = 10
driver.navigate.to "file:///Users/yumainaura/projects/YumaInaura/ruby/drag-and-drop.html"

source = driver.find_element(:id, 'p1')
target = driver.find_element(:id, 'dd1')

# driver.action.move_to(target).perform
# driver.action.move_to(target)

driver.action.drag_and_drop(source, target).perform
# driver.action.click_and_hold(source).
#                     move_to(target).
#                     release.
#                     perform()

sleep 3

if driver.save_screenshot('./drag-and-drop.png')
  puts "Screen shot saved"
end

# ブラウザを終了
driver.quit