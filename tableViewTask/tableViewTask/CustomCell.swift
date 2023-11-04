//
//  CustomCell.swift
//  tableViewTask
//
//  Created by Асет Тагвай on 03.11.2023.
//


import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    
    private let myImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.layer.cornerRadius = 10
        iv.backgroundColor = UIColor.random
        iv.layer.cornerRadius = 10
        iv.tintColor = .label
        return iv
    }()
     
    private let myLabel : UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let myDot : UIImageView = {
        let image = UIImageView(image: UIImage(named: "ellipsis"))
        image.transform = image.transform.rotated(by: 1.56)
        return image
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with image: UIImage, and label: String){
        myImageView.image = image
        myLabel.text = label
    }
    
}

extension CustomCell {
    
    func setupUI(){
        setupView()
        setupConstraints()
        
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myDot.translatesAutoresizingMaskIntoConstraints = false
    }
    func setupView(){
        contentView.addSubview(myImageView)
        contentView.addSubview(myLabel)
        contentView.addSubview(myDot)
    }
    func setupConstraints(){
        
        myImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerX.equalToSuperview().multipliedBy(0.2)
            make.centerY.equalToSuperview()
        }
        myLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(myImageView.snp.right).offset(20)
        }
        myDot.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1.8)
            make.width.equalTo(25)
            make.height.equalTo(5)
        }
    }
}
    



extension UIColor {
    static var random: UIColor {
        let red = CGFloat.random(in: 0.0...1)
        let green = CGFloat.random(in: 0.0...1)
        let blue = CGFloat.random(in: 0.0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

