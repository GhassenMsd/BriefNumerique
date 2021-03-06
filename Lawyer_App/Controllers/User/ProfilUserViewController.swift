//
//  ProfilUserViewController.swift
//  Lawyer_App
//
//  Created by hamadi aziz on 23/12/2019.
//  Copyright © 2019 hamadi aziz. All rights reserved.
//

import UIKit
import Photos

class ProfilUserViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageUpdateBtn.layer.cornerRadius = imageUpdateBtn.frame.width / 2
        let preferences = UserDefaults.standard
        let decoded  = preferences.data(forKey: "user")
        user = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! User
        self.imageUser.af_setImage(withURL:URL(string: Connexion.adresse + "/Ressources/Avocat/" + user.img)!)
        self.imageUser.contentMode = .scaleAspectFill
        self.nomComplet.text = user.nomComplet
        self.degree.text = user.grade
        self.nomCompletEdit.text = user.nomComplet
        self.emailEdit.text = user.email
        self.adresseEdit.text = user.adresseBureau
        self.telEdit.text = user.tel
        self.degreeEdit.text = user.grade
        imagePicker.delegate = self
        self.imageUser.addShadowImage(radius: self.imageUser.frame.width / 2)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var imageUpdateBtn: UIButton!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var nomComplet: UILabel!
    @IBOutlet weak var nomCompletEdit: UITextField!
    @IBOutlet weak var emailEdit: UITextField!
    @IBOutlet weak var adresseEdit: UITextField!
    @IBOutlet weak var telEdit: UITextField!
    @IBOutlet weak var degreeEdit: UITextField!
    let imagePicker = UIImagePickerController()
    var imageName:String = "avatar.png"
    var pickedImageProduct = UIImage()
    var clientService = ClientService()
    var user = User()
    var loginService = LoginService()
    @IBOutlet weak var btnEditNomComplet: UIButton!
    @IBOutlet weak var btnEditTel: UIButton!
    @IBOutlet weak var btnEditEmail: UIButton!
    @IBOutlet weak var btnEditAdresse: UIButton!
    @IBOutlet weak var btnEditDegree: UIButton!
    
    @IBAction func OpenImagePicker(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Error: \(info)")
        }
        pickedImageProduct = selectedImage
        self.imageUser.image = pickedImageProduct
        self.imageUser.contentMode = .scaleAspectFill
        
        guard let imageData = UIImageJPEGRepresentation(self.imageUser.image! , 1) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        
        self.loginService.uploadImage(image: imageData) { (image) in
            self.imageName = image
            self.user.img = image
            self.loginService.UpdateUser(user: self.user) { (response) in
                print("response image " + response)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nomCompletEditAction(_ sender: Any) {
        
        if(self.btnEditNomComplet.title(for: .normal) == "تعديل"){
            self.nomCompletEdit.isUserInteractionEnabled = true
            self.btnEditNomComplet.setTitle("تسجيل", for: .normal)
        }
        else{
            self.nomCompletEdit.isUserInteractionEnabled = false
            self.btnEditNomComplet.setTitle("تعديل", for: .normal)
            self.nomComplet.text = self.nomCompletEdit.text!
            if(self.nomComplet.text != self.user.nomComplet){
                self.user.nomComplet = self.nomComplet.text!
                self.loginService.UpdateUser(user: self.user) { (response) in
                    print("response")
                }
            }
        }
    }
    
    
    @IBAction func emailEditAction(_ sender: Any) {
        if(self.btnEditEmail.title(for: .normal) == "تعديل"){
            self.emailEdit.isUserInteractionEnabled = true
            self.btnEditEmail.setTitle("تسجيل", for: .normal)
        }
        else{
            self.emailEdit.isUserInteractionEnabled = false
            self.btnEditEmail.setTitle("تعديل", for: .normal)
            if(self.emailEdit.text != self.user.email){
                self.user.email = self.emailEdit.text!
                self.loginService.UpdateUser(user: self.user) { (response) in
                    print("response")
                }
            }
        }
    }
    
    
    @IBAction func adresseEditAction(_ sender: Any) {
        if(self.btnEditAdresse.title(for: .normal) == "تعديل"){
            self.adresseEdit.isUserInteractionEnabled = true
            self.btnEditAdresse.setTitle("تسجيل", for: .normal)
        }
        else{
            self.adresseEdit.isUserInteractionEnabled = false
            self.btnEditAdresse.setTitle("تعديل", for: .normal)
            if(self.adresseEdit.text != self.user.adresseBureau){
                self.user.adresseBureau = self.adresseEdit.text!
                self.loginService.UpdateUser(user: self.user) { (response) in
                    print("response")
                }
            }
        }
    }
    
    
    @IBAction func telEditAction(_ sender: Any) {
        if(self.btnEditTel.title(for: .normal) == "تعديل"){
            self.telEdit.isUserInteractionEnabled = true
            self.btnEditTel.setTitle("تسجيل", for: .normal)
        }
        else{
            self.telEdit.isUserInteractionEnabled = false
            self.btnEditTel.setTitle("تعديل", for: .normal)
            if(self.telEdit.text != self.user.tel){
                self.user.tel = self.telEdit.text!
                self.loginService.UpdateUser(user: self.user) { (response) in
                    print("response")
                }
            }
        }
    }
    
    @IBAction func degreeEditAction(_ sender: Any) {
        if(self.btnEditDegree.title(for: .normal) == "تعديل"){
            self.degreeEdit.isUserInteractionEnabled = true
            self.btnEditDegree.setTitle("تسجيل", for: .normal)
            
        }
        else{
            self.degreeEdit.isUserInteractionEnabled = false
            self.btnEditDegree.setTitle("تعديل", for: .normal)
            self.degree.text = self.degreeEdit.text!
            if(self.degreeEdit.text != self.user.grade){
                self.user.grade = self.degreeEdit.text!
                self.loginService.UpdateUser(user: self.user) { (response) in
                    print("response")
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
