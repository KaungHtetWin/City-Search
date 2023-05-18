[![Swift Version][swift-image]][swift-url]

# City Search

Populate cities containing around 200k entries in JSON format.
Search city information from provided local file


### Features

- [x] Home
    - User able to filter initial characters of the target string.
- [x] Details
    - When tapped, User able to see the location of that city on a map.


### Technical Specification

The app is written and built with this following hardware and sofware specification

- XCode Version : Version 14.1 (14B47b)
- macOS Version: macOS Ventra 14.3 (14E222b)
- Swift Version: 5
- Minium iOS Version : 13.0

### Development Specification

The app is written in UIKit and **MVVM + RxSwift** architecture. **60.3%** Code coverage.
Use **UITableView** for data visualisation. 

## Unit Test
**CityOfflineManager.swift**, main logic implementation, **100%** Code coverage.
**HomeViewControllerTests.swift** test city's cells configuartion are show properly or not. Import **RxTest** to check implementation **Rx** related function.

### Filter algorithm 

 To improve Time efficiency for filter algorithm, implemented filter by using binary search algorithm. Need to modification normal exact binary search logic. Our requirement need to matches the initial characters of the target string. We need to remove the data which is already match.
 ```
if tempCityList[midpoint].name.lowercased().hasPrefix(text.lowercased()) {
    cityList.append(tempCityList[midpoint])
    tempCityList.remove(at: midpoint)
    last = tempCityList.count - 1
}
 ```

## ScreenShots
![](/Screenshots/Simulator Screenshot - iPhone 14 Pro - 2023-05-18 at 11.17.37.png)
![](/Screenshots/Simulator Screenshot - iPhone 14 Pro - 2023-05-18 at 11.17.42.png)
![](/Screenshots/Simulator Screenshot - iPhone 14 Pro - 2023-05-18 at 11.17.49.png)

## Getting Started

This project is written with:
* XCode (13.4.1)
* Swift 5

### Installation
1. Go to project directory in Terminal
```
cd <Your Downloaded Project Directory>
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
