//
//  RegisterUserViewController.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 14/06/23.
//

import UIKit

class RegisterUserViewController: UIViewController{
    
    // MARK: outlet declration
    
    @IBOutlet weak var cnfPasswordULView: UIView!
    @IBOutlet weak var passwordULView: UIView!
    @IBOutlet weak var emailULView: UIView!
    @IBOutlet weak var mobileULView: UIView!
    @IBOutlet weak var nameULView: UIView!
    @IBOutlet weak var cnfPasswordAlertMsgLabel: UILabel!
    @IBOutlet weak var passwordAlertMesageLabel: UILabel!
    @IBOutlet weak var emailAlertMessageLabel: UILabel!
    @IBOutlet weak var mobileAlertMessageLabel: UILabel!
    @IBOutlet weak var nameAlertMessageLabel: UILabel!
    @IBOutlet weak var allContentView: UIView!
    @IBOutlet weak var cnfPwdEyeButton: UIButton!
    @IBOutlet weak var cnfPwdEyeImgView: UIImageView!
    @IBOutlet weak var pwdEyeButton: UIButton!
    @IBOutlet weak var pwdEyeImgView: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cnfPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: variable declration
    
    var hide = false
    var cHide = false
    var user : [String:String] = [:]
    var arrOfData : [Dictionary<String,String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        selfDelegateTextField()
        Common.delegate.applyShadowOnView(allContentView)
        Common.delegate.applyRadiusButton(signUpButton, 12, 0, .clear)
        
        
    }
    
    func configureUI() {
        pwdEyeImgView.image = UIImage(named: "eyeClose")
        cnfPwdEyeImgView.image = UIImage(named: "eyeClose")
        passwordTextField.isSecureTextEntry = false
        cnfPasswordTextField.isSecureTextEntry = false
        
        editAlertMessage(nameAlertMessageLabel, nameULView, "", .clear, .systemGray5, false)
        editAlertMessage(mobileAlertMessageLabel, mobileULView, "", .clear, .systemGray5, false)
        editAlertMessage(emailAlertMessageLabel, emailULView, "", .clear, .systemGray5, false)
        editAlertMessage(passwordAlertMesageLabel, passwordULView, "", .clear, .systemGray5, false)
        editAlertMessage(cnfPasswordAlertMsgLabel, cnfPasswordULView, "", .clear, .systemGray5, false)
    }
    
