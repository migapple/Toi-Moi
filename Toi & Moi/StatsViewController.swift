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
        toiLabel.text = toi
        moiLabel.text = moi
        activite1Label.text = activite[0]
        activite2Label.text = activite[1]
        activite3Label.text = activite[2]
        activite4Label.text = activite[3]
        activite5Label.text = activite[4]
        activite6Label.text = activite[5]
        activite7Label.text = activite[6]
        activite8Label.text = activite[7]
        activite9Label.text = activite[8]
        activite10Label.text = activite[9]
        
        miseAjourTotal()
        
    }
    
    func miseAjourTotal() {
        
        var totalToi:Double = 0
        var totalMoi:Double = 0
        var GtotalToi:Double = 0
        var GtotalMoi:Double = 0
        
            
        if posts.count > 0 {
            // Stats Toi
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[0] {
                    print("Compare '\(posts[i].quoi)'  '\(activite[0])'")
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot1TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            totalToi = 0
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[1] {
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot2TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            totalToi = 0
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[2] {
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot3TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            totalToi = 0
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[3] {
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot4TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            totalToi = 0
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[4] {
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot5TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            totalToi = 0
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[5] {
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot6TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            totalToi = 0
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[6] {
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot7TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            totalToi = 0
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[7] {
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot8TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            totalToi = 0
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[8] {
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot9TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            totalToi = 0
            for i in 0..<posts.count {
                if posts[i].nom == toi && posts[i].quoi == activite[9] {
                    totalToi += posts[i].prix
                    GtotalToi += totalToi
                }
            }
            if totalToi != 0 {
                tot10TLabel.text = NSString(format:"%.2f€", totalToi) as String
            }
            
            // Stats Moi
            
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[0] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                }
            }
            if totalMoi != 0 {
                tot1MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            totalMoi = 0
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[1] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                    
                }
            }
            if totalMoi != 0 {
                tot2MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            totalMoi = 0
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[2] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                    
                }
            }
            if totalMoi != 0 {
                tot3MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            totalMoi = 0
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[3] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                    
                }
            }
            if totalMoi != 0 {
                tot4MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            totalMoi = 0
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[4] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                    
                }
            }
            if totalMoi != 0 {
                tot5MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            totalMoi = 0
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[5] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                    
                }
            }
            if totalMoi != 0 {
                tot6MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            totalMoi = 0
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[6] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                    
                }
            }
            if totalMoi != 0 {
                tot7MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            totalMoi = 0
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[7] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                    
                }
            }
            if totalMoi != 0 {
                tot8MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            totalMoi = 0
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[8] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                    
                }
            }
            if totalMoi != 0 {
                tot9MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            totalMoi = 0
            for i in 0..<posts.count {
                if posts[i].nom == moi && posts[i].quoi == activite[9] {
                    totalMoi += posts[i].prix
                    GtotalMoi += totalMoi
                    
                }
            }
            if totalMoi != 0 {
                tot10MLabel.text = NSString(format:"%.2f€", totalMoi) as String
            }
            
        }
        
        GTotTLabel.text = NSString(format:"%.2f€", GtotalToi) as String
        GTotMLabel.text = NSString(format:"%.2f€", GtotalMoi) as String
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
