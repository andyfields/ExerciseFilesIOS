//
//  Services.swift
//  HitList
//
//  Created by Andrew Fields on 7/31/18.
//  Copyright © 2018 Andrew Fields. All rights reserved.
//

import Foundation
import CoreData

class DataService {
  
  var people: [NSManagedObject]
  var appDelegate : AppDelegate
  
  init (people: [NSManagedObject], appDelegate : AppDelegate) {
    self.appDelegate = appDelegate
    self.people = people
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
      people.append(person)
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
    
    print ("Saved Person")
  }
}
