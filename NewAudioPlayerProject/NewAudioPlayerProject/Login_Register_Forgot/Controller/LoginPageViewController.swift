//
//  LoginPageViewController.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 13/06/23.
//

import UIKit


struct User:Codable {
    let userName:String
    let userMobile:String
    let userEmail:String
    let userPassword:String
}



class LoginPageViewController: UIViewController {
    
    // MARK: Outlet declaration
    
    @IBOutlet weak var paswdUnderLineView: UIView!
    @IBOutlet weak var paswdAlertMsgLabel: UILabel!
    @IBOutlet weak var emailUnderLineView: UIView!
    @IBOutlet weak var emailAlertMsgLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pwdEyeImgView: UIImageView!
    @IBOutlet weak var allContentView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Variable declaration
    
    var hide = false
    
    var userName:String?
    var userPassword:String?
    var userEmail:String?
    var userMobile:String?
    var userDictionary:[String:String] = [:]
    var userDictionary1:[String:String] = [:]
    var plistUserDictionary:[String:Any] = [:]
    
    
    var userRegisterData = [RegisterUser]()
    
    var user : [String:String] = [:]
    var arrOfData : [Dictionary<String,String>] = []
    // MARK: viewDidLoad function , it's  run once
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        initialUserDefaultChecks()
        
