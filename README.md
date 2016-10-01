# PPEventRegistryAPI
Swift 3 framework for accessing data in Event Registry (http://eventregistry.org/)

[![CI Status](http://img.shields.io/travis/pantuspavel/PPEventRegistryAPI.svg?style=flat)](https://travis-ci.org/pantuspavel/PPEventRegistryAPI)
[![codecov.io](https://codecov.io/gh/pantuspavel/PPEventRegistryAPI/branch/master/graphs/badge.svg)](https://codecov.io/gh/pantuspavel/PPEventRegistryAPI/branch/master)
[![Code Climate](https://codeclimate.com/github/pantuspavel/PPEventRegistryAPI/badges/gpa.svg)](https://codeclimate.com/github/pantuspavel/PPEventRegistryAPI)
[![Version](https://img.shields.io/cocoapods/v/PPEventRegistryAPI.svg?style=flat)](http://cocoapods.org/pods/PPEventRegistryAPI)
[![License](https://img.shields.io/cocoapods/l/PPEventRegistryAPI.svg?style=flat)](http://cocoapods.org/pods/PPEventRegistryAPI)
[![Platform](https://img.shields.io/cocoapods/p/PPEventRegistryAPI.svg?style=flat)](http://cocoapods.org/pods/PPEventRegistryAPI)
[![Swift Version](https://img.shields.io/badge/Swift-3.0-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Supported API calls

- `Log In`
- `Get Event By Identifier`
- `Get Recent Articles`

## [Known Issues](https://github.com/pantuspavel/PPEventRegistryAPI/issues)

## Installation

PPEventRegistryAPI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PPEventRegistryAPI"
```

PPEventRegistryAPI is also available through [Carthage](https://github.com/Carthage/Carthage).
Add the following line to your Cartfile:

```ruby
github "pantuspavel/PPEventRegistryAPI"
```

## Developer Setup

*The following stuff needed:* [Xcode 8](https://developer.apple.com/download/), [Bundler](http://bundler.io/), [CocoaPods](http://cocoapods.org/).

To open the project:
```bash
git clone git@github.com:pantuspavel/PPEventRegistryAPI.git
cd PPEventRegistryAPI
bundle
pod install
open PPEventRegistryAPI/PPEventRegistryAPI.xcworkspace
```

To open an example project:
```bash
git clone git@github.com:pantuspavel/PPEventRegistryAPI.git
cd PPEventRegistryAPI/Example
bundle
pod install
open Example/PPEventRegistryTest.xcworkspace
```

## Code Style

- [The Official raywenderlich.com Swift Style Guide.](https://github.com/raywenderlich/swift-style-guide#the-official-raywenderlichcom-swift-style-guide)
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)

## Author

Pavel Pantus, [@pantusp](https://twitter.com/pantusp), pantusp@gmail.com

## License

PPEventRegistryAPI is available under the MIT license. See the LICENSE file for more info.

## Links
- [Accessing Event Registry data through Python](https://github.com/gregorleban/EventRegistry)
