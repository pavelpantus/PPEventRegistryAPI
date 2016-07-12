# PPEventRegistryAPI
Swift framework for accessing data in Event Registry (http://eventregistry.org/)

[![CI Status](http://img.shields.io/travis/Pavel Pantus/PPEventRegistryAPI.svg?style=flat)](https://travis-ci.org/Pavel Pantus/PPEventRegistryAPI)
[![Version](https://img.shields.io/cocoapods/v/PPEventRegistryAPI.svg?style=flat)](http://cocoapods.org/pods/PPEventRegistryAPI)
[![License](https://img.shields.io/cocoapods/l/PPEventRegistryAPI.svg?style=flat)](http://cocoapods.org/pods/PPEventRegistryAPI)
[![Platform](https://img.shields.io/cocoapods/p/PPEventRegistryAPI.svg?style=flat)](http://cocoapods.org/pods/PPEventRegistryAPI)

## Warning
Pod is not released yet, because lint fails. Waiting for CocoaPods fix.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Supported API calls

- `Log In`
- `Get Event By Identifier`
- `Get Recent Articles`

## Known Issues

- `Log In` operation does not return `error` in case of bad input (empty email and/or password)

## Requirements

## Installation

PPEventRegistryAPI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PPEventRegistryAPI"
```

## Author

Pavel Pantus, pantusp@gmail.com

## License

PPEventRegistryAPI is available under the MIT license. See the LICENSE file for more info.
