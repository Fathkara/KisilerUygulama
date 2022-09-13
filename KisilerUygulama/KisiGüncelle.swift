//
//  KisiGüncelle.swift
//  KisilerUygulama
//
//  Created by Fatih on 12.09.2022.
//

import UIKit

class KisiGu_ncelle: UIViewController {
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var kisiAdtextfield: UITextField!
    @IBOutlet weak var kisiTeltextfield: UITextField!
    
    var kisi:Kisiler?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let k = kisi {
            kisiAdtextfield.text = k.kisi_ad
            kisiTeltextfield.text = k.kisi_tel
        }
    }
    
    @IBAction func GuncelleButton(_ sender: Any) {
        
        if let k = kisi , let ad = kisiAdtextfield.text , let tel = kisiTeltextfield.text {
            k.kisi_ad = ad
            k.kisi_tel = tel
            appDelegate.saveContext()
            
        }
        
    }
    
}
