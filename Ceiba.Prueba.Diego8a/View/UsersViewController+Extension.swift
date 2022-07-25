//
//  UsersViewController+Extension.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 25/07/22.
//

import Foundation
import UIKit

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            if filteredUsers.count == 0 {
                showAlert(message: "List is empty")
            }
            return filteredUsers.count
        } else {
            return users.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var user = User()
        if searching {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.setCell(user: user)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user = User()
        if searching {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        let vc = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
        //performSegue(withIdentifier: "DetailsSegue", sender: user)
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searching = false
            usersTableView.reloadData()
        } else {
            filteredUsers = users.filter({ (user) -> Bool in
                (user.name?.contains(searchText))!
            })
            searching = true
            usersTableView.reloadData()
        }
    }
}


