//
//  SessionCRUDFunctions.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 11/11/2024.
//

import CoreData
import UIKit

class SessionCRUDFunctions {
    
    static let shared = SessionCRUDFunctions()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).userEntityPersistentContainer.viewContext
    
    var currentUser: UserEntity?
    
    func saveUser(name: String, surname: String, phone: String, email: String) {
        
        let user = UserEntity(context: context)
        user.name = name
        user.surname = surname
        user.phone = phone
        user.email = email
        
        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func fetchUser(withEmail email: String) -> UserEntity? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(fetchRequest)
            print("Fetched users with email \(email): \(users)")
            if let user = users.first {
                currentUser = user
                return user
            }
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
        }
        return nil
    }
    
    func fetchEmail() -> String? {
        return currentUser?.email
    }
    
    func deleteUser(_ user: UserEntity) {
        context.delete(user)
        do {
            try context.save()
            print("User deleted successfully")
        } catch {
            print("Failed to delete user: \(error.localizedDescription)")
        }
    }
}
