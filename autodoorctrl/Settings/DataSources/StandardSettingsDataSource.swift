//
//  StandardSettingsDataSource.swift
//  autodoorctrl
//
//  Created by Jing Wei Li on 10/4/19.
//  Copyright © 2019 Jing Wei Li. All rights reserved.
//

import UIKit

class StandardSettingsDataSource: NSObject {
    let userInfoIdentifer = "userInfoCell"
    let actionIdentifier = "dashboardActionCell"
    
    let sectionTitles = [NSLocalizedString("myInfoTitle", comment: ""),
                         NSLocalizedString("supportTitle", comment: "")]
    let firstSectionCount = 2
    let secondSectionCount = 4
    
    let supportTitles = [NSLocalizedString("contactFixxTitle", comment: "")]
    
    lazy var sectionCounts: [Int] = {
        return [2, supportTitles.count]
    }()
    
    func loadCells(from indexPath: IndexPath) -> (String, String?, UIImage?) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return ("RCSID", User.current.rcsID, nil)
            } else if indexPath.row == 1 {
                return ("Status", User.current.isActive ? "Active" : "Inactive", nil)
            }
        } else if indexPath.section == 1 {
            return (supportTitles[indexPath.row], nil, UIImage(named: "wrenchIcon"))
        }
        return ("", nil, nil)
    }
}

extension StandardSettingsDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCounts[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let identifier = indexPath.section == 0 ? userInfoIdentifer : actionIdentifier
        
        cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let title: String, subtitle: String?, image: UIImage?
        (title, subtitle, image) = loadCells(from: indexPath)
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        cell.imageView?.image = image
        return cell
    }
}

