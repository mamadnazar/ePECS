//
//  ThirdLevelViewController.swift
//  ePECS
//
//  Created by Risolat Fayzmamadova on 5/28/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class ThirdLevelCategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var phraseCollectionView: UICollectionView!
    let categories_names = ["1", "2", "3", "4", "5"]
    let categories_images = [#imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "кушать"), #imageLiteral(resourceName: "пить"), #imageLiteral(resourceName: "помоги"), #imageLiteral(resourceName: "компьютер")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Categories"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

}

extension ThirdLevelCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == phraseCollectionView {
            return categories_names.count
        }
        return categories_names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == phraseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhraseCollectionViewCell", for: indexPath) as! PhraseCollectionViewCell
            cell.phraseImageView.image = categories_images[indexPath.row]
            cell.phraseLabel.text = categories_names[indexPath.row]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.categoryNameLabel.text = categories_names[indexPath.row]
            cell.categoryImageView.image = categories_images[indexPath.row]
            return cell
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == categoryCollectionView {
//            let vc = viewController(withIdentifier: "CardsViewController") as! CardsViewController
//            vc.categoryId = listOfCategories.array[indexPath.row].id
//            vc.navTitle = listOfCategories.array[indexPath.row].name
//            navigationController?.pushViewController(vc, animated: false)
//        } else {
//            array_phrases.remove(at: indexPath.row)
//            phraseCollectionView.reloadData()
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width / 2 - 16

        if collectionView == phraseCollectionView {
            return CGSize(width: 130, height: 180)
        }
        
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
}
