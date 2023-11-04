//
//  CellHeader.swift
//  tableViewTask
//
//  Created by Асет Тагвай on 04.11.2023.
//

import UIKit
import SnapKit

class CellHeader: UITableViewHeaderFooterView {

    static let identifier = "CellHeader"
     
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    public func configure(with title: String){
        label.text = title
        setupUI()
    }
}
extension CellHeader {
    func setupUI(){
        setupView()
        setupConstraints()
        
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    func setupView(){
        self.addSubview(label)
    }
    func setupConstraints(){ 
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.4) 
        }
    }
}
