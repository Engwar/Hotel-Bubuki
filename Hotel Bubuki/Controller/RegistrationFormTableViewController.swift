//
//  RegistrationFormTableViewController.swift
//  Hotel Bubuki
//
//  Created by Igor Shelginskiy on 11/20/18.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit

class RegistrationFormTableViewController: UITableViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    
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
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
    
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
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
    
}
