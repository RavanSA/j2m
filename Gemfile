source "https://rubygems.org"

git_source(:github) {|j2m| "https://github.com/RavanSA/j2m" }

gem "fastlane"
gem "cocoapods"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
