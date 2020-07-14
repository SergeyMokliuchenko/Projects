//
//  FiltersViewController.swift
//  Cocktail DB
//
//  Created by Serhii Mokliuchenko on 11.07.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNavigationBar: NavigationBar!
    
    var viewModel: FiltersViewModelType = FiltersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNavigationBar()
        prepareTableView()
    }
    
    private func loadNavigationBar() {
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        customNavigationBar.delegate = self
        customNavigationBar.filtersButton.isHidden = true
        
        customNavigationBar.leadingConstrain.constant = 70
        customNavigationBar.contentView.layer.shadowRadius = 4.0
        customNavigationBar.contentView.layer.shadowOpacity = 0.6
        
        customNavigationBar.contentView.layer.shadowOffset = CGSize.zero
        customNavigationBar.headerLabel.text = "Filters"
        customNavigationBar.headerLabel.font = UIFont(name: "Roboto-Medium", size: 24)
    }
    
    private func prepareTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib.init(nibName: String(describing: FilterTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FilterTableViewCell.self))
    }
     
    @IBAction func applyButtonAction(_ sender: UIButton) {
        let selected = viewModel.getSelectedCategory()
        self.viewModel.delegate.selectedFilters(sections: selected)
        navigationController?.popViewController(animated: true)
    }
}
    //MARK: TableView Metods
extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilterTableViewCell.self)) as? FilterTableViewCell
        
        guard let tableViewCell = cell else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        tableViewCell.completion = { [unowned self] name in
            self.viewModel.selectedFilter(name: name)
        }
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
    //MARK: NavigationBarDelegate
extension FiltersViewController: NavigationBarDelegate {
    
    func leftAction() {
        navigationController?.popViewController(animated: true)
    }
}
