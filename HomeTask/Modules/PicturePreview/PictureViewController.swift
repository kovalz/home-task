//
//  PictureViewController.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {

    // MARK: - Public Properties -
    
    var pictureURL: URL? {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    
    // MARK: - Private Properties -
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Private methods -
    
    private func updateUI() {
        if let pictureURL = pictureURL {
            imageView.setImage(with: pictureURL)
        } else {
            imageView.image = nil
        }
    }
    
}
