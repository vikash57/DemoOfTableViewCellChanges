//
//  FogotPasswordViewController.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 14/06/23.
//

import UIKit

class FogotPasswordViewController: UIViewController {

    // MARK: Outlet declaration
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var mobileULView: UIView!
    @IBOutlet weak var mobileAlertMessageLabel: UILabel!
    // MARK: Variable Declaration
    
    var arrOfData:[String:Any]?
    var userMobile:String?
    
    var arrOfUserData : [Dictionary<String,String>] = []
    var id = Int()
    // MARK: This Function call Once
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: UIConfiguration
    func configureUI() {
        mobileTextField.delegate = self
        //mobileTextField.becomeFirstResponder()
        
        Common.delegate.applyRadiusButton(nextButton, 8, 0, .clear)
        editAlertMessage(mobileAlertMessageLabel, mobileULView, "", .clear, .systemGray5, true)
    }
    
    // MARK: textFieldDelegate

    @IBAction func nextButtonAction(_ sender: Any) {
        let mobile = mobileTextField.text?.trimmingCharacters(in: .whitespaces)
        if mobile?.count == 0 {
            editAlertMessage(mobileAlertMessageLabel, mobileULView, "Please enter the mobile number", .red, .red, false)
            Common.delegate.alert(view: self, title: "Mobile Number", message: "please enter the mobile number")
        }else {
            if !Validation.delegate.isValidPhone(phone: mobileTextField.text!){
                editAlertMessage(mobileAlertMessageLabel, mobileULView, "Please enter the valid mobile number", .red, .red, false)
                Common.delegate.alert(view: self, title: "Mobile Number", message: "please enter the valid number")
            }else {
                //MARK: Code here
                changePasswordWithCoreData()
            }
            
        }
        
    }
    
    func changePasswordWithCoreData() {
        var fd = false
        
        //let data  = DatabaseHelper.shareInstance.getUserData()
        for i in 0..<arrOfUserData.count {
            if mobileTextField.text == arrOfUserData[i]["mobile"]{
                fd = true
                self.id = i
            }
        }
        if fd == true {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordResetViewController") as! PasswordResetViewController
            vc.id = self.id
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            fd = false
            editAlertMessage(mobileAlertMessageLabel, mobileULView, "Mobile Number does not exist", .red, .red, false)
            Common.delegate.alert(view: self, title: "Mobile Veryfication", message: "Mobile Number does not exsit")
        }
    }
    
    func passwordChangeWithUserDefault() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordResetViewController") as! PasswordResetViewController
            guard let number = arrOfData?["mobile"] as? String else{
                Common.delegate.alert(view: self, title: "Mobile Number", message: "Number does not exist")
                return
            }
            if number == mobileTextField.text {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordResetViewController") as! PasswordResetViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                Common.delegate.alert(view: self, title: "Mobile Number", message: "Number does not exist")
            }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        mobileTextField.text = ""
        self.navigationController?.popViewController(animated: true)
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
extension FogotPasswordViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileTextField {
            editAlertMessage(mobileAlertMessageLabel, mobileULView, "", .clear, .systemGray5, true)
        }
        let maxLength:Int = 10
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mobileTextField {
            if !Validation.delegate.isValidPhone(phone: mobileTextField.text!){
                editAlertMessage(mobileAlertMessageLabel, mobileULView, "Please enter the valid mobile number", .red, .red, false)
            }else {
                editAlertMessage(mobileAlertMessageLabel, mobileULView, "", .clear, .systemGray5, true)
            }
        }
    }
}
