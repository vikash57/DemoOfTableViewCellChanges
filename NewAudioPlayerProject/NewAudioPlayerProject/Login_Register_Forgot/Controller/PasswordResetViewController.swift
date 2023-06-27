//
//  PasswordResetViewController.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 14/06/23.
//

import UIKit

class PasswordResetViewController: UIViewController {

    // MARK: Outlet declaration
    
    @IBOutlet weak var pswdNotisLabel: UILabel!
    
    @IBOutlet weak var cnfPasswordULView: UIView!
    @IBOutlet weak var cnfPasswordAlertLabel: UILabel!
    @IBOutlet weak var passwordULView: UIView!
    @IBOutlet weak var passwordAlerMsgLabel: UILabel!
    @IBOutlet weak var cnfPasswordTextField: UITextField!
    @IBOutlet weak var updatePasswordButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cnfPwdEyeImgView: UIImageView!
    @IBOutlet weak var pwdEyeImgView: UIImageView!
    
    // MARK: Variable Declaration
    
    var hide = false
    var cHide = false
    var id = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        cnfPasswordTextField.delegate = self
        passwordTextField.becomeFirstResponder()
        
        pswdNotisLabel.text = """
                              * length 6 to 16.
                                One Alphabet in Password.
                                One Special Character in Password.
                            """
        
        Common.delegate.alert(view: self, title: "Mobile Number", message: "Number Verified Please Proceed")
        configureUI()
    }
    
    func configureUI() {
        passwordTextField.isSecureTextEntry = true
        pwdEyeImgView.image = UIImage(named: "eyeClose")
        cnfPasswordTextField.isSecureTextEntry = true
        cnfPwdEyeImgView.image = UIImage(named: "eyeClose")
        Common.delegate.applyRadiusButton(updatePasswordButton, 12, 0, .clear)
        
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
    
    //MARK: Updata password button action
    @IBAction func updatePasswordButtonAction(_ sender: Any) {
        
        if passwordTextField.text?.count == 0 {
            editAlertMessage(passwordAlerMsgLabel, passwordULView, "* Please enter the new password", .red, .red, false)
            //Common.delegate.alert(view: self, title: "New Password", message: "please enter the new password")
        }else if !Validation.delegate.isValidPassword(password: passwordTextField.text!){
            editAlertMessage(passwordAlerMsgLabel, passwordULView, "* Please enter the valid password", .red, .red, false)
            //Common.delegate.alert(view: self, title: "Password ", message: "length 6 to 16.\n One Alphabet in Password.\n One Special Character in Password.")
        }else if passwordTextField.text != cnfPasswordTextField.text{
            editAlertMessage(passwordAlerMsgLabel, passwordULView, "* New Password and Confirm Password do not match", .red, .red, false)
            //Common.delegate.alert(view: self, title: "Confirm Password", message: "New Password and Confirm Password do not match")
        }else {
            //MARK: Code here
            setPasswordWithCoreData()
        }
    }
    
    func setPasswordWithCoreData() {
        var dict:[String:String] = ["password":passwordTextField.text!]
        DatabaseHelper.shareInstance.editData(obj: dict, i: id)
        defer {
            if let navigationController = self.navigationController {
                let viewControllers = navigationController.viewControllers
                if viewControllers.count >= 3 {
                    // Assuming the first view controller is at index 0
                    let firstViewController = viewControllers[0]
                    navigationController.popToViewController(firstViewController, animated: true)
                }
            }
        }
    }
    
    //MARK: Set password use userDefault
    func setUserDefaultPasswordReset() {
        UserDefaults.standard.set(passwordTextField.text, forKey: "password")
        if let navigationController = self.navigationController {
            let viewControllers = navigationController.viewControllers
            if viewControllers.count >= 3 {
                // Assuming the first view controller is at index 0
                let firstViewController = viewControllers[0]
                navigationController.popToViewController(firstViewController, animated: true)
            }
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
    
}

extension PasswordResetViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLenth:Int = 16
        let currentString:NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLenth

    }
}


/*
 let maxLength:Int = 10
 let currentString: NSString = textField.text! as NSString
 
 let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
 return newString.length <= maxLength
 */
