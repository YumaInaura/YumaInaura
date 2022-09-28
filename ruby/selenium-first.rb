require 'selenium-webdriver'

session = Selenium::WebDriver.for :chrome

session.manage.timeouts.implicit_wait = 10
session.navigate.to "file:///Users/yumainaura/projects/YumaInaura/ruby/drag-and-drop.html"

source = session.find_element(:id, 'p1')
target = session.find_element(:id, 'dd1')

source.drag_and_drop target

sleep 3

if session.save_screenshot('./drag-and-drop.png')
  puts "Screen shot saved"
end

# ブラウザを終了
session.quit