    func selfDelegateTextField() {
        nameTextField.delegate = self
        mobileTextField.delegate = self
        emailTextField.delegate  = self
        passwordTextField.delegate = self
        cnfPasswordTextField.delegate = self
        //nameTextField.becomeFirstResponder()
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespaces)
        let mobile = mobileTextField.text?.trimmingCharacters(in: .whitespaces)
        let email = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        
        if name?.count != 0 && mobile?.count != 0 && email?.count != 0 && password?.count != 0 {
            let flag = validationTextField()
            if flag == true {
                // MARK: Code Here
             
                //loadDataUseUserDefault()
                //loadDataUsePList()
                if !getCoreDatabeforeSignUp() {
                    loadDataInCoreData()
                }
            }
        } else {
            Common.delegate.alert(view: self, title: "All Field", message: "please fill the all field")
            alertBothField("* Please fill the field")
        }
        
    }
    
    // MARK: Load data using Core Data
    
    func loadDataInCoreData() {
        let dict : [String:String] = ["name":nameTextField.text!,"email":emailTextField.text!,"mobile":mobileTextField.text!,"password":passwordTextField.text!]
        DatabaseHelper.shareInstance.save(object: dict)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: Check validation
    
    func getCoreDatabeforeSignUp() -> Bool{
        var arg = false
        let data  = DatabaseHelper.shareInstance.getUserData()
        for i in data {
            if emailTextField.text == i.email && mobileTextField.text == i.mobile {
                arg = true
                editAlertMessage(mobileAlertMessageLabel, mobileULView, "Mobile number already exist", .red, .red, false)
                editAlertMessage(emailAlertMessageLabel, emailULView, "Email already exist", .red, .red, false)
            }else if emailTextField.text == i.email || mobileTextField.text == i.mobile {
                if mobileTextField.text == i.mobile {
                    arg = true
                    editAlertMessage(mobileAlertMessageLabel, mobileULView, "Mobile number already exist", .red, .red, false)
                }else if emailTextField.text == i.email {
                    arg = true
                    editAlertMessage(emailAlertMessageLabel, emailULView, "Email already exist", .red, .red, false)
                }
            }
        }
       return arg
    }
    
    // MARK: Load data using UserDeafault
    func loadDataUseUserDefault() {
        let dict = ["name":nameTextField.text,"mobile":mobileTextField.text,"email":emailTextField.text,"password":passwordTextField.text]
         //  DatabaseHelper.shareInstance.save(object: dict as! [String:String])
        //self.navigationController?.popViewController(animated: true)
        for (key, value) in dict {
            UserDefaults.standard.set(value, forKey: key)
        }
        defer {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: Load data using PList
    func loadDataUsePList() {
        let users = [User(userName: nameTextField.text!, userMobile: mobileTextField.text!, userEmail: emailTextField.text!, userPassword: passwordTextField.text!)]
        
        guard let plistURL = Bundle.main.url(forResource: "MyUserData", withExtension: "plist") else {
            return
        }
        print("Plist :\(plistURL)")

        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml

            let data = try encoder.encode(users)
            try data.write(to: plistURL)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        } catch {
            print("Encoding error: \(error)")
        }
        
    }
    
    
    
    func validationTextField()->Bool {

        if !Validation.delegate.isValidPhone(phone: mobileTextField.text!){
            Common.delegate.alert(view: self, title: "Mobile Number", message: "Please enter valid number")
            return false
        }else if !Validation.delegate.isValid(email: emailTextField.text!){
            Common.delegate.alert(view: self, title: "Email", message: "Please enter valid email")
            return false
        }else if !Validation.delegate.isValidPassword(password: passwordTextField.text!){
            Common.delegate.alert(view: self, title: "Password ", message: "length 6 to 16.\n One Alphabet in Password.\n One Special Character in Password.")
            return false
        }else if passwordTextField.text != cnfPasswordTextField.text {
                Common.delegate.alert(view: self, title: "Confirm Password", message: "Password and Confirm Password does not match")
            return false
        }else {
            return true
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    
    
    @IBAction func pwdEyeButtonAction(_ sender: Any) {
        if hide == true {
            hide = false
            passwordTextField.isSecureTextEntry = true
            pwdEyeImgView.image = UIImage(named: "eyeClose")
        }else {
            hide = true
            passwordTextField.isSecureTextEntry = false
            pwdEyeImgView.image = UIImage(named: "eyeOpen")
        }
    }
    
    
    
    @IBAction func cnfPwdEyeButtonAction(_ sender: Any) {
        if cHide == true {
            cHide = false
            cnfPasswordTextField.isSecureTextEntry = true
            cnfPwdEyeImgView.image = UIImage(named: "eyeClose")
        }else {
            cHide = true
            cnfPasswordTextField.isSecureTextEntry = false
            cnfPwdEyeImgView.image = UIImage(named: "eyeOpen")
        }
        
    }
    
    //MARK: TextField Validation Alert Message
    func editAlertMessage(_ label:UILabel,_ view:UIView,_ msg:String,_ txColor:UIColor,_ bgColor:UIColor,_ alert:Bool) {
        if alert == true {
            label.isHidden = true
        }else {
            label.isHidden = false
        }
        label.text = msg
        label.textColor = txColor
        view.backgroundColor = bgColor
    }
    
    //MARK:
    func alertBothField(_ str:String) {
        editAlertMessage(nameAlertMessageLabel, nameULView, str, .red, .red, false)
        editAlertMessage(mobileAlertMessageLabel, mobileULView, str, .red, .red, false)
        editAlertMessage(emailAlertMessageLabel, emailULView, str, .red, .red, false)
        editAlertMessage(passwordAlertMesageLabel, passwordULView,str, .red, .red, false)
        editAlertMessage(cnfPasswordAlertMsgLabel, cnfPasswordULView, str, .red, .red, false)
    }
    
}

extension RegisterUserViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength:Int = 10
        if textField == nameTextField {
            editAlertMessage(nameAlertMessageLabel, nameULView, "", .clear, .systemGray5, true)
            maxLength = 24
        }else if textField == mobileTextField {
            editAlertMessage(mobileAlertMessageLabel, mobileULView, "", .clear, .systemGray5, true)
            maxLength = 10
        }else if textField == emailTextField {
            editAlertMessage(emailAlertMessageLabel, emailULView, "", .clear, .systemGray5, true)
            maxLength = 30
        }else if textField == passwordTextField {
            editAlertMessage(passwordAlertMesageLabel, passwordULView, "", .clear, .systemGray5, true)
            maxLength = 16
        }else if textField == cnfPasswordTextField {
            editAlertMessage(cnfPasswordAlertMsgLabel, cnfPasswordULView, "", .clear, .systemGray5, true)
            maxLength = 16
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField ==  mobileTextField {
            if !Validation.delegate.isValidPhone(phone: mobileTextField.text!){
                editAlertMessage(mobileAlertMessageLabel, mobileULView, "Please enter valid mobile number", .red, .red, false)
            }else {
                editAlertMessage(mobileAlertMessageLabel, mobileULView, "", .clear, .systemGray5, false)
            }
        }else if textField ==  emailTextField {
            if !Validation.delegate.isValid(email: emailTextField.text!){
                editAlertMessage(emailAlertMessageLabel, emailULView, "Please enter valid email", .red, .red, false)
            }else {
                editAlertMessage(emailAlertMessageLabel, emailULView, "", .clear, .systemGray5, false)
            }
        }else if textField ==  passwordTextField {
            if !Validation.delegate.isValidPassword(password: passwordTextField.text!){
                editAlertMessage(passwordAlertMesageLabel, passwordULView, "Please enter valid password", .red, .red, false)
            }else {
                editAlertMessage(passwordAlertMesageLabel, passwordULView, "", .clear, .systemGray5, false)
            }
        }else if textField ==  cnfPasswordTextField {
            if passwordTextField.text != cnfPasswordTextField.text{
                editAlertMessage(cnfPasswordAlertMsgLabel, cnfPasswordULView, "confirm password does not match", .red, .red, false)
            }else {
                editAlertMessage(cnfPasswordAlertMsgLabel, cnfPasswordULView, "", .clear, .systemGray5, false)
            }
        }
    }
}
