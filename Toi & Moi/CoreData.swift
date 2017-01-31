//
//  CoreData.swift
//  test
//
//  Created by Michel Garlandat on 22/01/2017.
//  Copyright © 2017 Michel Garlandat. All rights reserved.
//

import Foundation
import CoreData

var context:NSManagedObjectContext?


func sauvegarde(objet:NSManagedObject, nom: String, date: String, quoi: String, prix: Double) {
    // definir la valeur de chaque attribut
    
    //let nouveauTodo = NSEntityDescription.insertNewObject(forEntityName: "Activites", into: context!)
    objet.setValue(nom, forKey: "nom")
    objet.setValue(date, forKey: "date")
    objet.setValue(quoi, forKey: "quoi")
    objet.setValue(prix, forKey: "prix")
    
    // Sauvegarde NSManagedObject
    
    do {
        try context?.save()
        print("(\(objet) sauvegardée) avec succes")
    } catch {
        print("erreur sauvegarde CoreData")
    }
    
}


///delete all the data in core data
func cleanCoreData() {
    
    let fetchRequest:NSFetchRequest<Activites> = Activites.fetchRequest()
    
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
    
    do {
        print("deleting all contents")
        try context?.execute(deleteRequest)
    }catch {
        print(error.localizedDescription)
    }
    
}

