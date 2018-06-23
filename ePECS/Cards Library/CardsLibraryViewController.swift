//
//  CardsLibraryViewController.swift
//  ePECS
//
//  Created by Khasanza on 6/11/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit
import AVFoundation

class CardsLibraryViewController: UIViewController, AVSpeechSynthesizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    class var shared: CardsLibraryViewController {
        struct Static {
            static let instance = CardsLibraryViewController()
        }
        return Static.instance
    }
    
    private var allCards: [String : Array<Card>] = [:]
    var toSpeak = ""
    private var myImage: UIImage?
    @IBOutlet weak var cardsLibraryTableView: UITableView!
    @IBOutlet var zoomInView: UIView!
    @IBOutlet weak var upperZoomInView: UIView! {
        didSet {
            upperZoomInView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var downZoomInView: UIView! {
        didSet {
            downZoomInView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var zoomInImage: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBAction func dismissButton(_ sender: Any) {
        hideZoomInView()
        dismissButton.isHidden = true
    }
    @IBAction func playButton(_ sender: Any) {
        print(toSpeak)
        speakOut(toSpeak: toSpeak)
    }
    @IBAction func addButton(_ sender: Any) {
        print("By pressing this, card will be added to level two")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cardsLibraryTableView.estimatedRowHeight = 120
        cardsLibraryTableView.tableFooterView = UIView()
        
        dismissButton.isHidden = true
        
        allCards = DataManager.shared.getCategories()
        let addingCard = Card(index: 99, name: "", image: #imageLiteral(resourceName: "add"))
        for i in allCards {
            allCards[i.key]?.append(addingCard)
        }
        cardsLibraryTableView.reloadData()
    }

    func setupZoomInView(image: UIImage) {
        
        //UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(zoomInView)
        zoomInImage.image = image
        
        zoomInView.center = CGPoint(x: view.frame.midX, y: view.frame.minY)
        zoomInView.alpha = 0
        dismissButton.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.zoomInView.alpha = 1
            self.zoomInView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.height / 2 - 35)
        }
        
        view.addSubview(zoomInView)
    }
    
    private func hideZoomInView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.zoomInView.alpha = 0
            self.zoomInView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.maxY)
        }) { (success) in
            self.zoomInView.removeFromSuperview()
        }
    }
    
    func speakOut(toSpeak: String) {
        let utterance = AVSpeechUtterance(string: toSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru")
        let readSound = AVSpeechSynthesizer()
        readSound.delegate = self
        readSound.speak(utterance)
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Выберете", message: "", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "Камера", style: .default) { action in
            self.openCamera()
        }
        let gallery = UIAlertAction(title: "Галерея", style: .default) { actionSheet in
            self.openGallery()
        }
        
        actionSheet.addAction(cancel)
        actionSheet.addAction(camera)
        actionSheet.addAction(gallery)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        myImage = info[UIImagePickerControllerOriginalImage] as? UIImage
//        dismiss(animated: true, completion: nil)
//
//        let alert = UIAlertController(title: "Имя карточки", message: "Назовите карточку", preferredStyle: .alert)
//        alert.addTextField(configurationHandler: nil)
//        let okAction = UIAlertAction(title: "ok", style: .default) { action in
//            let newCardName = alert.textFields![0].text!
//            let newCard = Card(index: 88, name: newCardName, image: self.myImage!) // should generate index that is free, 88 is an example
//
//            var additionCard = Card(index: 99, name: "", image: #imageLiteral(resourceName: "add"))
//            for i in self.cards {
//                if (i.index == 99) {
//                    additionCard = i
//                    break
//                }
//            }
//
//            self.cards[self.cards.index(of: additionCard)!] = newCard
//            DataManager.shared.setBasicCards(cards: self.cards)
//            self.changeLevelTwoCollectionView.reloadData()
//
//        }
//        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//        alert.addAction(cancelAction)
//        alert.addAction(okAction)
//        self.present(alert, animated: true, completion: nil)
//
//    }
}
extension CardsLibraryViewController: CardsLibraryCollectionViewCellDelegate {
    func collectionViewCellDidTap(image: UIImage) {
        setupZoomInView(image: image)
    }
    
}
extension CardsLibraryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allCards.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsLibraryTableViewCell") as! CardsLibraryTableViewCell
        cell.categoryNameLabel.text = Array(allCards.keys)[indexPath.section]
        cell.cards = allCards[Array(allCards.keys)[indexPath.section]]!
        cell.cardsLibraryCollectionViewCellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let  count: CGFloat = CGFloat(Array(allCards.values)[indexPath.section].count)
        Constant.totalItem = count
        let itemHeight = Constant.getItemWidth(boundWidth: tableView.bounds.size.width)

        let totalRow = ceil(Constant.totalItem / Constant.column)
        
        let totalTopBottomOffset = Constant.offset + Constant.offset
        
        let totalSpacing = CGFloat(totalRow - 1) * Constant.minLineSpacing
        
        let totalHeight  = ((itemHeight * CGFloat(totalRow)) + totalTopBottomOffset + totalSpacing)
        return totalHeight + 72 // 72: label and thin view with constraints
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
