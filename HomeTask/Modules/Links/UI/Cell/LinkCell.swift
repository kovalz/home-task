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
    @IBOutlet private weak var thumbnailContainer: UIView!
    @IBOutlet private weak var thumbnailButton: UIButton!

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
        thumbnailButton.isEnabled = false
    }
    
    // MARK: - Private methods -

    private func updateUI() {
        guard let item = item else {
            return
        }
        
        titleLabel.text = item.title
        infoLabel.text = "submitted " + item.creationDate.hoursAgoString + " by " + item.author
        
        if item.commentsCount == 1 {
            commentsLabel.text = "\(item.commentsCount) comment"
        } else {
            commentsLabel.text = "\(item.commentsCount) comments"
        }
        
        if let thumbnailURL = item.thumbnailURL {
            thumbnailContainer.isHidden = false
            thumbnailTask = thumbnailImageView?.setImage(with: thumbnailURL)
        } else {
            thumbnailContainer.isHidden = true
        }
        
        thumbnailButton.isEnabled = (item.sourceImageURL != nil)
    }
    
}

// MARK: - UIView + LinkCell -

extension UIView {
    
    var linkCell: LinkCell? {
        var view: UIView? = self
        while view != nil {
            if let cell = view?.superview as? LinkCell {
                return cell
            }
            
            view = view?.superview
        }
        return nil
    }
    
}

