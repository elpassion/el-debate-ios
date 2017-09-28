source 'https://rubygems.org'

gem 'cocoapods'
gem 'danger'
gem 'danger-swiftlint'
gem 'danger-xcov'
gem 'earlgrey'
gem 'fastlane'
gem 'synx', :git => 'https://github.com/turekj/synx', :branch => 'v0.3'
gem 'xcov'
gem 'xcpretty-travis-formatter'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
