//
//  AllDataViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 21.11.2022.
//

import UIKit

class AllDataViewController: BaseController {
    
    let tableViewProducts : UITableView = {
        let table = UITableView()
//        table.register(self, forCellReuseIdentifier: "cell")
        return table
    }()
}

extension AllDataViewController {
    
    override func setupViews() {
        super.setupViews()
        setDelegate()
        view.addViewWithoutTAMIC(tableViewProducts)
    }
    
    override func constraintViews() {
        super.constraintViews()
    }
    
    override func configureAppereance() {
        super.configureAppereance()
        view.backgroundColor = R.Color.background
        title = "Все продажи"
        navigationController?.tabBarItem.title = R.TabBar.title(for: Tabs.allData)
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        tableViewProducts.backgroundColor = .red

    }

}

//MARK: - UITableViewDelegate and UITableViewDataSource
extension AllDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setDelegate(){
        self.tableViewProducts.delegate = self
        self.tableViewProducts.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewProducts.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "TEST"
        return cell
    }

}
