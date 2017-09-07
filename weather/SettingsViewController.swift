//
//  SettingsViewController.swift
//  weather
//
//  Created by MCS on 9/7/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var zipFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        zipFld.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        zipFld.text = UserDefaults.standard.string(forKey: "Zip")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if let text = zipFld.text {
            UserDefaults.standard.set(text, forKey: "Zip")
        }
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
