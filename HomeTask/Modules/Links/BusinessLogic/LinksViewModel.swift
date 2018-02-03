//
//  LinksViewModel.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

class LinksViewModel {
    
    let dataSource: LinksDataSource
    
    init(dataSource: LinksDataSource) {
        self.dataSource = dataSource
    }
    
}

// MARK: - LinksListViewModelProtocol

extension LinksViewModel: LinksViewModelProtocol {
    
    func reloadItems() {

    }
    
    func loadMoreItems() {
        
    }
    
}
