//
//  KisiDetay.swift
//  KisilerUygulama
//
//  Created by Fatih on 12.09.2022.
//

import UIKit

class KisiDetay: UIViewController {

    @IBOutlet weak var kisiAdlabel: UILabel!
    @IBOutlet weak var kisiTellabel: UILabel!
    
    var kisi:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let k = kisi {
            kisiAdlabel.text = k.kisi_ad
            kisiTellabel.text = k.kisi_tel
        }
    }

}
