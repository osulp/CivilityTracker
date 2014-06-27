RSpec.configure do |config|
  config.before(:each, type: :feature, :js => true) do
    page.driver.browser.extensions = [File.expand_path("../phantomjs/disable_geolocation.js", __FILE__)]
  end

  config.before(:each, geolocation: true, :js => true) do
    page.driver.browser.extensions = [File.expand_path("../phantomjs/geolocation.js", __FILE__)]
  end
end
