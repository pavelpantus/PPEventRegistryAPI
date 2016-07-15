# PPEventRegistryAPI
Swift framework for accessing data in Event Registry (http://eventregistry.org/)

[![CI Status](http://img.shields.io/travis/pantuspavel/PPEventRegistryAPI.svg?style=flat)](https://travis-ci.org/pantuspavel/PPEventRegistryAPI)
[![Coverage Status](https://coveralls.io/repos/github/pantuspavel/PPEventRegistryAPI/badge.svg?branch=master)](https://coveralls.io/github/pantuspavel/PPEventRegistryAPI?branch=master)
[![Version](https://img.shields.io/cocoapods/v/PPEventRegistryAPI.svg?style=flat)](http://cocoapods.org/pods/PPEventRegistryAPI)
[![License](https://img.shields.io/cocoapods/l/PPEventRegistryAPI.svg?style=flat)](http://cocoapods.org/pods/PPEventRegistryAPI)
[![Platform](https://img.shields.io/cocoapods/p/PPEventRegistryAPI.svg?style=flat)](http://cocoapods.org/pods/PPEventRegistryAPI)

# Warning
Pod is not released yet.

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

## Developer Setup

*The following stuff needed:* Xcode 8 Beta 2, [Bundler](http://bundler.io/), [CocoaPods](http://cocoapods.org/).

To open the project:
```bash
git clone git@github.com:pantuspavel/PPEventRegistryAPI.git
cd PPEventRegistryAPI
bundle
pod install
open PPEventRegistryAPI.xcworkspace
```

To open an example project:
```bash
git clone git@github.com:pantuspavel/PPEventRegistryAPI.git
cd PPEventRegistryAPI/Example
bundle
pod install
open PPEventRegistryTest.xcworkspace
```

## Author

Pavel Pantus, pantusp@gmail.com

## License

PPEventRegistryAPI is available under the MIT license. See the LICENSE file for more info.

## Links
- [Accessing Event Registry data through Python](https://github.com/gregorleban/EventRegistry)
