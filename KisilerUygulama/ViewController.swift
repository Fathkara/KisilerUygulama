//
//  ViewController.swift
//  KisilerUygulama
//
//  Created by Fatih on 12.09.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate


class ViewController: UIViewController  {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kisilerTableview: UITableView!
    
    var kisilerListe = [Kisiler]()
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        kisilerTableview.delegate = self
        kisilerTableview.dataSource = self
        
        searchBar.delegate = self
        tumKisileriAl()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if aramaYapiliyorMu {
            aramaYapiliyorMu = true
            AramaSonucu(kisi_ad: aramaKelimesi!)
            
        }else{
            aramaYapiliyorMu = false
            tumKisileriAl()
            
        }
        
        kisilerTableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toDetay" {
            let gidilecekAlan = segue.destination as! KisiDetay
            gidilecekAlan.kisi = kisilerListe[indeks!]
            
        }
        
        if segue.identifier == "toGuncelle" {
            let gidilecekAlan = segue.destination as! KisiGu_ncelle
            gidilecekAlan.kisi = kisilerListe[indeks!]
            
        }
       
    }
    
    func tumKisileriAl(){
        do {
            kisilerListe = try context.fetch(Kisiler.fetchRequest())
        } catch  {
            print(error)
            
        }
    }
    
    func AramaSonucu(kisi_ad:String){
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "kisi_ad CONTAINS %@",kisi_ad)
        
        do {
            kisilerListe = try context.fetch(fetchRequest)
        } catch  {
            print(error)
            
        }
    }

}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListe.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = kisilerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! KisiHucreTableViewCell
        
        cell.labelTableview.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accept = UIContextualAction(style: .destructive, title: "Sil") { (action,view,kisilerListe) in
            print("sil tıklandı : \(self.kisilerListe[indexPath.row])")
            let kisi = self.kisilerListe[indexPath.row]
            self.context.delete(kisi)
            appDelegate.saveContext()
        
            if self.aramaYapiliyorMu {
                
                self.AramaSonucu(kisi_ad: self.aramaKelimesi!)
                
            }else{
                
                self.tumKisileriAl()
                
            }
            self.kisilerTableview.reloadData()
    }
        
            
            let gelenVeri = UIContextualAction(style: .normal, title: "Güncelle") { (action,view,kisilerListe)   in
                
            
            
                self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
            
            }
        return UISwipeActionsConfiguration(actions: [accept,gelenVeri]
            
    )}
 
}


extension ViewController:UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            print("arama sonuc : \(searchText)")
            
            aramaKelimesi = searchText
            
            if searchText == "" {
                aramaYapiliyorMu = false
                tumKisileriAl()
            }else {
                aramaYapiliyorMu = true
                AramaSonucu(kisi_ad: aramaKelimesi!)
            }
            kisilerTableview.reloadData()
            
        }
    }

    



