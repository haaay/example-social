//
//  GlobalGroupList.swift
//  VKApp
//
//  Created by hayk on 20/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

class GlobalGroupList: UIViewController, UITableViewDelegate, UITableViewDataSource, NiceSearchBarDelegate, UIGestureRecognizerDelegate {
    
    //MARK: - Variables
    
    @IBOutlet weak var tableView: UITableView!
    
    var groups = [Group]()
    var searchBar: NiceSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.init(nibName: "PageCell", bundle: nil), forCellReuseIdentifier: PageCell.reuseIdentifier)
        
        self.setupTableHeaderSearchBar()
    }
    
    //MARK: - Search Bar Setup
    
    func setupTableHeaderSearchBar() {
        
        let tableHeaderView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: .screenWidth, height: 50)))
        
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
        
        func searchGroups(for query: String) {
            apiConnection.searchGroups(for: query) { (groups) in
                self.groups = groups
            }
        }
        
        preciseQuery.count > 0 ? searchGroups(for: preciseQuery) : groups.removeAll()
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PageCell.reuseIdentifier, for: indexPath) as? PageCell
            else {
                return UITableViewCell()
        }
        
        let group = groups[indexPath.row]
        cell.pageTitle.text = group.title
        
        cell.setImage(group.imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let group = groups[indexPath.row]
        
        NotificationCenter.default.post(name: AddGroupNotification, object: nil, userInfo: [AddGroupNotification: group])
        
        self.navigationController?.viewControllers.removeLast()
    }

    // MARK: - Tool Methods
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}
