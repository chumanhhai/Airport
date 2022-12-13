//
//  SearchCityCell.swift
//  Airport
//
//  Created by dohg on 07/12/2022.
//

import UIKit

class SearchCityCell: UITableViewCell {

    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupData(withViewModel viewModel: SearchCityCellViewModelProtocol) {
        lblCity.text = viewModel.city
        lblLocation.text = viewModel.location
    }
    
}

extension SearchCityCell {
    
    private func setupUI() {
        selectionStyle = .none
    }
    
}
