//
//  PersonTableViewController.swift
//  ADD_USER
//
//  Created by Shivang Pandey on 30/03/18.
//  Copyright © 2018 Shivang Pandey. All rights reserved.
//

import UIKit
import CoreData
class PersonTableViewController: UITableViewController {
    var personList:[PersonData] = []
    
    var appDelegate:AppDelegate?
    var dbcontext:NSManagedObjectContext?
    var entity:NSEntityDescription?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.shared.delegate as? AppDelegate
        dbcontext = appDelegate?.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Person", in: dbcontext!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        personList.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.returnsObjectsAsFaults = false
        do {
            let result:[NSManagedObject] = try dbcontext?.fetch(request) as! [NSManagedObject]
            if result.count != 0 {
                for data in result {
                    let name = data.value(forKey: "name") as? String
                    let email = data.value(forKey: "email") as? String
                    let dob = data.value(forKey: "dob") as? String
                    let person = PersonData(name: name, email: email, dob: dob)
                    self.personList.append(person)
                }
            self.tableView.reloadData()
            print("person count",personList.count)
            }
            
        } catch  {
            print("faild",error.localizedDescription)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonListCell", for: indexPath) as! PersonListCell
        let person = personList[indexPath.row]
        cell.name.text = person.name ?? "Not Found"
        cell.email.text = person.email ?? "Not Found"
        cell.dob.text = person.dob ?? "Not Found"
        // Configure the cell...
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
class PersonListCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var dob: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(true, animated: true)
    }
}
