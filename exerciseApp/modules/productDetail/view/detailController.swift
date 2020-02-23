//
//  detailController.swift
//  exerciseApp
//
//  Created by Егор Редько on 23.02.2020.
//  Copyright © 2020 necordu. All rights reserved.
//

import UIKit

class detailController: UIViewController {
    
    var sumLabel: UILabel!
    
    var navTitle: String!
    var arrHistory: [transactionsObject]!
    
    var productTable = UITableView()
    var viewModel: DetailViewModelProtocol?{
        didSet {
            fillUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = DetailViewModel()
        // Do any additional setup after loading the view.
    }
    

    func fillUI() {
        
        viewModel?.parseRates()
        
        self.title = "Trunsactions for \(navTitle!)"
        
        sumLabel = UILabel()
        self.view.addSubview(sumLabel)
        self.view.addSubview(productTable)
        
        
        sumLabel.text = "\(arrHistory.reduce(0) { $0 + Double($1.amount)! })"
        sumLabel.font = UIFont.boldSystemFont(ofSize: 18)
        sumLabel.backgroundColor = UIColor.lightGray
        sumLabel.snp.makeConstraints { (make) in
            let offset  = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
            make.top.equalToSuperview().offset(offset)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview()
        }
        
        productTable.delegate = self
        productTable.dataSource = self
        productTable.register(detailProductCell.self, forCellReuseIdentifier: "detailCell")
        productTable.separatorStyle = .none
        productTable.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(sumLabel.snp.bottom)
        }
        productTable.allowsSelection = false
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension detailController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}

extension detailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: detailProductCell.cellIdentifier, for: indexPath) as! detailProductCell
        
        cell.name.text = (viewModel?.currencyToSign(curr: arrHistory[indexPath.row].currency))! + arrHistory[indexPath.row].amount
        
        cell.result.text = viewModel?.convertTransaction(amount: arrHistory[indexPath.row].amount, currency: arrHistory[indexPath.row].currency)
        
        return cell
        
    }
    
}

class detailProductCell: UITableViewCell {
    
    static let cellIdentifier = "detailCell"
    
    var name = UILabel()
    var result = UILabel()
    var separator = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(name)
        contentView.addSubview(result)
        contentView.addSubview(separator)
        
        name.font = UIFont.systemFont(ofSize: 14)
        name.textColor = UIColor.black
        name.textAlignment = .left
        name.snp.makeConstraints { (make) in
            make.leading.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).offset(20)
            make.height.equalTo(16)
        }
        
        result.font = UIFont.systemFont(ofSize: 14)
        result.textColor = UIColor.gray
        result.textAlignment = .right
        result.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).offset(20)
            make.height.equalTo(16)
        }
        
        separator.backgroundColor = UIColor.lightGray
        separator.snp.makeConstraints { (make) in
            
            make.bottom.equalToSuperview().offset(-1)
            make.leading.equalTo(name.snp.leading)
            make.height.equalTo(1)
            make.width.equalToSuperview()
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

