require 'watir'

Before do
  @browser = Watir::Browser.new :chrome
end

After do
  @browser.close
end