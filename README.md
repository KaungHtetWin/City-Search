[![Swift Version][swift-image]][swift-url]

# City Search

Populate cities containing around 200k entries in JSON format.
Search city information from provided local file


### Features

- [x] Home
  - User able to filter initial characters of the target string.
- [x] Details
  - When tapped, the User can see the location of that city on a map.


### Technical Specification

The app is written and built with the following hardware and software specification

- XCode Version: Version 14.1 (14B47b)
- macOS Version: macOS Ventra 14.3 (14E222b)
- Swift Version: 5
- Minimum iOS Version: 13.0

### Development Specification

The app is written in UIKit and **MVVM + RxSwift** architecture. **60.3%** Code coverage.
Use **UITableView** for data visualisation. 

## Unit Test
**CityOfflineManager.swift**, main logic implementation, **100%** Code coverage.
**HomeViewControllerTests.swift** test city's cells configuration are showing properly or not. Import **RxTest** to check the implementation **Rx** related function.

### Filter algorithm 

 To improve **Time efficiency** for the filter algorithm, implemented filter by using a binary search algorithm. Need to modify normal exact binary search logic. Our requirement needs to match the initial characters of the target string. We need to remove the data which is already matched.
 ```
if tempCityList[midpoint].name.lowercased().hasPrefix(text.lowercased()) {
  cityList.append(tempCityList[midpoint])
  tempCityList.remove(at: midpoint)
  last = tempCityList.count - 1
}
 ```

## ScreenShots

| City List              | Searched City          | City Details          |
| ---------------------- | ---------------------- | --------------------- |
| ![city-list](/Screenshots/1.png) | ![searched-city](/Screenshots/2.png) | ![city-details](/Screenshots/3.png) 

## Getting Started

This project is written with:
* XCode (13.4.1)
* Swift 5

### Installation
1. Go to the project directory in Terminal
```
cd <Project Directory>
```
2. Run pod install in Terminal
```
pod install
```
3. Open `City Search.xcworkspace`

### Reference

https://www.kodeco.com/


[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
