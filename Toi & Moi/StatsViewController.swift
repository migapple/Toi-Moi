//
//  StatsViewController.swift
//  Toi & Moi
//
//  Created by Michel Garlandat on 26/01/2017.
//  Copyright © 2017 Michel Garlandat. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var toiLabel: UILabel!
    @IBOutlet weak var moiLabel: UILabel!
    @IBOutlet weak var activite1Label: UILabel!
    @IBOutlet weak var activite2Label: UILabel!
    @IBOutlet weak var activite3Label: UILabel!
    @IBOutlet weak var activite4Label: UILabel!
    @IBOutlet weak var activite5Label: UILabel!
    @IBOutlet weak var activite6Label: UILabel!
    @IBOutlet weak var activite7Label: UILabel!
    @IBOutlet weak var activite8Label: UILabel!
    @IBOutlet weak var activite9Label: UILabel!
    @IBOutlet weak var activite10Label: UILabel!
    
    @IBOutlet weak var tot1TLabel: UILabel!
    @IBOutlet weak var tot2TLabel: UILabel!
    @IBOutlet weak var tot3TLabel: UILabel!
    @IBOutlet weak var tot4TLabel: UILabel!
    @IBOutlet weak var tot5TLabel: UILabel!
    @IBOutlet weak var tot6TLabel: UILabel!
    @IBOutlet weak var tot7TLabel: UILabel!
    @IBOutlet weak var tot8TLabel: UILabel!
    @IBOutlet weak var tot9TLabel: UILabel!
    @IBOutlet weak var tot10TLabel: UILabel!
    
    @IBOutlet weak var tot1MLabel: UILabel!
    @IBOutlet weak var tot2MLabel: UILabel!
    @IBOutlet weak var tot3MLabel: UILabel!
    @IBOutlet weak var tot4MLabel: UILabel!
    @IBOutlet weak var tot5MLabel: UILabel!
    @IBOutlet weak var tot6MLabel: UILabel!
    @IBOutlet weak var tot7MLabel: UILabel!
    @IBOutlet weak var tot8MLabel: UILabel!
    @IBOutlet weak var tot9MLabel: UILabel!
    @IBOutlet weak var tot10MLabel: UILabel!
    @IBOutlet weak var GTotalLabel: UILabel!
    @IBOutlet weak var GTotTLabel: UILabel!
    @IBOutlet weak var GTotMLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        var totalActiviteToi:Double = 0
        var totalActiviteMoi:Double = 0
        var GtotalToi:Double = 0
        var GtotalMoi:Double = 0
        
        
        // On affiche le  paramètrage de toi et moi
        toiLabel.text = toi
        moiLabel.text = moi
        
        
        // On affiche les activités
        
        
        for i in 0 ... 9 {
            let leLabel = view.viewWithTag(i+1) as! UILabel
            leLabel.text = activiteSetting[i]
        }
        
        //on affiche le total des activités
        if posts.count > 0 {
            
            // on affiche pour chaque activté
            for j in 0 ... 9 {
                
                // on affiche les posts de Toi
                for i in 0 ... posts.count - 1 {
                    
                    if posts[i].nom == toi && posts[i].quoi == activiteSetting[j] {
                        
                        let leLabel = view.viewWithTag(j + 11) as! UILabel
                        totalActiviteToi += posts[i].prix
                        leLabel.text = NSString(format:"%.2f€", totalActiviteToi) as String
                                            }
                }
                GtotalToi += totalActiviteToi

                GTotTLabel.text = NSString(format:"%.2f€", GtotalToi) as String
                totalActiviteToi = 0
                
                // on affiche les posts de Moi
                for i in 0 ... posts.count - 1 {
                    
                    if posts[i].nom == moi && posts[i].quoi == activiteSetting[j] {
                        
                        let leLabel = view.viewWithTag(j + 21) as! UILabel
                        totalActiviteMoi += posts[i].prix
                        leLabel.text = NSString(format:"%.2f€", totalActiviteMoi) as String
                    }
                }
                GtotalMoi += totalActiviteMoi
                
                GTotMLabel.text = NSString(format:"%.2f€", GtotalMoi) as String
                totalActiviteMoi = 0
            }
        }
    }
}
