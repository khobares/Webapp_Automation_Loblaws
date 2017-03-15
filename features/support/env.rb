# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec'
require 'pry'
require 'page-object'


World(PageObject::PageFactory)


def browser_name
  (ENV['BROWSER'] ||= 'chrome').downcast.to_sym
end
