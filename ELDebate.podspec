Pod::Spec.new do |s|
  s.name             = "ELDebate"
  s.version          = "1.0"
  s.summary          = "The framework containing ELDebate app."
  s.homepage         = "https://github.com/elpassion/el-debate-ios"
  s.license          = 'Source code licensed under GPLv3.'
  s.author           = { "Jakub Turek" => "jkbturek@gmail.com" }
  s.source           = { :git => "https://github.com/elpassion/el-debate-ios.git", :tag => s.version }
  s.social_media_url = 'https://twitter.com/elpassion'

  s.platform     = :ios, '10.0'
  s.requires_arc = true

  s.source_files = 'Sources/Framework/**/*{.swift}'
  s.resources = 'Resources/*'

  s.dependency 'Alamofire', '~> 4.4'
  s.dependency 'Anchorage', '~> 4.0'
  s.dependency 'KeychainAccess', '~> 3.0'
  s.dependency 'PromiseKit', '~> 4.0'
  s.dependency 'Sourcery', '~> 0.6'
  s.dependency 'SwiftLint', '~> 0.18'
  s.dependency 'Swinject', '~> 2.0'
  s.dependency 'SwinjectAutoregistration', '~> 2.0'
  s.dependency 'UIColor_Hex_Swift', '~> 3.0.2'
  s.frameworks = 'UIKit'
  s.module_name = 'ELDebate'
end
