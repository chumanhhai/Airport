//
//  AirportDetailViewController.swift
//  Airport
//
//  Created by dohg on 13/12/2022.
//

import UIKit

class AirportDetailViewController: UIViewController {

    @IBOutlet weak var lblAirportName: UILabel!
    
    private let viewModel: AirportDetailViewModelProtocol
    
    init(withViewModel viewModel: AirportDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: AirportDetailViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }

}

extension AirportDetailViewController {
    
    private func setupData() {
        lblAirportName.text = viewModel.airportName
    }
    
}
