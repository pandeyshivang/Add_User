//
//  DatePickerDilogVC.swift
//  ADD_USER
//
//  Created by Shivang Pandey on 30/03/18.
//  Copyright © 2018 Shivang Pandey. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
    func datePicked(datestr:String)
}


class DatePickerDilogVC: UIViewController {
    var datepickerDelegate:DatePickerDelegate?
    @IBOutlet weak var datepicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        datepicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let selectedDate = dateFormatter.string(from: datepicker.date)
        datepickerDelegate?.datePicked(datestr: selectedDate)
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
