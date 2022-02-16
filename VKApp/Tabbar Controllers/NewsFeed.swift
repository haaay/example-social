//
//  NewsFeed.swift
//  VKApp
//
//  Created by hayk on 17/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class NewsFeed: UITableViewController {
    
    enum NewsBlock: Int {
        case Page
        case Text
        case Photos
        case Activity
    }
    
    var newsList: [News] = [
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560846600), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news.jpg"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148),
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560857400), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news0.jpg", "news1.jpg"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148),
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560857400), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news0.jpg", "news1.jpg", "news2.jpg"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148),
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560857400), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news0.jpg", "news1.jpg", "news2.jpg", "news3.jpg"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148),
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560857400), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news0.jpg", "news1.jpg", "news2.jpg", "news3.jpg", "news4.jpg"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148),
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560857400), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news0.jpg", "news1.jpg", "news2.jpg", "news3.jpg", "news4.jpg", "news5.jpeg"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148),
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560857400), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news0.jpg", "news1.jpg", "news2.jpg", "news3.jpg", "news4.jpg", "news5.jpeg", "news6.jpg"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148),
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560857400), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news0.jpg", "news1.jpg", "news2.jpg", "news3.jpg", "news4.jpg", "news5.jpeg", "news6.jpg", "news7.png"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148),
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560857400), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news0.jpg", "news1.jpg", "news2.jpg", "news3.jpg", "news4.jpg", "news5.jpeg", "news6.jpg", "news7.png", "news8.jpeg"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148),
        News(source: Public(title: "Apple", imageName: "group0.jpg"), date: Date(timeIntervalSince1970: 1560857400), text: "Разработчикам стали доступны вторые бета-версии ОС 13 для смартфонов, планшетов и TV, ОС 6 для часов и ОС «Каталина».", photos: ["news0.jpg", "news1.jpg", "news2.jpg", "news3.jpg", "news4.jpg", "news5.jpeg", "news6.jpg", "news7.png", "news8.jpeg", "news9.jpeg"], likesCount: 15, isLiked: true, commentsCount: 3, sharesCount: 2, viewsCount: 148)
    ]
    
    var imageViewingType: Int!
    
    enum ImageViewing: Int {
        case Entirely = 0
        case HorizontalCollection = 1
        case HorizontalViews = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         imageViewingType = navigationController?.tabBarItem.tag ?? ImageViewing.Entirely.rawValue
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .groupTableViewBackground
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let screenWidth = CGFloat.screenWidth
        
        func textHeight() -> CGFloat {
            
            let freeVerticalSpace: CGFloat = 10
            let freeHorizontalSpace: CGFloat = 32
            
            let viewWidth = screenWidth - freeHorizontalSpace
            let font = UIFont.systemFont(ofSize: 16)
            
            let news = newsList[indexPath.section]
            
            return heightForLabelText(news.text, withViewWidth: viewWidth, font: font) + freeVerticalSpace
        }
        
        switch indexPath.row {
        case NewsBlock.Page.rawValue:
            return 70
        case NewsBlock.Text.rawValue:
            return textHeight()
        case NewsBlock.Photos.rawValue:
            return screenWidth
        case NewsBlock.Activity.rawValue:
            return 45
        default:
            return 44
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let news = newsList[indexPath.section]
        let sourcePage = news.source
        
        func pageCell() -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PageCell.reuseIdentifier, for: indexPath) as? PageCell
                else { return UITableViewCell() }
            
            cell.pageImageView.image = UIImage(named: sourcePage.imageName)
            cell.pageTitle.text = sourcePage.title
            cell.newsTime.text = dateDescription(news.date)
            
            return cell
        }
        
        func textCell() -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.reuseIdentifier, for: indexPath) as? NewsTextCell
                else { return UITableViewCell() }
            
            cell.textLb.text = news.text
            
            return cell
        }
        
        func photosCell() -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCollectionCell.reuseIdentifier, for: indexPath) as? NewsPhotoCollectionCell
                else { return UITableViewCell() }
            
            cell.displayType = Display.Collective
            cell.photosNames = news.photos
            
            return cell
        }
        
        func photosCell2() -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCollectionCell.reuseIdentifier, for: indexPath) as? NewsPhotoCollectionCell
                else { return UITableViewCell() }
            
            cell.displayType = Display.Single
            cell.photosNames = news.photos
            
            return cell
        }
        
        func photosCell3() -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.reuseIdentifier, for: indexPath) as? NewsPhotoCell
                else { return UITableViewCell() }
            
            cell.photosNames = news.photos
            
            return cell
        }
        
        func activityCell() -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsActivityCell.reuseIdentifier, for: indexPath) as? NewsActivityCell
                else { return UITableViewCell() }
            
            cell.likeControl.likesCount = news.likesCount
            cell.likeControl.isLiked = news.isLiked
            
            cell.commentControl.commentsCount = news.commentsCount
            cell.shareControl.sharesCount = news.sharesCount
            cell.viewsCounter.viewsCount = news.viewsCount
            
            return cell
        }
        
        func photoCell() -> UITableViewCell {
            
            var photoCell = UITableViewCell()
            
            switch imageViewingType {
            case ImageViewing.Entirely.rawValue:
                photoCell = photosCell()
            case ImageViewing.HorizontalCollection.rawValue:
                photoCell = photosCell2()
            case ImageViewing.HorizontalViews.rawValue:
                photoCell = photosCell3()
            default:
                photoCell = photosCell()
            }
            
            return photoCell
        }
        
        switch indexPath.row {
        case NewsBlock.Page.rawValue:
            return pageCell()
        case NewsBlock.Text.rawValue:
            return textCell()
        case NewsBlock.Photos.rawValue:
            return photoCell()
        case NewsBlock.Activity.rawValue:
            return activityCell()
        default:
            return UITableViewCell()
        }
        
    }

}
