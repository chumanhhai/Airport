//
//  SearchCityViewModel.swift
//  Airport
//
//  Created by dohg on 06/12/2022.
//

import RxSwift
import RxRelay
import Differentiator
import RxCocoa
import RxDataSources

protocol SearchCityViewModelProtocol {
    
    typealias CitySection = SectionModel<Int, SearchCityCellViewModelProtocol>
    var cityCellIdentifier: String { get }
    var citySelect: Driver<[Airport]>! { get set }
    
    func setupBinding(tfSearchCity: UITextField, table: UITableView)
    func fetchAirports()
    
}

class SearchCityViewModel: SearchCityViewModelProtocol {
    
    private let airportService: AirportServiceProtocol
    
    var airports: BehaviorRelay<[Airport]> = .init(value: [])
    private let disposeBag = DisposeBag()
    let cityCellIdentifier: String = "cityCell"
    var citySelect: Driver<[Airport]>!
    
    init(airportService: AirportServiceProtocol) {
        self.airportService = airportService
    }
    
    func setupBinding(tfSearchCity: UITextField, table: UITableView) {
        tableViewBinding(tfSearchCity: tfSearchCity, table: table)
        citySelectBinding(table: table)
    }
    
    func fetchAirports() {
        airportService.getAirports()
            .subscribe(onSuccess: { [weak self] in
                if let airports = $0 {
                    self?.airports.accept(airports)
                }
            })
            .disposed(by: disposeBag)
    }
    
}

extension SearchCityViewModel {
    
    private func getUniqueArrayOfCityViewModel(withAirports airports: [Airport]) -> [SearchCityCellViewModelProtocol] {
        var uniqueViewModels = Set<SearchCityCellViewModel>()
        let viewModels = airports.map { SearchCityCellViewModel(fromAirport: $0) }
        for viewModel in viewModels {
            uniqueViewModels.insert(viewModel)
        }
        return Array(uniqueViewModels)
    }
    
    private func tableViewBinding(tfSearchCity: UITextField, table: UITableView) {
        // search city textfield
        let searchTextFieldObservable = tfSearchCity.rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler())
            .distinctUntilChanged()
            .asObservable()
        let airportsObservable = airports
            .skip(1)
            .asObservable()
        let citySections = Observable.combineLatest(searchTextFieldObservable, airportsObservable) { text,      airports in
            airports.filter { $0.city.lowercased().hasPrefix(text.lowercased())}
        }
        .map { [weak self] in
            self?.getUniqueArrayOfCityViewModel(withAirports: $0) ?? []
        }
        .map { [CitySection(model: 0, items: $0)] }
        .asDriver(onErrorJustReturn: [])
        let dataSource = RxTableViewSectionedReloadDataSource<CitySection>.init(configureCell: { [weak self] _, tableView, indexPath, item in
            guard let self = self else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cityCellIdentifier, for: indexPath) as! SearchCityCell
            cell.setupData(withViewModel: item)
            return cell
        })
        citySections
            .drive(table.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func citySelectBinding(table: UITableView) {
        citySelect = table.rx.modelSelected(SearchCityCellViewModelProtocol.self)
            .withLatestFrom(airports) { cellViewModel, airports in
                airports.filter { $0.city == cellViewModel.city }
            }
            .asDriver(onErrorJustReturn: [])
    }
}
