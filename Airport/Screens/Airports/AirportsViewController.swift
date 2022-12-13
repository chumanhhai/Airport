//
//  AirportsViewController.swift
//  Airport
//
//  Created by dohg on 10/12/2022.
//

import UIKit
import RxCocoa

class AirportsViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    private let viewModel: AirportsViewModelProtocol
    var routingBuilder: ((Driver<Airport>) -> Void)?
    
    init(viewModel: AirportsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: AirportsViewController.self),
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        routingBuilder?(viewModel.airportSelect)
    }
    
}

extension AirportsViewController {
    
    private func setupUI() {
        title = viewModel.title
        table.register(UINib(nibName: String(describing: AirportsCell.self), bundle: nil),
                       forCellReuseIdentifier: viewModel.airportCellIdentifier)
    }
    
    private func setupBinding() {
        viewModel.setupBinding(table: table)
    }
    
}
