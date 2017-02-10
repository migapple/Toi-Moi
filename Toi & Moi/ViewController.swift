//
//  ViewController.swift
//  Toi & Moi
//
//  Created by Michel Garlandat on 18/01/2017.
//  Copyright © 2017 Michel Garlandat. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase
import Firebase

var toi:String = ""
var moi:String = ""

struct postStuct {
    let nom:String
    let date:String
    let quoi:String
    let prix:Double
    let uniqueUserID:String
}

var ref:FIRDatabaseReference?
var databaseHandle:FIRDatabaseHandle?

var postData = [String:AnyObject]()
var posts = [postStuct]()

var prixToi: [Double] = []
var prixMoi: [Double] = []
var totalToi:Double = 0
var totalMoi:Double = 0



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var nbToiLabel: UILabel!
    @IBOutlet weak var totToiLabel: UILabel!
    @IBOutlet weak var nbMoiLabel: UILabel!
    @IBOutlet weak var totMoiLabel: UILabel!
    @IBOutlet weak var toiTitre: UILabel!
    @IBOutlet weak var moiTitre: UILabel!
    @IBOutlet weak var maTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Récupération des settings
        
        func registerSettings() {
            let appDefaults = [String:AnyObject]()
            UserDefaults.standard.register(defaults: appDefaults)
            UserDefaults.standard.synchronize()
        }
        
        registerSettings()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDisplayFromDefaults()
        
        FIRApp.configure()
        let databaseRef = FIRDatabase.database().reference()
        
        //post()
        
        databaseRef.child("activite").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            // on doit faire un cast de snapshot.value de Any to an NSDictionnary
            let snapshotValue = snapshot.value as? NSDictionary
            
            let uniqueUserID = snapshot.key
            let nom  = snapshotValue?["nom"] as? String
            let date = snapshotValue?["date"] as? String
            let quoi = snapshotValue?["quoi"] as? String
            let prix = snapshotValue?["prix"] as? Double
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal

            
            // posts.insert(postStuct(nom: nom!, date: date!, quoi: quoi!, prix: prix!,uniqueUserID: uniqueUserID), at: 0)
             self.chargePosts(nom: nom!, date: date!, quoi: quoi!, prix: prix!, uniqueUserID: uniqueUserID)
        })
    }
    
    func chargePosts(nom: String, date: String, quoi: String, prix: Double, uniqueUserID: String) {
        posts.insert(postStuct(nom: nom, date: date, quoi: quoi, prix: prix,uniqueUserID: uniqueUserID), at: 0)
        
        if (nom == toi) {
            prixToi.insert(prix, at: 0)
        }
        
        if (nom == moi) {
            prixMoi.insert(prix, at: 0)
        }

        miseAjourTotal()
   }
   
    func post() {
        
        let nom = "MIG"
        let date = "02/01/2017"
        let quoi = "Courses"
        let prix = 20.15
        
        let  post :[String: AnyObject] = ["nom": nom as AnyObject,"date":date as AnyObject,"quoi":quoi as AnyObject,"prix":prix as AnyObject]
        
        let databaseRef = FIRDatabase.database().reference()
        
        // post data
        databaseRef.child("activite").childByAutoId().setValue(post)
    }

    
    @IBAction func trashButton(_ sender: UIBarButtonItem) {
        
        
        let alertController:UIAlertController = UIAlertController(title: "Supression des données !", message: "Voulez-vous vraiment supprimer toutes les données ?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Non, annuler", style: .cancel) { action -> Void in
            // don't do anything
        }
        
        let nextAction = UIAlertAction(title: "Oui", style: .default) { action -> Void in
            let ref = FIRDatabase.database().reference()
            ref.child("activite").removeValue()
            posts.removeAll()
            prixToi = []
            prixMoi = []
            
            self.maTableView.reloadData()
            self.miseAjourTotal()
         }
        
        alertController.addAction(cancelAction)
        alertController.addAction(nextAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func miseAjourTotal() {
        
        // on filtre les TOI
        let postToi = posts.filter { (postStuct:postStuct) -> Bool in
            return postStuct.nom == toi
        }

        // on totalise les TOI
        totalToi = postToi.reduce(0, {
            return $0 + $1.prix
        })
        
        // on filtre les MOI
        let postMoi = posts.filter { (postStuct:postStuct) -> Bool in
            return postStuct.nom == moi
        }
        
        // on totalise les TOI
        totalMoi = postMoi.reduce(0, {
            return $0 + $1.prix
        })
        
        nbToiLabel.text = "\(postMoi.count)"
        nbMoiLabel.text = "\(postToi.count)"
     
        totToiLabel.text = NSString(format:"%.2f€", totalToi) as String
        totMoiLabel.text = NSString(format:"%.2f€", totalMoi) as String

        self.maTableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK - Gestion de la TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // Calcule le nombre de lignes à afficher
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return posts.count
    }
    
    // affiche la cellule
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        //let task = tasks[indexPath.row]
        let post = posts[indexPath.row]
        print (post)
//        cell.affiche(task: task)
        cell.affiche2(post: post)
        return cell
    }
    
    // Suppression d'une ligne
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //on récupère l'uniqueID
            let uniqueID = posts[indexPath.row].uniqueUserID
            
            // on prend la référence de la base
            let ref = FIRDatabase.database().reference()
            
            // on suprime cette activité de uniqueID
            ref.child("activite/\(uniqueID)").removeValue()
            
            // Supprime l'élément du tableau
            posts.remove(at: indexPath.row)
            
            // on efface la ligne du tableau
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }

            miseAjourTotal()
            maTableView.reloadData()
    }
    
    
    func updateDisplayFromDefaults(){
        
         //Get the defaults
         let defaults = UserDefaults.standard
         
         //Set the controls to the default values.
        
        if let activiteSetup = defaults.string(forKey: "moi_0") {
            moi  = activiteSetup
        } else {
            moi   = ""
        }
        if let activiteSetup = defaults.string(forKey: "toi_0") {
            toi  = activiteSetup
        } else {
            toi  = ""
        }
        
        toiTitre.text = toi
        moiTitre.text = moi
        
         if let activiteSetup = defaults.string(forKey: "activite_0") {
         activite[0]  = activiteSetup
         } else {
         activite[0]  = ""
         }
    
         if let activiteSetup = defaults.string(forKey: "activite_1") {
         activite[1]  = activiteSetup
         } else {
         activite[1]  = ""
         }
         
         if let activiteSetup = defaults.string(forKey: "activite_2") {
         activite[2]  = activiteSetup
         } else {
         activite[2]  = ""
         }
         
         if let activiteSetup = defaults.string(forKey: "activite_3") {
         activite[3]  = activiteSetup
         } else {
         activite[3]  = ""
         }
         
         if let activiteSetup = defaults.string(forKey: "activite_4") {
         activite[4]  = activiteSetup
         } else {
         activite[4]  = ""
         }
         
         if let activiteSetup = defaults.string(forKey: "activite_5") {
         activite[5]  = activiteSetup
         } else {
         activite[5]  = ""
         }
         
         if let activiteSetup = defaults.string(forKey: "activite_6") {
         activite[6]  = activiteSetup
         } else {
         activite[6]  = ""
         }
         
         if let activiteSetup = defaults.string(forKey: "activite_7") {
         activite[7]  = activiteSetup
         } else {
         activite[7]  = ""
         }
         
         if let activiteSetup = defaults.string(forKey: "activite_8") {
         activite[8]  = activiteSetup
         } else {
         activite[8]  = ""
         }
         
         if let activiteSetup = defaults.string(forKey: "activite_9") {
         activite[9]  = activiteSetup
         } else {
         activite[9]  = ""
         }
    }
    
    func defaultsChanged(){
        updateDisplayFromDefaults()
    }
    
    
}

