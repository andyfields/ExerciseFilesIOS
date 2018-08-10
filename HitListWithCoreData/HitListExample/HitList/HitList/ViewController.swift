//
//  ViewController.swift
//  HitList
//
//  Created by Andrew Fields on 7/22/18.
//  Copyright © 2018 Andrew Fields. All rights reserved.
//
// Hitlist

import UIKit
import CoreData
import DataService

class ViewController: UIViewController {
  
  var people: [NSManagedObject] = []
  var dataService: DataService
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    print ("viewDidLoad")
    
    title = "The List"
    tableView.register(UITableViewCell.self,
                       forCellReuseIdentifier: "Cell")
    
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    self.dataService = DataService(people, appDelegate)
  
  }
  
  // This will load managed data from core data.  Else nothing will appear!
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    //1
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    //2
    let fetchRequest =
      NSFetchRequest<NSManagedObject>(entityName: "Person")
    
    //3
    do {
      people = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
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
    
    self.dataService.savePerson(name: name)
    
//    guard let appDelegate =
//      UIApplication.shared.delegate as? AppDelegate else {
//        return
//    }
//
//    // 1
//    let managedContext =
//      appDelegate.persistentContainer.viewContext
//
//    // 2
//    let entity =
//      NSEntityDescription.entity(forEntityName: "Person",
//                                 in: managedContext)!
//
//    let person = NSManagedObject(entity: entity,
//                                 insertInto: managedContext)
//
//    // 3
//    person.setValue(name, forKeyPath: "name")
//
//    // 4
//    do {
//      try managedContext.save()
//      people.append(person)
//    } catch let error as NSError {
//      print("Could not save. \(error), \(error.userInfo)")
//    }
  }
}
  

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
      
      let person = people[indexPath.row]
      let cell =
        tableView.dequeueReusableCell(withIdentifier: "Cell",
                                      for: indexPath)
      cell.textLabel?.text =
        person.value(forKeyPath: "name") as? String
      return cell
  }
}
