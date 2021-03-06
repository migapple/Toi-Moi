//
//  AjoutViewController.swift
//  test
//
//  Created by Michel Garlandat on 18/01/2017.
//  Copyright © 2017 Michel Garlandat. All rights reserved.
//

import UIKit
import CoreData
var activite = ["Restau", "Ciné","Courses","","","","","","",""]

class AjoutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var prixTextField: UITextField!    
    @IBOutlet weak var quoiTextField: UITextField!
    @IBOutlet weak var monDatePicker: UIDatePicker!
    @IBOutlet weak var activitePicker: UIPickerView!
    @IBOutlet weak var quiSegmentedControl: UISegmentedControl!
    
    var choix = "Restau"
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var qui = "Toi"
    let numberFormatter = NumberFormatter()
    //var prixDouble:Double


    @IBAction func modiferDatePicker(_ sender: Any) {
         dateTextField.text = dateFormatter.string(for: monDatePicker.date)
    }
    
    @IBAction func quiSegmentedControlAction(_ sender: Any) {
        switch quiSegmentedControl.selectedSegmentIndex 
        {
        case 0:
            qui = "Toi";
        case 1:
            qui = "Moi";
        default:
            break; 
        }
    }
    
    @IBAction func ajouterAction(_ sender: Any) {
        // Core Data
         context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
        // ListePersonnes.append(Personne.init(nom: qui, date: dateTextField.text!, quoi: quoiTextField.text!, prix: (prix as NSString).doubleValue))
        let nouvelleActivite = NSEntityDescription.insertNewObject(forEntityName: "Activites", into: context!)
        if prixTextField.text == "" {
            prixTextField.text = "0"
        }
        
        
        numberFormatter.locale = Locale(identifier: "fr_FR")
        let prixDouble = numberFormatter.number(from: prixTextField.text!) as! Double
        sauvegarde(objet: nouvelleActivite, nom: qui, date: dateTextField.text!, quoi: quoiTextField.text!, prix: prixDouble)
        self.dismiss(animated: true, completion: nil)
    
    }
    

    @IBAction func annulerAction(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        monDatePicker.locale = Locale(identifier: "fr_FR")

        afficheDate()
        quoiTextField.text = choix
        // on donne la main à la vue sur activitePicker
        //activitePicker.delegate = self
        
    }
    
    // MARK - Gestion Activites Picker View
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activite[row]
        
    }
    
    // returns the number of 'columns' to display.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return activite.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choix = activite[row]
        quoiTextField.text = choix
    }
    
        
    func afficheDate() {
        // affiche la date du jour et le met dans le champ dateTextField
        dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR") as Locale
        dateFormatter.dateFormat = "EEE dd/MM/yy HH:mm"
        dateTextField.text = dateFormatter.string(from: monDatePicker.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
