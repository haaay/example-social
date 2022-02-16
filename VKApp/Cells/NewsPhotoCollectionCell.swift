//
//  NewsPhotoCollectionCell.swift
//  VKApp
//
//  Created by hayk on 17/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

enum Display {
    case Collective
    case Single
}

class NewsPhotoCollectionCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let reuseIdentifier = "collection"
    var photosNames: [String]!
    
    var displayType = Display.Collective {
        didSet {
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                switch displayType {
                case Display.Collective:
                    layout.scrollDirection = .vertical
                case Display.Single:
                    layout.scrollDirection = .horizontal
                }
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
    }
    
    // MARK: - Computed variables
    
    var itemsSequence: [Int] {
        get {
            switch displayType {
            case Display.Collective:
                return partition(for: photosNames.count)
            case Display.Single:
                return [photosNames.count]
            }
        }
    }
    
    func partition(for num: Int) -> [Int] {
        switch num {
        case 1:
            return [1]
        case 2:
            return [2]
        case 3:
            return [1, 2]
        case 4:
            return [2, 2]
        case 5:
            return [1, 2, 2]
        case 6:
            return [2, 2, 2]
        case 7:
            return [2, 2, 3]
        case 8:
            return [2, 3, 3]
        case 9:
            return [3, 3, 3]
        case 10:
            return [3, 3, 4]
        default:
            return [num]
        }
    }
    
    // MARK: - Collection view delegate flow layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat!
        var height: CGFloat!
        
        switch displayType {
        case Display.Collective:
            width = CGFloat.screenWidth / CGFloat(itemsSequence[indexPath.section])
            height = CGFloat.screenWidth / CGFloat(itemsSequence.count)
        case Display.Single:
            width = CGFloat.screenWidth
            height = CGFloat.screenWidth
        }
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Collection view data source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return itemsSequence.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsSequence[section]
    }
    
    func resetCollectionView() {
        guard !photosNames.isEmpty else { return }
        photosNames = []
        collectionView.reloadData()
        collectionView.contentOffset = .zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell
            else { return UICollectionViewCell() }
        
        let index = itemsSequence.prefix(upTo: indexPath.section).reduce(0, +) + indexPath.row
        
        cell.photoImageView.image = UIImage.init(named: photosNames[index])
        
        return cell
    }
    
}
