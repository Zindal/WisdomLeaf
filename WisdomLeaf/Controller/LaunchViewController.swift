//
//  LaunchViewController.swift
//  WisdomLeaf
//
//  Created by Zindal on 02/05/23.
//

import Foundation
import UIKit

class LaunchViewController: UIViewController {
    // We can use native launch screen but as mentioned need to show splash for 5 second, so added this logic.
    override func viewDidAppear(_ animated: Bool) {
        let seconds = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: "homeNav") as? UINavigationController
            let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDel.window?.rootViewController = navigationVC
        }
    }
}
