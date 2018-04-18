//
//  ViewController.swift
//  AssignCoinEption
//
//  Created by Shivang Pandey on 29/03/18.
//  Copyright © 2018 Shivang Pandey. All rights reserved.
//

import UIKit
import CoreData
class AddUserVC: UIViewController {
    @IBOutlet weak var emailtxt: UITextField!
    
    @IBOutlet weak var dobtxt: UITextField!
    @IBOutlet weak var nametxt: UITextField!
    
    var appDelegate:AppDelegate?
    var dbcontext:NSManagedObjectContext?
    var newUser:NSManagedObject?
    var entity:NSEntityDescription?
    var datepickerDilodVC:DatePickerDilogVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        dbcontext = appDelegate?.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Person", in: dbcontext!)
        datepickerDilodVC = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerDilogVC") as? DatePickerDilogVC
        datepickerDilodVC?.datepickerDelegate = self
        nametxt.becomeFirstResponder()
        
        nametxt.delegate = self
        emailtxt.delegate = self
        nametxt.tag = 0
        emailtxt.tag = 1
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveUser(_ sender: UIButton) {
        let name = nametxt.text ?? ""
        let email = emailtxt.text ?? ""
        let dob = dobtxt.text ?? ""
        if name != "" && email != "" && dob != ""{
            newUser = NSManagedObject(entity: entity!, insertInto: dbcontext)
            newUser?.setValue(name, forKey: "name")
            newUser?.setValue(email, forKey: "email")
            newUser?.setValue(dob, forKey: "dob")
            do{
                try dbcontext?.save()
                let emptyAlert = UIAlertController(title: "Person Added!!!", message: nil, preferredStyle: .alert)
                let okaction = UIAlertAction(title: "Ok", style: .default, handler: {
                    Void in
                    self.nametxt.text = ""
                    self.emailtxt.text = ""
                    self.dobtxt.text = ""
                    self.nametxt.becomeFirstResponder()
                })
                emptyAlert.addAction(okaction)
                self.present(emptyAlert, animated: true, completion: nil)
            }catch{
                print("faild to saving",error.localizedDescription)
            }
        }else {
            let emptyAlert = UIAlertController(title: "Please fill all fileds..", message: nil, preferredStyle: .alert)
            let okaction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            emptyAlert.addAction(okaction)
            self.present(emptyAlert, animated: true, completion: nil)
            
        }
    }
}
extension AddUserVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == emailtxt{
            if (isValidEmail(testStr: textField.text ?? "")){
                textField.resignFirstResponder()
                if let datepickervc = datepickerDilodVC {
                    self.present(datepickervc, animated: true, completion: nil)
                }
            }else {
                let emptyAlert = UIAlertController(title: "Invalid Email", message: nil, preferredStyle: .alert)
                let okaction = UIAlertAction(title: "Ok", style: .default, handler: {
                    Void in
                    textField.becomeFirstResponder()
                })
                emptyAlert.addAction(okaction)
                self.present(emptyAlert, animated: true, completion: nil)
            }
        }else {
            if textField.text != "" {
                if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                    nextField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }else{
                let emptyAlert = UIAlertController(title: "Name can't empty!!!", message: nil, preferredStyle: .alert)
                let okaction = UIAlertAction(title: "Ok", style: .default, handler: {
                    _ in
                    textField.becomeFirstResponder()
                })
                emptyAlert.addAction(okaction)
                self.present(emptyAlert, animated: true, completion: nil)
            }
        }
        return false
    }
}
extension AddUserVC:DatePickerDelegate{
    func datePicked(datestr: String) {
        dobtxt.text = datestr
    }
}

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
