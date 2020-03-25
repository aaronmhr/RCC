# RCC

> Fetches current exchange rates between diferent currencies

[![Swift Version][swift-image]][swift-url] [![Build Status](https://travis-ci.com/aaronmhr/RCC.svg?branch=master)](https://travis-ci.com/aaronmhr/RCC)

## Screenshots
<img src="Assets/rcc.gif" width="40%" />

## Requirements

<img src="Assets/sketch.png" width="100%"/>

### Initial screen
- [] On first launch should show empty screen
- [] Screen should allow adding new _pairs_
- [] Configured _pairs_ should be persisted between launches
- [] If _pairs_ have been already persisted, they should be shown on launch
- [] Newly configured _pairs_ should be added on top of older ones

### First currency selector
- [] Screen with available currencies is presented modally
- [] The first `main` currencies are __GBP__, __EUR__ and __USD__; and should appear first
- [] `Other` available currencies are to be ordered alphabetically
- [] One can select one and only one currency, 
- [] On selection you are conducted to another screen in order to select its pair currency

### Second currency selector
- [] Screen for selecting the pair of the previous currency is presented
- [] You can select one and only one currency
- [] The order is the same as in the previous screen
- [] The previously selected currency as well as other currencies for wich a pair with the previous currency is already defined can't be selected
- [] On selection the screen is dismissed and you are conducted to the initial screen where the configured _pair_ is shown

## Structure
| Module       | Layer                 | Contains                                   | Dependencies                                     |
|--------------|-----------------------|--------------------------------------------|--------------------------------------------------|
| Converter    | Domain                | Entities, Use Cases, Repository interfaces | Foundation                                       |
| Data         | Data                  | Repositories, Networking, Database         | Foundation, CoreData, Converter                  |
| Presentation | Presentation          | ViewModels, Mappers                        | Foundation, Converter                            |
| RCC          | Composition Root, App | UI, Assemblers                             | Foundation, UIKit, Converter, Data, Presentation |

### Converter
> The feature itself, provides the currencies as well as the business rules that govenr the app.
0. Provides the available currencies for which an __Exchange Pair__ can be created ✅
1. Provides the configured __Exchange Pairs__, e.g.: `GBP-USD`, `EUR-AUD` with the conversions between both currencies. ✅
2. Establishes an update rythm of the data. ✅
3. Provides the rules for the construction of new __Exchange Pairs__. ✅

## Testing Strategy
The testing strategy I wanted to follow was:
Non UIKit dependent (Converter, Data, Presentation): Unit Testing, I originally started using `XCTest` but then i switched to a `Quick` + `Nimble` approach
UIKit dependent (RCC): Snapshot Testing*

*This couldn't be implemented, I managed introduce and use [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) in the app locally, but I wan't able to solve some issues that appeared when passing the CI, so I have this changes in another branch`: `snapshot-testing` and I will try to adress it later.

I couldn't implement all thes I has wanted but the ones included are the more critical and show how I would implement them.  Some parts that I would have liked to test are those interacting with iOS provided frameworks. Te purpose of this test would be no to test the frameworks themselves but the fact that we are using them correctly.

_DefaultHTTPClient_ has not been tested but in order to do so I would have used a dependency that inherited from the abstract class __URLProtocol__ in order to intercept the system requests and not to depend on a real backend.

_CoreDataLocalStore_ I have not much experience using `CoreData`, but as with `Realm` the right way to test it would be providing a "testing configuration" that doesn't write to disk but just stores the data in memory because its faste. Integration tests could also have been added that test that in fact the code is working properly,  but this would have to be done in another scheme that is not run in the day to day TDD process because it could become a little bit cumbersome.

UseCases, ViewModels, as they depend on abstractions testing them becomes a trivial but time consuming task, the way to do it is replacing/capture behaviour of their dependencies with mocks, stubs, spies.

A difference between MVVM and VIPER is that in VIPER the most relevant aspects of the views are mediated by protocols, so its not very difficult to Unit-test them. Thats one of the reasons why I wanted to introduce SnapShot testing, jjust to have this extra layer of security. 

## Other
- Swift 5
- iOS 12.0+

## Meta

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
