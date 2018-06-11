//
//  ChangeLevelTwoViewController.swift
//  ePECS
//
//  Created by Khasanza on 6/11/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class ChangeLevelTwoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    class var shared: ChangeLevelTwoViewController {
        struct Static {
            static let instance = ChangeLevelTwoViewController()
        }
        return Static.instance
    }
    
    private var cards_images = [#imageLiteral(resourceName: "meGirl"), #imageLiteral(resourceName: "хочу"), #imageLiteral(resourceName: "да"), #imageLiteral(resourceName: "нет"), #imageLiteral(resourceName: "мяч"), #imageLiteral(resourceName: "car"), #imageLiteral(resourceName: "кушать"), #imageLiteral(resourceName: "пить"), #imageLiteral(resourceName: "помоги"), #imageLiteral(resourceName: "спать")]
    private var cards_names = ["Я", "Хочу", "Да", "Нет", "Мяч", "Машина", "Кушать", "Пить", "Помоги", "Спать"]
    
    var selectedCard: Int?
    var cellCardCount = 0
    
    @IBOutlet weak var changeLevelTwoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
       
    func getCardsImages() -> [UIImage] {
        return cards_images
    }
    
    func getCardsNames() -> [String] {
        return cards_names
    }
    
    @IBAction func deleteCard(_ sender: Any) {
//        if (selectedCard! >= 0) {
//            cards_images.remove(at: selectedCard!)
//            changeLevelTwoCollectionView.reloadData()
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards_images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChangeLevelTwoCollectionViewCell", for: indexPath) as! ChangeLevelTwoCollectionViewCell
        cell.changeLevelTwoImageView.image = cards_images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cards_images.remove(at: indexPath.row)
        cards_names.remove(at: indexPath.row)
        changeLevelTwoCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width / 3 - 8
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
