//
//  EProductsView.swift
//  exerciseApp
//
//  Created by Егор Редько on 23.02.2020.
//  Copyright © 2020 necordu. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class EProductsView: UIViewController {
    
    var viewModel: EProductsViewModelProtocol?{
        didSet {
            fillUI()
        }
    }
    let productsTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = EProductsViewModel()
        // Do any additional setup after loading the view.
    }
    
    func fillUI() {
        
        self.title = "Products"
        
        self.view.addSubview(productsTable)
        productsTable.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        productsTable.allowsSelection = false
        
        
    }
    

}

extension EProductsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
}

extension EProductsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EProductsCell.cellIdentifier, for: indexPath) as! EProductsCell
        
        
        
        return cell
        
    }
    
}

class EProductsCell: UITableViewCell {
    
    static let cellIdentifier = "productsCell"
    
    let name = UILabel()
    let count = UILabel()
    let separator = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(name)
        contentView.addSubview(count)
        
        name.font = UIFont.systemFont(ofSize: 14)
        name.textColor = UIColor.black
        name.textAlignment = .left
        name.snp.makeConstraints { (make) in
            make.leading.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(16)
        }
        
        count.font = UIFont.systemFont(ofSize: 14)
        count.textColor = UIColor.gray
        count.textAlignment = .right
        count.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
