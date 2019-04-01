//
//  SelectRoomTableViewController.swift
//  Hotel Bubuki
//
//  Created by Igor Shelginskiy on 12/4/18.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit

class SelectRoomTableViewController: UITableViewController {
    
    var roomType: RoomType?
    var delegate: SelectRoomDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RoomType.room.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
        let roomType = RoomType.room[indexPath.row]
        
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "\(roomType.price) $"
        cell.accessoryType = roomType == self.roomType ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        roomType = RoomType.room[indexPath.row]
        delegate?.didSelect(roomtype: roomType!)
        tableView.reloadData()
    }


}
protocol SelectRoomDelegate {
    func didSelect(roomtype: RoomType)
}
