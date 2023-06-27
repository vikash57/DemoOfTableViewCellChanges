//
//  DataBaseHelper.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 14/06/23.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static var shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object : [String:String]){
        let user = NSEntityDescription.insertNewObject(forEntityName: "RegisterUser", into: context!) as! RegisterUser
        
        user.name = object["name"]
        user.mobile = object["mobile"]
        user.email = object["email"]
        user.password  = object["password"]
        do{
            try context?.save()
        }catch{
            print("data is not save")
        }
    }
    
    func getUserData() -> [RegisterUser] {
        var userData = [RegisterUser]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RegisterUser")
        do{
            userData = try context?.fetch(RegisterUser.fetchRequest()) as! [RegisterUser]
            //var data = userData as! [RegisterUser]
            
        }catch{
            print("can not get data")
        }
        
        return userData
    }
    
    func deleteData(index : Int)-> [RegisterUser] {
        
        var user = getUserData()
        context?.delete(user[index])
        user.remove(at: index)
        do{
            try context?.save()
        }catch{
            print("can not delete data")
        }
        return user
    }
    
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RegisterUser")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context?.execute(batchDeleteRequest)
            try context?.save()
        } catch {
            print("Error deleting data: \(error)")
        }
    }
   
    func editData(obj:[String:String], i:Int) {
        let user = getUserData()
        user[i].password = obj["password"]
        do{
            try context?.save()
        }catch{
            print("password is not saved")
        }
        
    }
}
