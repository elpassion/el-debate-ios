platform :ios, '10.0'
inhibit_all_warnings!

target 'ELDebate' do
  use_frameworks!

  pod 'Alamofire', '~> 4.4'
  pod 'Anchorage', '~> 4.0'
  pod 'Crashlytics', '~> 3.8'
  pod 'Fabric', '~> 1.6'
  pod 'KeychainAccess', '~> 3.0'
  pod 'PromiseKit', '~> 4.0'
  pod 'Sourcery', '~> 0.6'
  pod 'SwiftLint', '~> 0.18'
  pod 'Swinject', '~> 2.0'
  pod 'SwinjectAutoregistration', '~> 2.0'
  pod 'UIColor_Hex_Swift', '~> 3.0.2'

  target 'ELDebateTests' do
    inherit! :search_paths

    pod 'Nimble-Snapshots'
    pod 'Nimble', '~> 6.1'
    pod 'Quick', '~> 1.1'
  end

end

target 'FeatureTests' do
  use_frameworks!
  inherit! :search_paths

  pod 'EarlGrey', '~> 1.9'
  pod 'FBSnapshotTestCase', '~> 2.1'
  pod 'EarlGreySnapshots', '~> 0.0.1'
end
