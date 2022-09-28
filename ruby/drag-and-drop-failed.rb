require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.navigate.to "file:///Users/yumainaura/projects/YumaInaura/ruby/drag-and-drop.html"

source = driver.find_element(:id, 'p1')
target = driver.find_element(:id, 'dd1')


driver.action.drag_and_drop(source, target).perform

sleep 3

if driver.save_screenshot('./drag-and-drop.png')
  puts "Screen shot saved"
end

