//
//  AjoutViewController.swift
//  Toi & Moi
//
//  Created by Michel Garlandat on 18/01/2017.
//  Copyright © 2017 Michel Garlandat. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseDatabase

//var activite = ["Restau", "Ciné","Coursevar"","","","","","",""]

//protocol AjoutViewControllerDelegate {
//    func myVCDidFinish(controller:AjoutViewController)
//}


class AjoutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var post: postStuct?
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var prixTextField: UITextField!
    @IBOutlet weak var quoiTextField: UITextField!
    @IBOutlet weak var monDatePicker: UIDatePicker!
    @IBOutlet weak var activitePicker: UIPickerView!
    @IBOutlet weak var quiSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sauverBtn: UIBarButtonItem!
    
    var choix = "Restau"
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var qui = moi
    let numberFormatter = NumberFormatter()
    //var prixDouble:Double
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quiSegmentedControl.setTitle(moi, forSegmentAt: 0)
        quiSegmentedControl.setTitle(toi, forSegmentAt: 1)
        
        if isEditing {
            self.title = "Modification"
            sauverBtn.title = "Modifier"
            afficheDate()
            
            modifSaisie()
        } else {
            self.title = "Ajout"
            afficheDate()
            quoiTextField.text = choix
        }
        
    }
    
    
    @IBAction func modiferDatePicker(_ sender: Any) {
        dateTextField.text = dateFormatter.string(for: monDatePicker.date)
    }
    
    @IBAction func quiSegmentedControlAction(_ sender: Any) {
        switch quiSegmentedControl.selectedSegmentIndex
        {
        case 0:
            qui = moi;
        case 1:
            qui = toi;
        default:
            break;
        }
    }
    
    @IBAction func ajouterAction(_ sender: Any) {
        
        if isEditing {
            modification()
        } else {
            ajouter()
        }
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    func ajouter() {
        if prixTextField.text == "" {
            prixTextField.text = "0"
        }
        
        // On remplace la virgule par un point
        let newPrix = prixTextField.text?.replacingOccurrences(of: ",", with: ".")
        
        // On verifie que l'on a rentré une somme sinon alerte
        if (Float(newPrix!) != nil) {
            let  post :[String: AnyObject] = ["nom": qui as AnyObject,"date":dateTextField.text! as AnyObject,"quoi":quoiTextField.text! as AnyObject,"prix": Double(newPrix!) as AnyObject]
            
            let databaseRef = FIRDatabase.database().reference()
            
            // post data
            databaseRef.child("activite").childByAutoId().setValue(post)
            self.navigationController?.popViewController(animated: true)
            
        } else {
            let alertController = UIAlertController(title: "Validation Error", message: "You must enter numeric number!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
                alertController.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
//    @IBAction func annulerAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//        
//    }
    
    // Si on est en mode modification on doit afficher le post à modifier
    func modifSaisie() {
        if let qui = post?.nom {
            if qui == moi {
                quiSegmentedControl.selectedSegmentIndex = 0
            } else {
                quiSegmentedControl.selectedSegmentIndex = 1
            }
        }
        
        if let laDate = post?.date {
            dateTextField.text = laDate
        }
        
        if let quoi = post?.quoi {
            quoiTextField.text = quoi
        }
        
        if let prix = post?.prix {
            prixTextField.text = NSString(format:"%.2f", prix) as String
        }
    }
    
    // On fait la modification
    func modification() {
        switch self.quiSegmentedControl.selectedSegmentIndex
        {
        case 0:
            post?.nom = moi
            
        case 1:
            post?.nom = toi
            
        default:
            break;
        }
        
        post?.date =  dateTextField.text!
        post?.prix = Double(prixTextField.text!)!
        post?.quoi = quoiTextField.text!
        let key = post?.uniqueUserID
        let dictionaryTodo = [ "date": post!.date ,
                               "nom" : post!.nom,
                               "prix": post!.prix,
                               "quoi": post!.quoi] as [String : Any]
        let databaseRef = FIRDatabase.database().reference()
        
        
        
        let childUpdates = ["/activite/\(String(describing: key))": dictionaryTodo]
        databaseRef.updateChildValues(childUpdates, withCompletionBlock: { (error, ref) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    
    // MARK - Gestion Activites Picker View
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activiteSetting[row]
        
    }
    
    // returns the number of 'columns' to display.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activiteSetting.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choix = activiteSetting[row]
        quoiTextField.text = choix
    }
    
    // On affiche la date du jour dans le champ
    func afficheDate() {
        // affiche la date du jour et le met dans le champ dateTextField
        dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR") as Locale!
        dateFormatter.dateFormat = "EEE dd/MM/yy HH:mm"
        dateTextField.text = dateFormatter.string(from: monDatePicker.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
