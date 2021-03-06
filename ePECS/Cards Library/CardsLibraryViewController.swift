//
//  CardsLibraryViewController.swift
//  ePECS
//
//  Created by Khasanza on 6/11/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import UIKit
import AVFoundation

protocol AddCardToLevelTwoDelegate: class {
    func didTapAddCard(card: Card)
}

protocol DeleteCategoryDelegate: class {
    func didTapDeleteCategory(index: Int)
}

class CardsLibraryViewController: UIViewController, AVSpeechSynthesizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // variables
    private var allCards2 = [Categories]()
    var cardsLibraryCollectionViewCellDelegate: CardsLibraryCollectionViewCellDelegate?
    private var toSpeak = ""
    private var categoryIndex: Int?
    private var cardIndex: Int?
    private var lastRow: Int?
    private var myImage: UIImage?
    private var selectedCard: Card?
    var fromVC = false // true for levelTwo vc
    weak var addCardToLevelTwoDelegate: AddCardToLevelTwoDelegate?
    
    // outlets
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
    @IBOutlet weak var zoomInTextField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playButtonHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var smallView: UIView!
    
    // action buttons
    @IBAction func dismissButton(_ sender: Any) {
        hideZoomInView()
        dismissButton.isHidden = true
    }
    @IBAction func deleteCategory(_ sender: Any) {
        showDeleteCategoryAlert()
    }
    @IBAction func deleteCardButton(_ sender: Any) {
        showDeleteCardAlert()
    }
    @IBAction func playButton(_ sender: Any) {
        speakOut(toSpeak: toSpeak)
    }
    @IBAction func addButton(_ sender: Any) {
        showAddCardAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomInTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        self.cardsLibraryTableView.isEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialize()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DataManager.shared.saveAllCards(cardsWithCategories: self.allCards2)
    }
    
    private func initialize() {
        navigationItem.title = "Библиотека карточек"
        cardsLibraryTableView.estimatedRowHeight = 120
        cardsLibraryTableView.tableFooterView = UIView()
        allCards2 = DataManager.shared.loadAllCards()
        dismissButton.isHidden = true
        setupNavigationItemRightButton()
        cardsLibraryTableView.reloadData()
        setupZoomInButtons(fromVC: fromVC)
    }
   
    // initializing and seting up views
    private func setupNavigationItemRightButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "add"), for: UIControlState.normal)
        button.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 26).isActive = true
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.addTarget(self, action: #selector(addCategoryButtonPressed), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func setupZoomInView(name: String, image: UIImage) {
        zoomInImage.image = image
        zoomInTextField.text = name
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
    
    private func setupZoomInButtons(fromVC: Bool) {
        if (fromVC) {
            addButton.isHidden = false
            smallView.isHidden = false
            playButtonHorizontalConstraint.constant = -80.5
        }
        else {
            addButton.isHidden = true
            smallView.isHidden = true
            playButtonHorizontalConstraint.constant = 0
        }
    }
    
    // adding category to cards library
    @objc private func addCategoryButtonPressed() {
        let alert = UIAlertController(title: "Добавление категории", message: "Назовите категорию", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let addCategoryAction = UIAlertAction(title: "Добавить", style: .default) { (action) in
            let newCategoryName = alert.textFields![0].text!
            let additionCard = Card(index: 99, name: "", image: #imageLiteral(resourceName: "add"))
            self.allCards2.append(Categories(categoryName: newCategoryName, cards: [additionCard]))
            DataManager.shared.saveAllCards(cardsWithCategories: self.allCards2)
            self.cardsLibraryTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(addCategoryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // cards sound
    func speakOut(toSpeak: String) {
        let utterance = AVSpeechUtterance(string: toSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru")
        let readSound = AVSpeechSynthesizer()
        readSound.delegate = self
        readSound.speak(utterance)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        selectedCard?.name = zoomInTextField.text!
        //DataManager.shared.saveAllCards(cardsWithCategories: self.allCards2)
    }
    
    // delete category from cards library
    func showDeleteCategoryAlert() {
        let alert = UIAlertController(title: "Внимание", message: "Вы действительно хотите удалить эту категорию?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .default) { (action) in
            self.allCards2.remove(at: self.categoryIndex!)
            DataManager.shared.saveAllCards(cardsWithCategories: self.allCards2)
            self.cardsLibraryTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // deleting card from cards library
    func showDeleteCardAlert() {
        let alert = UIAlertController(title: "Внимание", message: "Вы действительно хотите удалить эту карточку?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .default) { (action) in
            self.allCards2[self.categoryIndex!].cards.remove(at: self.cardIndex!)
            DataManager.shared.saveAllCards(cardsWithCategories: self.allCards2)
            self.cardsLibraryTableView.reloadData()
            self.dismissButton.isHidden = true
            self.hideZoomInView()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // adding card to level two
    func showAddCardAlert() {
        let alert = UIAlertController(title: "Внимание", message: "Вы действительно хотите выбрать эту карточку?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .default) { (action) in
            self.addCardToLevelTwoDelegate?.didTapAddCard(card: self.selectedCard!)
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // adding card for cards library
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Выберите", message: "", preferredStyle: .actionSheet)
        
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
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
            //UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
            //UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        myImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)

        let alert = UIAlertController(title: "Имя карточки", message: "Назовите карточку", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "ok", style: .default) { action in
            let newCardName = alert.textFields![0].text!
            let newCard = Card(index: 88, name: newCardName, image: self.myImage!) // should generate index that is free, 88 is an example
            let additionCard = Card(index: 99, name: "", image: #imageLiteral(resourceName: "add"))
            self.allCards2[self.categoryIndex!].cards[self.allCards2[self.categoryIndex!].cards.count-1] = newCard
            self.allCards2[self.categoryIndex!].cards.append(additionCard)
            
            DataManager.shared.saveAllCards(cardsWithCategories: self.allCards2)
            self.cardsLibraryTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        //UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

extension CardsLibraryViewController: CardsLibraryCollectionViewCellDelegate {
    func collectionViewCellDidTap(card: Card) {
        setupZoomInView(name: card.name, image: card.image)
        toSpeak = card.name
        selectedCard = card
    }
    
    func collectionViewCellDidTapToAdd(categoryIndex: Int) {
        self.categoryIndex = categoryIndex
        showActionSheet()
    }
}

extension CardsLibraryViewController: DeleteCategoryDelegate {
    func didTapDeleteCategory(index: Int) {
        self.categoryIndex = index
        showDeleteCategoryAlert()
    }
}

extension CardsLibraryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCards2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsLibraryTableViewCell") as! CardsLibraryTableViewCell
        cell.categoryNameLabel.text = allCards2[indexPath.row].categoryName
        cell.cards = allCards2[indexPath.row].cards
        cell.cardsLibraryCollectionViewCellDelegate = self
        cell.deleteCategoryDelegate = self
        cell.categoryIndex = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count: CGFloat = CGFloat(allCards2[indexPath.row].cards.count)
        Constant.totalItem = count
        let itemHeight = Constant.getItemWidth(boundWidth: tableView.bounds.size.width)
        let totalRow = ceil(Constant.totalItem / Constant.column)
        let totalTopBottomOffset = Constant.offset + Constant.offset
        let totalSpacing = CGFloat(totalRow - 1) * Constant.minLineSpacing
        
        let totalHeight  = ((itemHeight * CGFloat(totalRow)) + totalTopBottomOffset + totalSpacing)
        return totalHeight + 72// 72: label and thin view with constraints
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let categoryToMove = allCards2[sourceIndexPath.row]
        allCards2.remove(at: sourceIndexPath.row)
        allCards2.insert(categoryToMove, at: destinationIndexPath.row)
        //DataManager.shared.saveAllCards(cardsWithCategories: self.allCards2)
        cardsLibraryTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CardsLibraryTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
}

extension CardsLibraryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCards2[collectionView.tag].cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsLibraryCollectionViewCell", for: indexPath) as! CardsLibraryCollectionViewCell
        cell.setCard(card: allCards2[collectionView.tag].cards[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (allCards2[collectionView.tag].cards[indexPath.row].index == 99) {
            self.collectionViewCellDidTapToAdd(categoryIndex: collectionView.tag)
        }
        else {
            cardIndex = indexPath.row
            categoryIndex = collectionView.tag
            self.collectionViewCellDidTap(card: allCards2[collectionView.tag].cards[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let itemWidth = Constant.getItemWidth(boundWidth: collectionView.bounds.size.width)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
