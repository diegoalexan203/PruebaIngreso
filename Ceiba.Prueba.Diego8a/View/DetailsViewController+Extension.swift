//
//  DetailsViewController+Extension.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 25/07/22.
//

import Foundation
import UIKit

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellTableViewCell") as! PostCellTableViewCell
        cell.setCell(post: post)
        return cell
    }
}
