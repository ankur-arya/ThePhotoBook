//
//  FullImageViewController.swift
//  MyPhotoBook
//
//  Created by Ankur Arya on 16/01/19.
//  Copyright © 2019 Ankur Arya. All rights reserved.
//

import UIKit

/// Class to handle full image functionality.
class FullImageViewController: Pannable {
    var images: [ImageModel]?
    var selectedIndex: IndexPath?
    @IBOutlet weak var imagesCollection: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FullImageViewController.dismissViewController)))
       
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1/4), execute: {
            guard let index = self.selectedIndex else {return}
            self.imagesCollection?.scrollToItem(at: index, at: .right, animated: false)
        })
        
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - Extension for CollectionView
extension FullImageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            if let image = images?[indexPath.item] {
                cell.setData(image: image)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width, height: frameSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
