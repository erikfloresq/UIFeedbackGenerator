//
//  ViewController.swift
//  Action
//
//  Created by Erik Flores on 12/26/16.
//  Copyright © 2016 Weriklandia. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var feedbackGenerator : UINotificationFeedbackGenerator? =  nil
    @IBOutlet weak var urlApi: UITextField!
    @IBOutlet weak var textAreaResult: UITextView!
    @IBOutlet weak var btnTest: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlApi.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func apply(_ sender: Any) {
        self.execRequest()
    }
    
    func execRequest() {
        self.feedbackGenerator = UINotificationFeedbackGenerator()
        self.feedbackGenerator?.prepare()
        self.btnTest.titleLabel?.text = "Testing ..."
        Alamofire.request(self.urlApi.text!).responseJSON { (response) in
            print(response.request ?? "no request")
            switch response.result {
            case .success :
                if let  JSON = response.result.value {
                    print("JSON : \(JSON)")
                    self.textAreaResult.text = "\(JSON)"
                    self.btnTest.setTitle("Success 😎", for: .normal)
                    self.btnTest.backgroundColor = UIColor(netHex: 0x4DA83E)
                    self.feedbackGenerator?.notificationOccurred(.success)
                    self.feedbackGenerator = nil
                }
            case .failure(let error) :
                print("Error", error.localizedDescription)
                self.textAreaResult.text = "\(error.localizedDescription)"
                self.btnTest.setTitle("Fail 😱", for: .normal)
                self.btnTest.backgroundColor = UIColor(netHex: 0xBE1E26)
                self.feedbackGenerator?.notificationOccurred(.error)
                self.feedbackGenerator = nil
            }
        }
    }


}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.execRequest()
        return textField.resignFirstResponder()
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

