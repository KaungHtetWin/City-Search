//
//  HomeViewController.swift
//  City Search
//
//  Created by Kaung Htet Win on 12/5/23.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var searchBarTextField: UISearchBar!
    @IBOutlet weak var tblCity: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    // MARK: - Dependencies
    private let bag = DisposeBag()
    var viewModel: HomeViewModel!
    // MARK: Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    // MARK: Setup
    private func setup() {
        title = "City"
        let viewController = self
        let vm = HomeViewModel(service: CityOfflineManager(fileName: "cities"))
        viewController.viewModel = vm
    }
    
    private func setupView() {
        tblCity.register(CityCell.nib, forCellReuseIdentifier: CityCell.className)
        tblCity.rowHeight = UITableView.automaticDimension
    }
    
    private func setupBindings() {
        let city = viewModel.output.city
        city
            .map({ "Total: \($0.count)" })
            .bind(to: totalLabel.rx.text)
            .disposed(by: bag)
        
        city.bind(to: tblCity.rx.items(cellIdentifier: CityCell.className, cellType: CityCell.self)) { (_, model, cell) in
            cell.config(data: model)
        }.disposed(by: bag)
        
        searchBarTextField.rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .bind(to: viewModel.input.searchText)
            .disposed(by: bag)
        
        viewModel.output.error
            .skip(1)
            .filter { ($0 != nil) }
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(with: error ?? "")
            }).disposed(by: bag)
        
        tblCity.rx.modelSelected(HomeModel.self)
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                let vc = UIStoryboard.cityDetailsViewController()
                vc?.city = model
                vc?.title = model.city
                self.navigationController?.pushViewController(vc!, animated: true)
            })
            .disposed(by: bag)
        
    }
}
