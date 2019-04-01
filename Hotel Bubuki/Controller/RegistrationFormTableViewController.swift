//
//  RegistrationFormTableViewController.swift
//  Hotel Bubuki
//
//  Created by Igor Shelginskiy on 11/20/18.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit

class RegistrationFormTableViewController: UITableViewController, SelectRoomDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var adultCountText: UILabel!
    @IBOutlet weak var childCountText: UILabel!
    
    @IBOutlet weak var adultStep: UIStepper!
    @IBOutlet weak var childStep: UIStepper!
    
    @IBOutlet weak var wifiValue: UISwitch!
    @IBOutlet weak var wifiCost: UILabel!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
    var roomType: RoomType?
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let midnight = Calendar.current.startOfDay(for: Date())
            checkInDatePicker.minimumDate = midnight
            checkInDatePicker.date = midnight
            updateDateViews()
    }
  
    func updateDateViews(){
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RoomTypeCell" {
            let destination = segue.destination as? SelectRoomTableViewController
            destination?.delegate = self
            destination?.roomType = roomType
        }
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let adultCount = Int(adultStep.value)
        let childCount = Int(childStep.value)
        let wifi = wifiValue.isOn
        guard let roomType = roomType else { return }
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            emaiAdress: email,
            checkInDate: checkInDate,
            checkOutdate: checkOutDate,
            numberOfChildren: childCount,
            numberOfAdult: adultCount,
            roomType: roomType,
            wifi: wifi)
        print(registration)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func adultStepper(_ sender: UIStepper) {
        adultCountText.text = String(Int(adultStep.value))
    }
    
    @IBAction func childStepper(_ sender: UIStepper) {
        childCountText.text = String(Int(childStep.value))
    }
    
    @IBAction func wifiSwitch(_ sender: UISwitch) {
        wifiCost.text = wifiValue.isOn ? "10" : "0"
    }
    
    func updateRoomType() {
        roomTypeLabel.text = roomType?.name ?? "Not selected"
    }
    func didSelect(roomtype: RoomType) {
        self.roomType = roomtype
        updateRoomType()
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath:
            if isCheckInDatePickerShown {
                return 216
            } else {
                return 0
            }
        case checkOutDatePickerIndexPath:
            if isCheckOutDatePickerShown {
                return 216
            } else {
                return 0
            }
        default: return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == checkOutDatePickerIndexPath.section || indexPath.section == checkOutDatePickerIndexPath.section else { return }
        
        switch indexPath.row {
        case checkInDatePickerIndexPath.row - 1:
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        case checkOutDatePickerIndexPath.row - 1:
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default: break
        }
    }
    @IBAction func unwindBack(segue: UIStoryboardSegue){
        guard segue.identifier == "SaveRoomSegue" else { return }
    }
    
}


