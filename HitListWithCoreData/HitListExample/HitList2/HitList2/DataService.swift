//
//  DataService.swift
//  HitList2
//
//  Created by Andrew Fields on 8/4/18.
//  Copyright © 2018 Andrew Fields. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class DataService: NSObject {
  
  var people: [NSManagedObject]?
  var appDelegate : AppDelegate
  
  init (appDelegate : AppDelegate) {
    self.appDelegate = appDelegate
  }
  
  func loadPeople() {
    
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
  
  func savePerson(name: String) {
    
    // 1
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    // 2
    let entity =
      NSEntityDescription.entity(forEntityName: "Person",
                                 in: managedContext)!
    
    let person = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    // 3
    person.setValue(name, forKeyPath: "name")
    
    // 4
    do {
      try managedContext.save()
      people!.append(person)
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
    
    print ("Saved Person " + name)
  }
  
  func peopleCount() -> Int {
    return people!.count
  }
  
  func getPerson(idx: Int) -> NSManagedObject {
    return people![idx]
  }

}