        // DatabaseHelper.shareInstance.deleteAllData()
        
    }
    
    // MARK: viewWillAppear function , it's run everytime
    override func viewWillAppear(_ animated: Bool) {
        //afterSignupUserDefault()
        //getDataAfterSignUpWithPList()
        let emText = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        let pasText = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        if emText?.count == 0 || pasText?.count == 0 {
            editAlertMessage(emailAlertMsgLabel, emailUnderLineView, "", .clear, .systemGray5, true)
            editAlertMessage(paswdAlertMsgLabel, paswdUnderLineView, "", .clear, .systemGray5, true)
        }
        getCoreDataAfterSignUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        textFieldEmptyAction()
        let text = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        if text?.count != 0 {
            textFieldEmptyAction()
            emailTextField.becomeFirstResponder()
        }
    }
    
    // MARK: UI Configuration
    func configureUI(){
        
        Common.delegate.applyShadowOnView(allContentView)
        Common.delegate.applyRadiusButton(loginButton, 12, 0, .clear)
        
        passwordTextField.isSecureTextEntry = true
        pwdEyeImgView.image = UIImage(named: "eyeClose")
        emailAlertMsgLabel.isHidden = true
        paswdAlertMsgLabel.isHidden = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
        editAlertMessage(emailAlertMsgLabel, emailUnderLineView, "", .clear, .systemGray5, true)
        editAlertMessage(paswdAlertMsgLabel, paswdUnderLineView, "", .clear, .systemGray5, true)
    }
    
    //MARK: Login Button Action
    @IBAction func loginButtonAction(_ sender: Any) {
        //loginWithUsingUserDefault()
        //loginWithPListData()
        //deleteAll()
        // DatabaseHelper.shareInstance.deleteAllData()
        
        loginWithCoreData()
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
    
    //MARK: Initial time check user login
    func initialUserDefaultChecks() {
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")
        let name = UserDefaults.standard.string(forKey: "name")
        let mobile = UserDefaults.standard.string(forKey: "mobile")
        if let email = email , let password = password{
            print(email,password)
            getCoreDataAfterSignUp()
            do {
                var fd = false
                var id = Int()
                for i in 0..<arrOfData.count {
                    if email == arrOfData[i]["email"] && password == arrOfData[i]["password"] {
                        fd = true
                        id = i
                    }
                }
                if fd == true {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
                    vc.dict = arrOfData[id]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
    // MARK: Login  with core data
    func loginWithCoreData() {
        var fd = false
        var id = Int()
        //let data  = DatabaseHelper.shareInstance.getUserData()
        for i in 0..<arrOfData.count {
            if emailTextField.text == arrOfData[i]["email"] && passwordTextField.text == arrOfData[i]["password"] {
                fd = true
                id = i
            }
        }
        if fd == true {
            loadDataUseUserDefault(email: arrOfData[id]["name"]!, mobile: arrOfData[id]["mobile"]!, name: arrOfData[id]["email"]!, password: arrOfData[id]["password"]!)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
            vc.dict = arrOfData[id]
           // vc.userNameLabel.text = arrOfData[id]["name"]
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            fd = false
            var eml = false
            for i in 0..<arrOfData.count {
                if emailTextField.text == arrOfData[i]["email"]{
                    eml = true
                }
            }
            defer {
                if eml == true {
                    editAlertMessage(paswdAlertMsgLabel, paswdUnderLineView, "* Password is incorrect", .red, .red, false)
                    passwordTextField.text = ""
                }else {
                    editAlertMessage(emailAlertMsgLabel, emailUnderLineView, "* Email Id does not exsit", .red, .systemGray5, false)
                    textFieldEmptyAction()
                }
            }
            //Common.delegate.alert(view: self, title: "Login  Credentials", message: "Email Id and Password are incorrect")
        }
    }
    
    //MARK: Retrive data from core data
    func getCoreDataAfterSignUp(){
        arrOfData.removeAll()
        let data  = DatabaseHelper.shareInstance.getUserData()
        for i in data {
            user["name"] = i.name
            user["mobile"] = i.mobile
            user["email"] = i.email
            user["password"] = i.password
            arrOfData.append(user)
        }
        print(arrOfData)
    }
    
    //MARK: Retrive data from UserDefault
    func afterSignupUserDefault() {
        userEmail = UserDefaults.standard.string(forKey: "email")
        userPassword = UserDefaults.standard.string(forKey: "password")
        userName = UserDefaults.standard.string(forKey: "name")
        userMobile = UserDefaults.standard.string(forKey: "mobile")
        if let name = userName, let email = userEmail, let mobile = userMobile, let password = userPassword {
            userDictionary["name"] = name
            userDictionary["email"] = email
            userDictionary["mobile"] = mobile
            userDictionary["password"] = password
        }
    }
    
    //MARK: Retrive data from PList
    func getDataAfterSignUpWithPList() {
        if let plistPath = Bundle.main.path(forResource: "MyUserData", ofType: "plist"), let data = FileManager.default.contents(atPath: plistPath), let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String:String]] {
            print(plist)
            self.plistUserDictionary = plist[0]
            //print(self.plistUserDictionary["email"])
        }else{
            print("Path not found")
        }
    }
    
    //MARK: passowrd hide and show button action
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
    
    //MARK: Save Login Detail
    func loadDataUseUserDefault(email:String,mobile:String,name:String,password:String) {
        let dict = ["name":email,"mobile":mobile,"email":name,"password":password]
        //  DatabaseHelper.shareInstance.save(object: dict as! [String:String])
        //self.navigationController?.popViewController(animated: true)
        for (key, value) in dict {
            UserDefaults.standard.set(value, forKey: key)
        }
        defer {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: Login with PList
    func loginWithPListData() {
        let emailText = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        let passwordText =  passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        if emailText?.count != 0 &&  passwordText?.count != 0 {
            
            // print(email,"  ",password)
            if emailTextField.text == plistUserDictionary["userEmail"] as? String && passwordTextField.text == plistUserDictionary["userPassword"] as? String {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                Common.delegate.alert(view: self, title: "Credentials", message: "Email Id and Password is incorrect")
            }
        }else {
            Common.delegate.alert(view: self, title: "Credentials", message: "Please fill all fields")
        }
    }
    
    //MARK: Login with UserDefault
    func loginWithUsingUserDefault() {
        guard let _ = userName,let email = userEmail, let _ = userMobile, let password = userPassword else {
            Common.delegate.alert(view: self, title: "Login", message: "Account does not exist")
            return
        }
        // let dict:[String:Any] = ["name":name,"email":email,"password":password,"mobile":mobile]
        
        let emailText = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        let passwordText =  passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        if emailText?.count != 0 &&  passwordText?.count != 0 {
            if emailTextField.text != email {
                Common.delegate.alert(view: self, title: "Login Credentials", message: "Your Email does not exist. please enter the registered email")
            }else if passwordTextField.text != password {
                Common.delegate.alert(view: self, title: "Login Credentials", message: "Password is incorrect")
            }else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                vc.dict = userDictionary
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else {
            Common.delegate.alert(view: self, title: "Credentials", message: "Please fill all fields")
        }
    }
    
    //MARK: SignUp button action
    @IBAction func signUpButtonAction(_ sender: Any) {
        textFieldEmptyAction()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: Forgot password button action
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FogotPasswordViewController") as! FogotPasswordViewController
        vc.arrOfData = userDictionary1
        vc.arrOfUserData = self.arrOfData
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: After Action TextField empty
    func textFieldEmptyAction() {
        emailTextField.text = ""
        passwordTextField.text = ""
        emailTextField.becomeFirstResponder()
    }
    
}

extension LoginPageViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            editAlertMessage(emailAlertMsgLabel, emailUnderLineView, "", .clear, .systemGray5, true)
        }else if textField == passwordTextField {
            editAlertMessage(paswdAlertMsgLabel, paswdUnderLineView, "", .clear, .systemGray5, true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            if !Validation.delegate.isValid(email: emailTextField.text!) {
                editAlertMessage(emailAlertMsgLabel, emailUnderLineView, "* Please enter valid id", .red, .red, false)
            }else {
                editAlertMessage(emailAlertMsgLabel, emailUnderLineView, "", .clear, .systemGray5, true)
            }
        }
    }
}
