# SLRDNSConfigurator

[![Actions Status](https://github.com/madsolar8582/SLRDNSConfigurator/workflows/CI/badge.svg)](https://github.com/madsolar8582/SLRDNSConfigurator/actions)
[![License: LGPL v3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)
![Platforms: iOS | macOS | tvOS | watchOS](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey.svg)

Provides convenience methods for configuring [Network Privacy Context](https://developer.apple.com/documentation/network/nw_privacy_context_t?language=objc)s with secure DNS via [DNS over HTTPS](https://en.wikipedia.org/wiki/DNS_over_HTTPS) (DoH) or [DNS over TLS](https://en.wikipedia.org/wiki/DNS_over_TLS) (DoT).

## Table of Contents

- [Getting Started](#getting-started)
  - [Installation](#installation)
    - [Requirements](#requirements)
    - [Swift Package Installation](#swift-package-installation)
    - [Binary Installation](#binary-installation)
    - [Source Installation](#source-installation)
    - [Carthage](#carthage)
    - [CocoaPods](#cocoapods)
  - [Usage](#usage)
- [Contributing](#contributing)
- [Support](#support)
- [License](#license)
- [Changes](#changes)
- [Versioning](#versioning)
- [Release Management](#release-management)

## Getting Started

These instructions will get you up and running with SLRDNSConfigurator.

### Installation

#### Requirements

| Version | Minimum Xcode Version | Minimum macOS SDK | Minimum iOS SDK | Minimum tvOS SDK | Minimum watchOS SDK |
| ------- | --------------------- | ----------------- | --------------- | ---------------- | ------------------- |
| 1.0.0 -> Current | 13.0 | 11.0 | 14.0 | 14.0 | 7.0 |

This library depends on a few system frameworks. If you have Modules and Link Frameworks Automatically enabled, then there isn't much that needs to be done. However, if you do not, you need to link against the `Network`, & `Foundation` frameworks.

#### Swift Package Installation

This is the recommended installation method. Follow the [instructions provided by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using this repository's URL.

#### Binary Installation

You may download the latest binary from the [releases page](https://github.com/madsolar8582/SLRDNSConfigurator/releases) and then include it in your project.

#### Source Installation

If you want to build the library from source in your own project, you can either:

1. Add the project as a [submodule](https://git-scm.com/docs/git-submodule).
2. Add the project as a [subtree](https://www.atlassian.com/blog/git/alternatives-to-git-submodule-git-subtree).
3. Copy the source files directly into your project.

The submodule or subtree approaches are preferred over the copying of source files since you can easily obtain updates.

#### Carthage

If you do not already have [Carthage](https://github.com/Carthage/Carthage) installed, you can install it via [Homebrew](https://brew.sh/):
```bash
brew install carthage
```

Once Carthage is installed, add SLRDNSConfigurator to your `Cartfile`:
```
github "madsolar8582/SLRDNSConfigurator" ~> 1.0.0
```

Finally, run `carthage` and take the resulting `SLRDNSConfigurator.framework` and put it in your project.

#### CocoaPods

If you do not already have [CocoaPods](https://cocoapods.org/) installed, you can install it via [Homebrew](https://brew.sh/) or you can install it via `gem`:
```bash
brew install cocoapods

# OR

sudo gem install cocoapods # Note: sudo is required if you are installing to the system gemset
```

Once CocoaPods is installed, add SLRDNSConfigurator to your `Podfile` or to your `Podspec` as a dependency:
```yaml
# Podfile
pod 'SLRDNSConfigurator', git: 'https://github.com/madsolar8582/SLRDNSConfigurator.git', tag: '1.0.0'

# Podspec
s.dependency 'SLRDNSConfigurator', git: 'https://github.com/madsolar8582/SLRDNSConfigurator.git', tag: '1.0.0'
```

### Usage

To use this library, you just call the APIs provided on `SLRDNSConfigurator`. The default network privacy context is used by `CFNetwork`, `Network.framework`, and `NSURLSession`, which should cover all transactions within the application unless you use custom contexts. If so, there are APIs to modify those custom contexts. 

Which method of secure DNS you want to use is up to you, however, keep in mind that if the network blocks the implementation you choose, DNS will stop working until you change methods or reset the network context to no longer use secure DNS.

```obj-c
@import SLRDNSConfigurator;

// DNS over HTTPS
[SLRDNSConfigurator configureDefaultNetworkContextWithDoHProvider:SLRDoHProviderCloudflare];

// DNS over TLS
[SLRDNSConfigurator configureDefaultNetworkContextWithDoTProvider:SLRDoTProviderCloudflare];

// Reset Network Context
[SLRDNSConfigurator resetDefaultNetworkContext];
```

## Contributing

Please read [CONTRIBUTING](https://github.com/madsolar8582/SLRDNSConfigurator/blob/master/.github/CONTRIBUTING.md) for details on how to contribute.

## Support

Please read [SUPPORT](https://github.com/madsolar8582/SLRDNSConfigurator/blob/master/.github/SUPPORT.md) for details on how to get help with installation or usage.

## License

This project is licensed under the [LGPL v3](https://github.com/madsolar8582/SLRDNSConfigurator/blob/master/LICENSE.md) license.

## Changes

Please read the [CHANGELOG](https://github.com/madsolar8582/SLRDNSConfigurator/blob/master/CHANGELOG.md) for details on the changes included in each release.

## Versioning

This project uses [Semantic Versioning](https://semver.org/) for versioning. For the versions available, see the [releases page](https://github.com/madsolar8582/SLRDNSConfigurator/releases).

## Release Management

This project releases monthly if there are enough changes to warrant a release. However, if there are critical defects or inadvertent non-passive changes, a one-off release will be created for each impacted release series.

After a major version release, the older release series will stop receiving updates after 60 days and are then considered obsolete (and thus unsupported).
