//
//  AirportsViewModel.swift
//  Airport
//
//  Created by dohg on 10/12/2022.
//

import UIKit
import Differentiator
import RxSwift
import RxDataSources
import RxCocoa

protocol AirportsViewModelProtocol {
    
    typealias AirportSection = SectionModel<Int, AirportsCellViewModelProtocol>
    
    var title: String { get }
    var airportCellIdentifier: String { get }
    var airportSelect: Driver<Airport>! { get }
    
    func setupBinding(table: UITableView)
    
}

class AirportsViewModel: AirportsViewModelProtocol {
    
    let airports: [Airport]
    
    var title: String {
        airports.first?.city ?? ""
    }
    var airportSelect: Driver<Airport>!
    let airportCellIdentifier: String = "airportCell"
    private let disposeBag = DisposeBag()
    
    init(airports: [Airport]) {
        self.airports = airports
    }
    
    func setupBinding(table: UITableView) {
        tableDataSourceBinding(table)
        airportSelectBinding(table)
    }
    
}

extension AirportsViewModel {
    
    private func tableDataSourceBinding(_ table: UITableView) {
        let airportsObservable = Observable.just(airports)
        let currentLocationObservable = LocationService.shared.currentLocaton
        
        let sections = Observable.combineLatest(airportsObservable, currentLocationObservable)
            .map { (airports, currentLocation) in
                airports.map { AirportsCellViewModel(airport: $0, currentLocation: currentLocation) }
            }
            .map { [AirportSection(model: 0, items: $0)]}
            .asDriver(onErrorJustReturn: [])
        let datasource = RxTableViewSectionedReloadDataSource<AirportSection>.init { [weak self] _, table, indexPath, item in
            guard let self = self else { return UITableViewCell() }
            let cell = table.dequeueReusableCell(withIdentifier: self.airportCellIdentifier, for: indexPath) as! AirportsCell
            cell.setupData(withViewModel: item)
            return cell
        }
        sections
            .drive(table.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
    private func airportSelectBinding(_ table: UITableView) {
        airportSelect = table.rx.modelSelected(AirportsCellViewModelProtocol.self)
            .map { [airports] cellViewModel in
                airports.filter { $0.name == cellViewModel.name }.first!
            }
            .asDriver(onErrorJustReturn: Airport())
    }
    
}
