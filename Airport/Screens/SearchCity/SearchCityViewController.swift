//
//  SearchCityViewController.swift
//  Airport
//
//  Created by dohg on 06/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

class SearchCityViewController: UIViewController {

    @IBOutlet weak var tfSearchCity: UITextField!
    @IBOutlet weak var table: UITableView!
    
    private let viewModel: SearchCityViewModelProtocol
    var routingBuilder: ((Driver<[Airport]>) -> Void)?
    private let disposeBag = DisposeBag()
    
    init(viewModel: SearchCityViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: SearchCityViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Airports"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        viewModel.fetchAirports()
        routingBuilder?(viewModel.citySelect)
    }

}

extension SearchCityViewController {
    
    private func setupUI() {
        table.register(UINib(nibName: String(describing: SearchCityCell.self), bundle: nil),
                       forCellReuseIdentifier: viewModel.cityCellIdentifier)
    }
    
    private func setupBinding() {
        // viewModel binding
        viewModel.setupBinding(tfSearchCity: tfSearchCity, table: table)
    }
    
}
