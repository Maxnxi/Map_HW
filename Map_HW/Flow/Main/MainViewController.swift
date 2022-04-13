//
//  MainViewController.swift
//  Map_HW
//
//  Created by Maksim Ponomarev on 13.11.2021.
//

import UIKit

let avatarName = "profilePhoto.png"


class MainViewController: UIViewController {
    
    @IBOutlet weak var makePhotoBttn: UIButton!
    @IBOutlet weak var avatarView: UIImageView!
    
    static let reuseIdentifier = "MainViewController"
    
    var onMap: ((String) -> Void)?
    var onLogout: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarView.layer.cornerRadius = avatarView.bounds.width/2
        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.image = SaveNLoadToPhoneImageService.shared.loadImageFromDiskWith(fileName: avatarName) ?? UIImage(systemName: "photo.circle")
    }
    
    @IBAction func showMap(_ sender: Any) {
        onMap?("пример")
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        onLogout?()
    }
    
    @IBAction func makeSelfieButtonWasPressed(_ sender: Any) {
        //guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true)
    }
    

}

extension MainViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Если нажали на кнопку Отмена, то UIImagePickerController надо закрыть
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // Мы получили медиа от контроллера
        // Изображение надо достать из словаря info
        //let image = extractImage(from: info)
        //print(image!)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        let size = CGSize(width: 45, height: 45)
        let avatarImage = UIImage().resizeImage(image: selectedImage, targetSize: size)
        avatarView.image = avatarImage
        
        SaveNLoadToPhoneImageService.shared.saveImage(imageName: avatarName, image: avatarImage)
        // Закрываем UIImagePickerController
        picker.dismiss(animated: true)
    }
    
    // Метод, извлекающий изображение
    private func extractImage(from info: [String: Any]) -> UIImage? {
        // Пытаемся извлечь отредактированное изображение
        if let image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            return image
            // Пытаемся извлечь оригинальное
        } else if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            return image
        } else {
            // Если изображение не получено, возвращаем nil
            return nil
        }
    }
}
