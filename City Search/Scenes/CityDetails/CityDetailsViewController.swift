//
//  CityDetailsViewController.swift
//  City Search
//
//  Created by Kaung Htet Win on 16/5/2566 BE.
//

import UIKit
import MapKit
import RxSwift

class CityDetailsViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private var mapView: MKMapView!
    // MARK: - Dependencies
    private let bag = DisposeBag()
    var city: HomeModel? = nil
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
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
    }
    
    private func setupView() {
        let location = CLLocationCoordinate2D(
            latitude: city?.location?.lat ?? 0,
            longitude: city?.location?.lon ?? 0
        )
        let region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
    
    private func setupBindings() {
    }
    
    deinit {
        print("deinit CityDetailsViewController")
    }
}
