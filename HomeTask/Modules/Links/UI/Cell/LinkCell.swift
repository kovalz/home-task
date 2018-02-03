//
//  LinkCell.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import UIKit

class LinkCell: UITableViewCell {

    // MARK: - Public Properties -
    
    var item: LinkItem? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Private Properties -
    
    private var thumbnailTask: URLSessionTask?
    
    // MARK: IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        infoLabel.text = nil
        commentsLabel.text = nil
        
        thumbnailTask?.cancel()
        thumbnailTask = nil
        thumbnailImageView.image = nil
    }
    
    // MARK: - Private methods -

    private func updateUI() {
        guard let item = item else {
            return
        }
        
        titleLabel.text = item.title
        infoLabel.text = item.author
        commentsLabel.text = "\(item.commentsCount)"
        
        if let thumbnailURL = item.thumbnailURL {
            thumbnailTask = thumbnailImageView?.setImage(with: thumbnailURL)
        }

    }
    
}
