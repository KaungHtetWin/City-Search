//
//  ReactiveAppExtension.swift
//  City Search
//
//  Created by Kaung Htet Win on 12/5/23.
//
import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}

extension ObservableType {

    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }
}
