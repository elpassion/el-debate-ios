[![Build Status](https://travis-ci.org/elpassion/el-debate-ios.svg?branch=master)](https://travis-ci.org/elpassion/el-debate-ios) ![Bitrise](https://www.bitrise.io/app/63668aa828d950bf.svg?token=Yon1bEu1wjI0dFu9qmLRvw) [![codecov](https://codecov.io/gh/elpassion/el-debate-ios/branch/master/graph/badge.svg)](https://codecov.io/gh/elpassion/el-debate-ios) [![codebeat badge](https://codebeat.co/badges/a4463508-167b-4441-af90-3a4ec4b3b93b)](https://codebeat.co/projects/github-com-elpassion-el-debate-ios-master)

# EL Debate

EL Debate is a platform by [@elpassion](https://www.elpassion.com/) to run an anonymous poll featuring yes-no-undecided question. This repository contains source code powering the iOS client.

### Best practices

The project showcases a couple of good engineering practices:

* [x] Continuous Deployment to TestFlight,
* [x] Continuous Integration with Travis,
* [x] Dependency Injection,
* [x] Code quality measurements:
    * Code coverage,
    * Code quality by [CODEBEAT](https://codebeat.co/).
* [x] Mock auto-generation with Sourcery,
* [x] Playground-driven view development ([original idea](https://talk.objc.io/episodes/S01E51-playground-driven-development-at-kickstarter)),
* [x] Routing pattern (extended coordinator pattern),
* [x] UI interaction/snapshot testing.

# ELDebate as a framework

### Installation

:fire: **This is only accessible to EL Passion organization members.** :fire:

EL Debate can be installed as a framework with Cocoapods. Add following contents to `Podfile`:

```
source 'git@github.com:elpassion/specs.git'
source 'https://github.com/CocoaPods/Specs.git'

target 'ApplicationTargetToIntegrateELDebate' do
  pod 'ELDebate', '~> 1.0'
end
```

and run `pod install` command.

### Running

To run EL Debate within your application use following code:

```swift
let navigationController = UINavigationController()
let debateRunner: DebateRunning = DebateRunner()

debateRunner.start(in: navigationController, applyingDebateStyle: true)
```

Keep in mind that:

1. If `debateRunner` gets deallocated during runtime, the application will crash. Retain it as a field in your controller / coordinator.
2. EL Debate uses custom navigation bar styling. The flag `applyingDebateStyle: true` is responsible for setting custom styling properties in navigation controller's bar.
3. The `navigationController` has to be in your root view controller's hierarchy (obviously).
