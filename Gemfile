source 'https://rubygems.org'

gem 'synx', :git => 'https://github.com/turekj/synx', :branch => 'v0.3'
gem 'earlgrey'
gem 'cocoapods'
gem 'fastlane'
gem 'danger'
gem 'danger-swiftlint'
gem 'xcov'
gem 'danger-xcov'
gem 'xcpretty-travis-formatter'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
