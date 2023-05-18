//
//  CityOfflineManager.swift
//  City Search
//
//  Created by Kaung Htet Win on 12/5/23.
//

import Foundation
import RxSwift

protocol CityOfflineManagerLogic {
    func getCityList() -> Single<[City]>
    func search(query: String) -> Observable<[City]>
}

class CityOfflineManager: CityOfflineManagerLogic {
    
    static let shared = CityOfflineManager()
    private let bag = DisposeBag()
    private var city: [City] = []
    
    init() {
        city = loadJson(filename: "cities")?
            .sorted(by: { $0.name < $1.name }) ?? []
    }
    
    func getCityList() -> Single<[City]> {
        return Single.create { [weak self] event -> Disposable in
            guard let self = self else { return Disposables.create() }
            event(.success(self.city))
            return Disposables.create()
        }
    }
    
    func search(query: String) -> Observable<[City]> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create() }
            let result = self.binarySearch(text: query)
            observer.onNext(result)
            return Disposables.create()
        }
    }
    
    private func loadJson(filename fileName: String) -> [City]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([City].self, from: data)
                return jsonData
            } catch {
                print("error:\(error.localizedDescription)")
            }
        }
        return nil
    }
    
    func binarySearch(text: String) -> [City] {
        if text.isEmpty { return city }
        var tempCityList = city
        var cityList: [City] = []
        var first = 0
        var last = city.count - 1
        while first <= last {
            let midpoint = (first + last)/2
            if tempCityList[midpoint].name.lowercased().hasPrefix(text.lowercased()) {
                cityList.append(tempCityList[midpoint])
                tempCityList.remove(at: midpoint)
            } else if tempCityList[midpoint].name.lowercased() > text.lowercased() {
                last = midpoint - 1
            } else {
                first = midpoint + 1
            }
        }
        return cityList
    }
}
