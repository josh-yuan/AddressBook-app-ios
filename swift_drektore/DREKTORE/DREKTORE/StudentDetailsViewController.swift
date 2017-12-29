//
//  StudentDetailsViewController.swift
//  DREKTORE
//
//  Created by Joshua on 12/27/17.
//  Copyright © 2017 Joshua. All rights reserved.
//

import UIKit
import MessageUI

class StudentDetailsViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var studentName: UITextView!
    @IBOutlet weak var phone: UITextView!
    @IBOutlet weak var email: UITextView!
    @IBOutlet weak var address: UITextView!
    
    var studentInfo: Student?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        photo.image = UIImage(named: "placeholderYellow")
        studentName.text = (studentInfo?.firstName)! + " " +  (studentInfo?.lastName)!
        phone.text = (studentInfo?.phoneNumber)!
        email.text = (studentInfo?.email)!
        address.text = (studentInfo?.address)!
        
        photo.layer.cornerRadius = 10.0
        photo.clipsToBounds = true
    }
    
    @IBAction func sendMSG(_ sender: Any) {
        sendSMSText(phoneNumber: phone.text)
    }
    func sendSMSText(phoneNumber: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
