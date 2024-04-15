//
//  CVCellImage.swift
//  SplashList
//
//  Created by Tushar on 13/04/24.
//

import UIKit

class CVCellImage: UICollectionViewCell {
    
    @IBOutlet weak var imgCell: UIImageView!
    var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCell.contentMode = .scaleAspectFill
        imgCell.clipsToBounds = true
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        contentView.addSubview(activityIndicator)
    }

    func configure(with photo: UnsplashPhoto) {
        imgCell.tag = photo.id.hashValue
        imgCell.image = UIImage(named: "errorImg")
        activityIndicator.startAnimating()
        
        if let cachedImage = ImageCachingManager.shared.getImage(url: photo.urls.small) {
            imgCell.image = cachedImage
            activityIndicator.stopAnimating()
        } else {
            WebService.shared.getData(url: photo.urls.small) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                        case .success(let data):
                            if let image = UIImage(data: data) {
                                self.imgCell.image = image
                                ImageCachingManager.shared.saveImage(url: photo.urls.small, image: image)
                                self.activityIndicator.stopAnimating()
                            } else {
                                // Handle case when data cannot be converted to UIImage
                                self.activityIndicator.stopAnimating()
                            }
                        case .failure(let error):
                            // Handle failure case
                        self.imgCell.image = UIImage(named: "errorImg")
                            print("Error loading image: \(error.localizedDescription)")
                            self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
}
