//
//  CreditsViewController.swift
//  The Passage
//
//  Created by Afina R. Vinci on 24/07/18.
//  Copyright © 2018 afinarv. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton()
        button.frame = CGRect(x: self.view.frame.size.width - 100, y: 50, width: 30, height: 30)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle("x", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(exit), for: .touchUpInside)

            self.view.addSubview(button)
        
    }

    @objc func exit() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "HomeScene") as! HomeViewController
        self.present(vc, animated: true, completion: nil)
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
