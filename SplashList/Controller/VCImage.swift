//
//  ViewController.swift
//  SplashList
//
//  Created by Tushar on 13/04/24.
//

import UIKit

class VCImage: UIViewController {
    
    var photos = [UnsplashPhoto]()
    var currentPage = 1
    var isMoreDataLoading = false
    
    @IBOutlet weak var cvList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvList.dataSource = self
        cvList.delegate = self
        cvList.prefetchDataSource = self
        configureCollectionView()
        setupRefreshControl()
        fetchPhotos()
    }

    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 5
        let screenWidth = UIScreen.main.bounds.width
        let numberOfColumns: CGFloat = screenWidth > 600 ? 4 : 3
        let totalPadding: CGFloat = padding * (numberOfColumns + 1)
        let availableWidth = screenWidth - totalPadding
        let itemWidth = availableWidth / numberOfColumns

        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)  // Assuming square cells
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding

        cvList.collectionViewLayout = layout
    }

    func fetchPhotos(completion: (() -> Void)? = nil) {
        guard !isMoreDataLoading else { return }
        isMoreDataLoading = true

        if !NetworkManager.shared.isNetworkAvailable() {
            Toast.show(message: "No internet connection", controller: self)
            isMoreDataLoading = false
            completion?()
            return
        }

        ShowActivityIndicator(uiView: self.view)
        UnsplashService().fetchPhotos(page: currentPage, perPage: 30) { result in
            HideActivityIndicator(uiView: self.view)
            self.isMoreDataLoading = false
            switch result {
            case .success(let photos):
                self.photos.append(contentsOf: photos)
                self.cvList.reloadData()
                self.currentPage += 1
            case .failure(let error):
                print("Failed to fetch photos: \(error)")
                Toast.show(message: "Unable to fetch photos", controller: self)
            }
            completion?()
        }
    }

}

extension VCImage: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvList.dequeueReusableCell(withReuseIdentifier: "CVCellImage", for: indexPath) as! CVCellImage
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
}

extension VCImage: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let needsFetch = indexPaths.contains { $0.row >= self.photos.count - 10 }
        if needsFetch && !isMoreDataLoading {
            fetchPhotos()
        }
    }
}

extension VCImage {
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        cvList.refreshControl = refreshControl
    }
    
    @objc func refreshData() {
        
        currentPage = 1
        photos.removeAll()
        fetchPhotos { [weak self] in
            self?.cvList.refreshControl?.endRefreshing()
        }
    }
}
