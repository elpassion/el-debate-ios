platform :ios, '10.0'
inhibit_all_warnings!

target 'ELDebate' do
  use_frameworks!

  pod 'Alamofire', '~> 4.4'
  pod 'Anchorage', '~> 4.0'
  pod 'KeychainAccess', '~> 3.0'
  pod 'PromiseKit', '~> 4.0'
  pod 'Sourcery', '~> 0.6'
  pod 'SwiftLint', '~> 0.18'
  pod 'Swinject', '~> 2.0'
  pod 'SwinjectAutoregistration', '~> 2.0'
  pod 'UIColor_Hex_Swift', '~> 3.0.2'

  target 'ELDebateTests' do
    inherit! :search_paths

    pod 'Quick', '~> 1.1'
    pod 'Nimble', '~> 6.1'
  end

end

target 'FeatureTests' do
  use_frameworks!
  inherit! :search_paths

  pod 'EarlGrey', '~> 1.9'
end
