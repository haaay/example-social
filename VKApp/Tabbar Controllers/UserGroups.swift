//
//  UserGroups.swift
//  VKApp
//
//  Created by hayk on 20/05/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit

let AddGroupNotification = Notification.Name(rawValue: "AddGroupNotification")

class UserGroups: UITableViewController {
    
    var groups = [Group]()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.init(nibName: "PageCell", bundle: nil), forCellReuseIdentifier: PageCell.reuseIdentifier)
        
        func realmGroups() -> [Group]? {
            if let groups = objects(Group.self) {
                return Array(groups) as? [Group]
            } else { return nil }
        }
        
        func showRealmGroups() {
            if let realmGroups = realmGroups() {
                self.groups = realmGroups
                self.tableView.reloadData()
            }
        }
        
        showRealmGroups()
        
        apiConnection.getGroups() { (groups) in
            deleteObjects(Group.self)
            saveObjects(groups)
            showRealmGroups()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addGroup(notification:)), name: AddGroupNotification, object: nil)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PageCell.reuseIdentifier, for: indexPath) as? PageCell
            else {
                return UITableViewCell()
        }
        
        let group = groups[indexPath.row]
        cell.pageTitle.text = group.title
        
        cell.setImage(group.imageName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func addGroup(notification: Notification) {
        
        let group = notification.userInfo![AddGroupNotification] as! Group
        
        guard !groups.contains(where: { $0.title == group.title })
            else { return }

        groups.append(group)
        let newIndexPath = IndexPath(item: groups.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }

}
