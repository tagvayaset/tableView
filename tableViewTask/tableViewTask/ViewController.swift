//
//  ViewController.swift
//  tableViewTask
//
//  Created by Асет Тагвай on 01.11.2023.
//

import UIKit
import SnapKit


struct Sections {
    let sectionTitle : String
    var todos: [String]
    var images: [UIImage]
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
    }
    
    private lazy var sections : [Sections] = [
        Sections(sectionTitle: "TO DO (\(notCompleted.count))", todos: notCompleted, images: icons1),
        Sections(sectionTitle: "COMPLETED (\(completed.count ))", todos: completed, images: icons2),
        Sections(sectionTitle: "READY (\(ready.count ))", todos: ready, images: icons3)
    ]
    
    private lazy var notCompleted : [String] = {
        let task = ["Exercise", "Cooking", "Coding", "Yoga", "Drawing", "Gardening", "Swimming", "Running"]
        return task
    }()
    private lazy var completed : [String] = {
        var task = ["Playing a Musical Instrument", "Learning Something New", "Photography", "Volunteering", "Hacking"]
        return task
    }()
    private lazy var ready: [String] = {
        var task = ["Listening to Music", "Writing", "Painting", "Dancing", "Hiking", "Singing", "Watching a Movie"]
        return task
    }()
    
    private lazy var icons1: [UIImage] = [
        UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,
        UIImage(named: "5")!,UIImage(named: "6")!,UIImage(named: "7")!,UIImage(named: "8")!
        ]
    private lazy var icons2: [UIImage] = [
        UIImage(named: "9")!,UIImage(named: "10")!,UIImage(named: "11")!,UIImage(named: "12")!,
        UIImage(named: "13")!]
    private lazy var icons3: [UIImage] = [UIImage(named: "14")!,UIImage(named: "15")!,UIImage(named: "16")!,UIImage(named: "17")!,UIImage(named: "18")!,UIImage(named: "19")!,UIImage(named: "20")!
    ]
    
    // TOP
    
    private lazy var todoLabel : UILabel = {
        var label = UILabel()
        label.text = "To Do List"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    private lazy var countLabel : UILabel = {
        var label = UILabel()
        label.text = "\(notCompleted.count) tasks, \(completed.count) completed"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()
    private lazy var topIcons: [UIImageView] = {
        var iv = [UIImageView]()
        iv.append(UIImageView(image: UIImage(named: "calendar")))
        iv.append(UIImageView(image: UIImage(named: "search")))
        return iv
    }()
    private lazy var topView : UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // DAYS
    
    private lazy var buttonView : UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        return view
    }()
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("YESTERDAY", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("TODAY (\(notCompleted.count))", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    private lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle("TOMORROW", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        button.tag = 3
        return button
    }()
    
    @objc func tapped(_ sender: UIButton){
        switch sender.tag {
            case 1:
                button1.setTitleColor(.white, for: .normal)
                button1.backgroundColor = .black
                button2.setTitleColor(.darkGray, for: .normal)
                button2.backgroundColor = .none
                button3.setTitleColor(.darkGray, for: .normal)
                button3.backgroundColor = .none
            case 2:
                button2.setTitleColor(.white, for: .normal)
                button2.backgroundColor = .black
                button1.setTitleColor(.darkGray, for: .normal)
                button1.backgroundColor = .none
                button3.setTitleColor(.darkGray, for: .normal)
                button3.backgroundColor = .none
            default:
                button3.setTitleColor(.white, for: .normal)
                button3.backgroundColor = .black
                button2.setTitleColor(.darkGray, for: .normal)
                button2.backgroundColor = .none
                button1.setTitleColor(.darkGray, for: .normal)
                button1.backgroundColor = .none
        }
    }
    // TableView
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        
        tableView.register(CellHeader.self, forHeaderFooterViewReuseIdentifier: CellHeader.identifier)
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier )
        return tableView
    }()
    
    
    private lazy var floatingButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        button.layer.masksToBounds = true
        button.backgroundColor = .black
        let image = UIImage(systemName: "plus", withConfiguration:
                            UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 35
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 90,
                                      y: view.frame.size.height - 90,
                                      width: 70,
                                      height: 70
         )
    }
    
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setupUI(){
        setupView()
        setupConstrains()
    }
    func setupView(){
        view.addSubview(topView)
        topView.addSubview(countLabel)
        topView.addSubview(todoLabel)
        topView.addSubview(topIcons[0])
        topView.addSubview(topIcons[1])
        
        
        view.addSubview(buttonView)
        buttonView.addSubview(button1)
        buttonView.addSubview(button2)
        buttonView.addSubview(button3)
        
        view.addSubview(tableView)
        
        view.addSubview(floatingButton)
    }
    func setupConstrains(){
        
        topView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(7)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        todoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
        }
        countLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(todoLabel.snp.bottom).offset(4)
        }
        topIcons[0].snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.bottom.equalTo(countLabel.snp.top)
            make.centerX.equalToSuperview().multipliedBy(0.2)
        }
        
        topIcons[1].snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.bottom.equalTo(countLabel.snp.top)
            make.centerX.equalToSuperview().multipliedBy(1.8)
        }
        
        
        buttonView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.height.equalToSuperview().dividedBy(15)
        }
        button2.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.5)
        }
        button1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(button2.snp.left).offset(-10)
            make.width.equalToSuperview().dividedBy(3.5)
        }
        button3.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(button2.snp.right).offset(10)
            make.width.equalToSuperview().dividedBy(3.5)
        }
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(buttonView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellHeader.identifier) as? CellHeader else {
            fatalError("Fatal Error")
        }
        let headerTitle = sections[section].sectionTitle
        
        header.configure(with: headerTitle)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 50
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {fatalError("TableView couldn't dequeue CustomCell in VC")}
        
        let image = sections[indexPath.section].images[indexPath.row]
        cell.configure(with: image, and: sections[indexPath.section].todos[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
     
}

