//
//  FriendsList.swift
//  VKApp
//
//  Created by hayk on 20/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class FriendsList: UIViewController, UITableViewDelegate, UITableViewDataSource, NiceSearchBarDelegate, UIGestureRecognizerDelegate {
    
    //MARK: - Variables
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableTrailing: NSLayoutConstraint!
    @IBOutlet weak var pointer: Pointer!
    
    var searchBar: NiceSearchBar!
    var groupedFriends = [[User]]()
    
    var friends = [User]()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PageCell", bundle: nil), forCellReuseIdentifier: PageCell.reuseIdentifier)
        
        self.setupTableHeaderSearchBar()
        
        func realmFriends() -> [User]? {
            if let friends = objects(User.self) {
                return Array(friends) as? [User]
            } else { return nil }
        }
        
        func showRealmFriends() {
            if let realmFriends = realmFriends() {
                
                self.friends = realmFriends
                
                self.sortFriends(&self.friends)
                self.setupPointerGroupFriends(self.friends)
                
                self.tableView.reloadData()
            }
        }
        
        showRealmFriends()

        apiConnection.getFriends() { (friends) in
            deleteObjects(User.self)
            saveObjects(friends)
            showRealmFriends()
        }
    }
    
    //MARK: - Search Bar Setup
    
    func setupTableHeaderSearchBar() {
        
        let tableWidth = CGFloat.screenWidth - tableTrailing.constant
        
        let tableHeaderView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: tableWidth, height: 50)))
        
        searchBar = NiceSearchBar(frame: tableHeaderView.bounds)
        searchBar.delegate = self
        
        tableHeaderView.addSubview(searchBar)
        tableView.tableHeaderView = tableHeaderView
    }
    
    //MARK: - Gesture Recognizer Delegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == searchBar.cancel as UIView? ? false : true
    }
    
    //MARK: - Search Bar Delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: NiceSearchBar) {
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        hideKeyboardGesture.delegate = self
        view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: NiceSearchBar) {
        hideKeyboard()
        view.gestureRecognizers?.forEach { view.removeGestureRecognizer($0) }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: NiceSearchBar) {
        hideKeyboard()
    }
    
    func searchBar(_ searchBar: NiceSearchBar, textDidChange searchText: String) {
        
        var filteredFriends: [User]
        
        var preciseQuery = searchText
        let singleSpace: Character = " "
        let doubleSpace = "  "
        
        while preciseQuery.first == singleSpace {
            preciseQuery.removeFirst()
        }
        
        while preciseQuery.last == singleSpace {
            preciseQuery.removeLast()
        }
        
        while preciseQuery.contains(doubleSpace) {
            preciseQuery = preciseQuery.replacingOccurrences(of: doubleSpace, with: singleSpace.toString)
        }
        
        if preciseQuery.count > 0 {
            
            func containsSearchText(_ string: String) -> Bool {
                return string.lowercased().contains(preciseQuery.lowercased())
            }
            
            filteredFriends = friends.filter { (user) -> Bool in
                containsSearchText(user.name) || containsSearchText(user.surname) || containsSearchText(user.name.concatenating(user.surname)) || containsSearchText(user.surname.concatenating(user.name))
            }
        } else {
            filteredFriends = friends
        }
        
        setupPointerGroupFriends(filteredFriends)
        tableView.reloadData()
    }
    
    //MARK: - Pointer
    
    func surnameInitialOf(_ user: User) -> String {
        guard let surnameFirst = user.surname.first else { return "" }
        return surnameFirst.uppercased()
    }
    
    func sortFriends(_ friends: inout [User]) {
        friends.sort { (user0, user1) -> Bool in
            surnameInitialOf(user0) < surnameInitialOf(user1)
        }
    }
    
    func setupPointerGroupFriends(_ friends: [User]) {
        
        var letters = [String]()
        
        groupedFriends.removeAll()
        
        for user in friends {
            
            let surnameInitial = surnameInitialOf(user)
            
            if !letters.contains(surnameInitial) {
                letters.append(surnameInitial)
                groupedFriends.append([user])
            } else {
                
                var lastGroup = groupedFriends.last!
                lastGroup.append(user)
                
                groupedFriends.removeLast()
                groupedFriends.append(lastGroup)
            }
        }
        
        pointer.letters = letters
        pointer.setNeedsDisplay()
        
        pointer.addTarget(self, action: #selector(pointSelected), for: .valueChanged)
    }
    
    @objc func pointSelected() {
        
        hideKeyboard()
        
        let section = pointer.letters.firstIndex(of: pointer.selectedLetter!)!
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = tableView.backgroundColor
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        alphaTransformСonversion(for: cell.contentView, withAlpha: 1, transform: .identity, usingAnimation: !searchBar.isFirstResponder)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        alphaTransformСonversion(for: cell.contentView, withAlpha: 0, transform: CGAffineTransform(scaleX: 0.5, y: 0.5), usingAnimation: !searchBar.isFirstResponder)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return pointer.letters[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedFriends.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let friends = groupedFriends[section]
        return friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PageCell.reuseIdentifier, for: indexPath) as? PageCell
            else {
                return UITableViewCell()
            }
        
        let friends = groupedFriends[indexPath.section]
        let friend = friends[indexPath.row]
        
        cell.pageImageView.image = UIImage()
        
        cell.setImage(friend.imageName)
        
        cell.pageTitle.text = friend.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showFriendPhoto", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let photoController = segue.destination as? PhotoController,
            let indexPath = tableView.indexPathForSelectedRow {
            
            let friends = groupedFriends[indexPath.section]
            let uid = friends[indexPath.row].id
            
            apiConnection.getProfilePhotos(of: uid) { (photos) in
                guard let photo = photos.first else { return }
                
                apiConnection.getImage(photo.url) { (image) in
                    photoController.images = [image]
                }
            }
        }
    }
    
    // MARK: - Animations
    
    func alphaTransformСonversion(for view: UIView, withAlpha alpha: CGFloat, transform: CGAffineTransform, usingAnimation: Bool) {
        
        func сonversion() {
            view.alpha = alpha
            view.transform = transform
        }
        
        usingAnimation ? UIView.animate(withDuration: 0.5, animations: { сonversion() }, completion: nil) : сonversion()
    }
    
    // MARK: - Tool Methods
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

}
