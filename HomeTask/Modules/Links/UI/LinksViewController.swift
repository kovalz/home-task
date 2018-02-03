//
//  LinksViewController.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import UIKit

class LinksViewController: UIViewController {

    // MARK: - Public Properties -
    
    var viewModel: LinksViewModelProtocol!
    
    // MARK: - Private Properties -

    // MARK: IBOutlets

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()

        viewModel.reloadItems()
    }
    
    // MARK: - Private methods -

    private func setupBinding() {
        viewModel.items.bind = { [weak self] _, _ in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {}

}

// MARK: - UITableViewDataSource -

extension LinksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell", for: indexPath) as! LinkCell
        let item = viewModel.items.value[indexPath.row]
        cell.item = item
        return cell
    }
    
}

extension LinksViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > viewModel.items.value.count - tableView.visibleCells.count {
            viewModel.loadMoreItems()
        }
    }
    
}

