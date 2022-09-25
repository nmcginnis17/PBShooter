//
//  Settings.swift
//  PBShots
//
//  Created by Nicholas McGinnis on 9/22/22.
//

import Foundation
import UIKit

class Settings: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var select: UILabel!
    var cellId = "Cell"
    
    let vc = ViewController()
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        view.backgroundColor = UIColor.systemMint
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        title = "Select Marker"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vc.markers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! CollectionViewCell

        cell.backgroundView = UIImageView(image: UIImage(named: "\(vc.markers[indexPath.row])"))
        cell.backgroundView?.contentMode = .scaleAspectFit
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.systemOrange.cgColor
        cell.backgroundColor = UIColor.systemIndigo
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vc.defaults.set(vc.markers[indexPath.row], forKey: "myMarker")
        done()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 400,height: 200.0)
        }
    
    @objc func done() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
