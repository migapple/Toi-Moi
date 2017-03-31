//
//  ViewController.swift
//  Toi & Moi
//
//  Created by Michel Garlandat on 18/01/2017.
//  Copyright © 2017 Michel Garlandat. All rights reserved.
//

import UIKit
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
var activites = [String]()

var prixToi: [Double] = []
var prixMoi: [Double] = []
var totalToi:Double = 0
var totalMoi:Double = 0

var activiteSetting = ["Restau","Ciné","Courses","","","","","","",""]


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
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        
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
        
        // Firebase
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
            
            // Firebase
            
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
    
    @IBAction func findeMoisButton(_ sender: UIBarButtonItem) {
        let sauveTotalToi = totalToi
        let sauveTotalMoi = totalMoi
        
        
        let alertController:UIAlertController = UIAlertController(title: "Remise à 0 de fin de mois !", message: "Voulez-vous vraiment faire une remise à 0 et garder la balance ?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Non, annuler", style: .cancel) { action -> Void in
            // don't do anything
        }
        
        let nextAction = UIAlertAction(title: "Oui", style: .default) { action -> Void in
            
            // On calcule le report
            var total = 0.0
            var qui = ""
            if sauveTotalToi > sauveTotalMoi {
                totalToi = sauveTotalToi - sauveTotalMoi
                totalMoi = 0
                qui = toi
                total = totalToi
            } else {
                totalMoi = sauveTotalMoi - sauveTotalToi
                totalToi = 0
                qui = moi
                total = totalMoi
            }
            
            let quoi = "Report"
            
            // On recupere la date
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR") as Locale!
            dateFormatter.dateFormat = "EEE dd/MM/yy HH:mm"
            let ladate = dateFormatter.string(from: Date())
            
            // Firebase on efface la base
            
            let ref = FIRDatabase.database().reference()
            ref.child("activite").removeValue()
            posts.removeAll()
            prixToi = []
            prixMoi = []
        
            // Firebase on ajoute le report
            let  post :[String: AnyObject] = ["nom": qui as AnyObject,"date": ladate as AnyObject,"quoi":quoi as AnyObject,"prix": total as AnyObject]
            
            let databaseRef = FIRDatabase.database().reference()
            databaseRef.child("activite").childByAutoId().setValue(post)
            
            self.totToiLabel.text = NSString(format:"%.2f€", totalToi) as String
            self.totMoiLabel.text = NSString(format:"%.2f€", totalMoi) as String
            
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
        
        nbToiLabel.text = "\(postToi.count)"
        nbMoiLabel.text = "\(postMoi.count)"
     
        totToiLabel.text = NSString(format:"%.2f€", totalToi) as String
        totMoiLabel.text = NSString(format:"%.2f€", totalMoi) as String

        self.maTableView.reloadData()
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
        let post = posts[indexPath.row]
        // print (post)
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
        
        //Set the controls to the default values.
        
        if let activiteSetup = defaults.string(forKey: "moi_0") {
            moi = String(activiteSetup.characters.prefix(3)).uppercased()
            moi = moi.padding(toLength: 3, withPad: " ", startingAt: 0)
        }
        
        if let activiteSetup = defaults.string(forKey: "toi_0") {
            toi  = String(activiteSetup.characters.prefix(3)).uppercased()
            toi = toi.padding(toLength: 3, withPad: " ", startingAt: 0)
        }

        toiTitre.text = toi
        moiTitre.text = moi
        
        
        for i in 0 ... 9 {
            if let activiteSetup = defaults.string(forKey: "activite_\(i)") {
                activiteSetting[i]  = activiteSetup
            } else {
                activiteSetting[i]  = ""
            }
        }
    }
    
    func defaultsChanged(){
        updateDisplayFromDefaults()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //        if segue.identifier == "Ajouter" {
        //            let viewVC = segue.destination as! AjoutViewController
        //            viewVC.isEditing = false
        //            viewVC.activites = activites
        //            viewVC.delegate = self
        //            viewVC.maTableView = self.maTableView
        //        }
        //
        //        if segue.identifier == "Modifier" {
        //            let viewVC = segue.destination as! AjoutViewController
        //            viewVC.isEditing = true
        //            viewVC.delegate = self
        //            let indexPath = maTableView.indexPathForSelectedRow
        //            let activite = activites[(indexPath?.row)!] as CKRecord
        //            viewVC.activite = activite
        //        }
        
//                if segue.identifier == "Statistiques" {
//                    let viewVC = segue.destination as! StatsViewController
//                    viewVC.posts = posts
//                }
    }
}

