//
//  AirportsCell.swift
//  Airport
//
//  Created by dohg on 10/12/2022.
//

import UIKit

class AirportsCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblRunwayLength: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupData(withViewModel viewModel: AirportsCellViewModelProtocol) {
        lblName.text = viewModel.name
        lblDistance.text = viewModel.distance
        lblRunwayLength.text = viewModel.runwayLength
    }
    
}

extension AirportsCell {
    
    private func setupUI() {
        selectionStyle = .none
    }
    
}
