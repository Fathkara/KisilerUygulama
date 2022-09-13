//
//  KisiEkle.swift
//  KisilerUygulama
//
//  Created by Fatih on 12.09.2022.
//

import UIKit

class KisiEkle: UIViewController {
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var kisiAdtextfield: UITextField!
    @IBOutlet weak var kisiTeltextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ekleButton(_ sender: Any) {
        
        if let ad = kisiAdtextfield.text, let tel = kisiTeltextfield.text {
            let kisi = Kisiler(context: context)
            kisi.kisi_ad = ad
            kisi.kisi_tel = tel
            
            appDelegate.saveContext()
            
        }
        
        
    }
    
}
