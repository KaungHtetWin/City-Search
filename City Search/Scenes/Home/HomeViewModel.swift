//
//  HomeViewModel.swift
//  City Search
//
//  Created by Kaung Htet Win on 12/5/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelInput {
    var viewWillAppear: PublishSubject<Void> { get }
    var searchText: BehaviorRelay<String> { get }
}

protocol HomeViewModelOutput {
    var city : BehaviorRelay<[HomeModel]> { get }
    var error: BehaviorRelay<String?>  { get }
}

protocol HomeViewModelType {
    var input : HomeViewModelInput { get }
    var output : HomeViewModelOutput { get }
}

class HomeViewModel: HomeViewModelInput, HomeViewModelOutput, HomeViewModelType {
    private let bag = DisposeBag()
    var cityOfflineManagerLogic: CityOfflineManagerLogic!
    // Input
    let viewWillAppear: PublishSubject<Void> = .init()
    let searchText: BehaviorRelay<String> = .init(value: "")
    // Output
    var city: BehaviorRelay<[HomeModel]> = .init(value: [])
    var error: BehaviorRelay<String?> =  .init(value: "")
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
    
    init(service: CityOfflineManagerLogic = CityOfflineManager(fileName: "cities")) {
        self.cityOfflineManagerLogic = service
        searchText
            .flatMapLatest { city in
                service.search(query: city)
        }.map({ [weak self] in
            self?.convertToHomeModel(cities: $0) ?? []
        })
        .subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            self.output.city.accept(data)
        }, onError: { [weak self] err in
            guard let self = self else { return }
            self.output.error.accept(err.localizedDescription)
        })
        .disposed(by: bag)
    }
    
    func convertToHomeModel(cities: [City]) -> [HomeModel] {
        cities.map({
            return HomeModel(city: $0.name, country: $0.country, location: $0.coord)
        })
    }
    
}
