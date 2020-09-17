//
//  JSONViewController.swift
//  SoF-Demo
//
//  Created by Dan Cinnamon on 9/14/20.
//  Copyright © 2020 SMART Platforms. All rights reserved.
//

import UIKit
import SMART


class JSONViewController: UIViewController, UISplitViewControllerDelegate {
    
    var jsonString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        json.text = jsonString
    }
    
    @IBOutlet weak var json: UILabel!
    
    // MARK: - Split view
    
    func splitViewController(_ splitController: UISplitViewController, willShow viewController: UIViewController, invalidating barButtonItem: UIBarButtonItem) {
        // Called when the view is shown again in the split view, invalidating the button and popover controller.
        self.navigationItem.setLeftBarButton(nil, animated: true)
    }
    
    func splitViewController(_ splitController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        // We want ourselves to be separated
        return self
    }
}
