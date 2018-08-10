//
//  ViewController.swift
//  HitList
//
//  Created by Andrew Fields on 7/22/18.
//  Copyright © 2018 Andrew Fields. All rights reserved.
//

import UIKit
import CoreData

// HisList2


class ViewController: UIViewController {
  
  var dataService: DataService?
  
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    print ("viewDidLoad 2")
    
    title = "The List"
    tableView.register(UITableViewCell.self,
                       forCellReuseIdentifier: "Cell")

    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    self.dataService = DataService(appDelegate: appDelegate)
  
  }
  
  // This will load managed data from core data.  Else nothing will appear!
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    dataService!.loadPeople()
    
   }

  //@IBAction func addName(_ sender: Any) {
  // Implement the addName IBAction
  @IBAction func addName(_ sender: UIBarButtonItem) {
    
    let alert = UIAlertController(title: "New Name",
                                  message: "Add a new name",
                                  preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save",
                                   style: .default) {
                                    [unowned self] action in  // "in" used in anonymous functions.
                                    
                                    guard let textField = alert.textFields?.first,
                                      let nameToSave = textField.text else {
                                        return
                                    }
                                    
                                    self.save(name: nameToSave)
                                    self.tableView.reloadData()
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .default)
    
    alert.addTextField()
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
         present(alert, animated: true)
    
  }
  
  func save(name: String) {
    
    self.dataService!.savePerson(name: name)
    
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return dataService!.peopleCount()
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
      
      let row = indexPath.row
      let person = dataService!.getPerson(idx: row)
      let cell =
        tableView.dequeueReusableCell(withIdentifier: "Cell",
                                      for: indexPath)
      cell.textLabel?.text =
        person.value(forKeyPath: "name") as? String
      return cell
  }
}
