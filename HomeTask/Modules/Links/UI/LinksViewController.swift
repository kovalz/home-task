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
    
    var viewModel: LinksViewModelProtocol? {
        didSet {
            if isViewLoaded {
                bindViewModel()
            }
        }
    }
    
    // MARK: - Private Properties -

    // MARK: IBOutlets

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    // MARK: - Private methods -

    private func bindViewModel() {
        viewModel?.items.bind = { [weak self] _, _ in
            self?.tableView.reloadData()
        }
        
        viewModel?.reloadItems()
    }

}

// MARK: - UITableViewDataSource -

extension LinksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            fatalError("LinksViewController: viewModel should exist for creating cell.")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell", for: indexPath) as! LinkCell
        let item = viewModel.items.value[indexPath.row]
        cell.item = item
        return cell
    }
    
}

// MARK: - UITableViewDelegate -

extension LinksViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            fatalError("LinksViewController: viewModel should exist for displaying cell.")
        }
        
        if indexPath.row > viewModel.items.value.count - tableView.visibleCells.count {
            viewModel.loadMoreItems()
        }
    }
    
}

// MARK: - Navigation -

extension LinksViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let cell = (sender as? UIButton)?.linkCell,
            let item = cell.item, let sourceImageURL = item.sourceImageURL,
            let navController = segue.destination as? UINavigationController,
            let viewController = navController.viewControllers.first as? PictureViewController
        else {
            return
        }
        
        viewController.pictureURL = sourceImageURL
    }
    
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {}
    
}
