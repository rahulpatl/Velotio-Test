//
//  CoreDataUtils.swift
//  Velotio test
//
//  Created by Rahul Patil on 21/11/22.
//

import UIKit
import CoreData

class CoreDataUtils {
    static let shared = CoreDataUtils()
    
    func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    @discardableResult
    func save<T: NSManagedObject>(data: T) -> Bool {
        guard let managedObject = getContext() else { return false }
        
        do {
            try managedObject.save()
        } catch let error as NSError {
            debugPrint(error)
            return false
        }
        return true
    }
    
    @discardableResult
    func save<T: NSManagedObject>(data: [T]) -> Bool {
        guard let managedObject = getContext() else { return false }
        
        do {
            try managedObject.save()
        } catch let error as NSError {
            debugPrint(error)
            return false
        }
        return true
    }
    
    func get<T: NSManagedObject>(data: T.Type) -> [T]? {
        guard let managedObject = getContext() else {
            return nil
        }
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: data))
        do {
            let results = try managedObject.fetch(fetchReq)
            return results as? [T]
        } catch let error as NSError {
            debugPrint(error)
            return nil
        }
    }
    
    func get<T: NSManagedObject>(for type: T.Type, name: String) -> [T]? {
        guard let managedObject = getContext() else {
            return nil
        }
        
        var fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = T.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", name)
        do {
            let result = try managedObject.fetch(fetchRequest)
            return result as? [T]
        } catch let error as NSError {
            debugPrint(error)
            return nil
        }
    }
    
    func getData<T: NSManagedObject>(for type: T.Type, id: Int) -> T? {
        guard let managedObject = getContext() else {
            return nil
        }
        
        var fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = T.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(id)")
        do {
            let result = try managedObject.fetch(fetchRequest)
            return result.first as? T
        } catch let error as NSError {
            debugPrint(error)
            return nil
        }
    }
    
    func delete<T: NSManagedObject>(data: T) -> Bool {
        guard let managedObject = getContext() else {
            return false
        }
        managedObject.delete(data)
        do {
           try managedObject.save()
            return true
        } catch let error as NSError {
            debugPrint(error)
            return false
        }
    }
}
