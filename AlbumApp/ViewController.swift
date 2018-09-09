//
//  ViewController.swift
//  AlbumApp
//
//  Created by Pavel Bogart on 2/10/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()

    let backgrounImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "bg")
        return iv
    }()

    let imgCellId = "imgCellId"
    let albumCellId = "albumCellID"
    
    let imgsArray = ["image1","image2","image3","image4","image1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        
        view.addSubview(backgrounImageView)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ImgCell.self, forCellWithReuseIdentifier: imgCellId)
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumCellId)
        
        backgrounImageView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        //collectionView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: .topMargin, relatedBy: .equal, toItem: collectionView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .bottomMargin, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1.0, constant: 10.0).isActive = true
        
        NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: collectionView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: collectionView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1{
            return 9
        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellId, for: indexPath) as! AlbumCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imgCellId, for: indexPath) as! ImgCell
        cell.images = imgsArray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: (view.frame.width / 3) - 16, height: 100)
        }
        return CGSize(width: view.frame.width, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
}

class ImgCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    var images: [String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp(){
        
        addSubview(collectionView)
        collectionView.register(IconicCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconicCell
        if let imgName = images?[indexPath.item] {
            cell.imgView.image = UIImage(named: imgName)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) - 14, height: frame.height - 20 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init Coder has not been Implimented")
    }
    
    private class IconicCell: UICollectionViewCell{
        let imgView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 15
            return iv
        }()
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(imgView)
            imgView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        }
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("Init Coder has not been Implimented")
        }
    }
}

class AlbumCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init Coder has not been Implimented")
    }
}
















