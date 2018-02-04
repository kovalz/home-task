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
    
    private let gallery = GalleryService()

    // MARK: IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Private methods -
    
    private func updateUI() {
        if let pictureURL = pictureURL {
            showActivityIndicator()
            imageView.setImage(with: pictureURL) { [weak self] success in
                self?.hideActivityIndicator()
                // TODO: handle failed case
            }
        } else {
            imageView.image = nil
            saveButton.isEnabled = false
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.isHidden = false
        saveButton.isEnabled = false
    }
    
    private func hideActivityIndicator() {
        activityIndicator.isHidden = true
        saveButton.isEnabled = (imageView.image != nil)
    }
    
    // MARK: IBActions
    
    @IBAction private func tapSave() {
        if let image = imageView.image {
            showActivityIndicator()
            gallery.save(image: image) { [weak self] error in
                self?.hideActivityIndicator()
                // TODO: notify user about result
            }
        }
    }
    
}
