platform :ios, '10.0'
inhibit_all_warnings!

def common_pods
  pod 'Alamofire', '~> 4.4'
  pod 'Anchorage', :git => 'https://github.com/Raizlabs/Anchorage.git', :branch => 'feature/xcode-9'
  pod 'KeychainAccess', '~> 3.0'
  pod 'PromiseKit', '~> 4.0'
  pod 'Sourcery', '~> 0.6'
  pod 'SwiftLint', '~> 0.22'
  pod 'Swinject', '~> 2.1.1'
  pod 'SwinjectAutoregistration', :git => 'https://github.com/Swinject/SwinjectAutoregistration.git', :branch => 'swift4'
  pod 'UIColor_Hex_Swift', '~> 3.0.2'
end

target 'ELDebate' do
  use_frameworks!
  common_pods
  pod 'Crashlytics', '~> 3.8'
  pod 'Fabric', '~> 1.6'
  pod 'Reveal-SDK', :configurations => ['Debug']

  target 'ELDebateTests' do
    inherit! :search_paths

    pod 'Nimble-Snapshots', :git => 'https://github.com/ashfurrow/Nimble-Snapshots.git', :branch => 'xcode9-beta'
    pod 'Nimble', '~> 7.0'
    pod 'Quick', :git => 'https://github.com/Quick/Quick.git', :branch => 'xcode-9-fix'
  end

  target 'FeatureTests' do
    inherit! :search_paths

    pod 'EarlGrey', '~> 1.9'
    pod 'EarlGreySnapshots', '~> 0.0.3'
    pod 'FBSnapshotTestCase', '~> 2.1'
  end
end

target 'ELDebateFramework' do
  use_frameworks!
  common_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    case target.name
      when 'KeychainAccess', 'Nimble', 'Quick', 'EarlGreySnapshots', 'EarlGrey', 'Nimble-Snapshots'
        swift_version = '3.0'
      else
        swift_version = '4.0'
    end
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = swift_version
      end
  end
end

