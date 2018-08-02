//
//  ChangeLevelTwoViewController.swift
//  ePECS
//
//  Created by Khasanza on 6/11/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit

class ChangeLevelTwoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    class var shared: ChangeLevelTwoViewController {
        struct Static {
            static let instance = ChangeLevelTwoViewController()
        }
        return Static.instance
    }
    
    private var cards: [Card] = []
    var myImage: UIImage?
    
    private var selectedCard: Int?
    var cellCardCount = 0
    
    @IBOutlet weak var changeLevelTwoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cards = DataManager.shared.loadBasicCards()
    }

    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Выберите", message: "", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "Камера", style: .default) { action in
            self.openCamera()
        }
        let gallery = UIAlertAction(title: "Галерея", style: .default) { actionSheet in
            self.openGallery()
        }
        let cardsLibrary = UIAlertAction(title: "Библиотека карточек", style: .default) { action in
            self.openLibrary()
        }
        
        actionSheet.addAction(cancel)
        actionSheet.addAction(camera)
        actionSheet.addAction(gallery)
        actionSheet.addAction(cardsLibrary)
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openLibrary() {
        let sb = UIStoryboard(name: "CardsLibraryStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CardsLibraryViewController") as! CardsLibraryViewController
        vc.fromVC = true
        vc.addCardToLevelTwoDelegate = self
        self.navigationController?.show(vc, sender: self)
    }
    
    func setCardFromLibrary(newCard: Card) {
        var additionCard = Card(index: 99, name: "", image: #imageLiteral(resourceName: "add"))
        for i in self.cards {
            if (i.index == 99) {
                additionCard = i
                break
            }
        }
        
        self.cards[self.cards.index(of: additionCard)!] = newCard
        if (self.cards.count < 10) {
            self.cards.append(additionCard)
        }
        DataManager.shared.saveBasicCards(cards: self.cards)
        self.changeLevelTwoCollectionView.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        myImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
        let alert = UIAlertController(title: "Имя карточки", message: "Назовите карточку", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "ok", style: .default) { action in
            let newCardName = alert.textFields![0].text!
            let newCard = Card(index: 88, name: newCardName, image: self.myImage!) // should generate index that is free, 88 is an example
            
            var additionCard = Card(index: 99, name: "", image: #imageLiteral(resourceName: "add"))
            for i in self.cards {
                if (i.index == 99) {
                    additionCard = i
                    break
                }
            }

            self.cards[self.cards.index(of: additionCard)!] = newCard
            if (self.cards.count < 10) {
                self.cards.append(additionCard)
            }
            DataManager.shared.saveBasicCards(cards: self.cards)
            self.changeLevelTwoCollectionView.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChangeLevelTwoViewController: AddCardToLevelTwoDelegate {
    func didTapAddCard(card: Card) {
        myImage = card.image
        setCardFromLibrary(newCard: card)
    }
}

extension ChangeLevelTwoViewController: ChangeLevelTwoCollectionViewCellDelegate {
    func didTapDelete(cardToDelete: Card) {
        if (cards[cards.count - 1].index != 99) {
            cards.remove(at: cards.index(of: cardToDelete)!)
            cards.append(Card(index: 99, name: "", image: #imageLiteral(resourceName: "add")))
        } else { cards.remove(at: cards.index(of: cardToDelete)!) }
        DataManager.shared.saveBasicCards(cards: cards)
        changeLevelTwoCollectionView.reloadData()
    }
}

extension ChangeLevelTwoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChangeLevelTwoCollectionViewCell", for: indexPath) as! ChangeLevelTwoCollectionViewCell
        cell.setPhraseCard(card: cards[indexPath.row])
        cell.delegate = self
        cell.deleteButton.isHidden = (cards[indexPath.row].index == 99 ? true : false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (cards[indexPath.row].index == 99) {
            showActionSheet()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = changeLevelTwoCollectionView.frame.size.width / 4
        return CGSize(width: width, height: width + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

