//
//  DetailViewController.swift
//  SoF-MedList
//
//  Created by Pascal Pfiffner on 6/20/14.
//  Copyright (c) 2014 SMART Platforms. All rights reserved.
//

import UIKit
import SMART


class DetailViewController: UIViewController, UISplitViewControllerDelegate {
	
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func viewDetail_Click(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let jsonVC = mainStoryboard.instantiateViewController(withIdentifier: "jsonView") as? JSONViewController {
                //self.present(detailVC, animated: true, completion: nil)
                do {
                    let data = try JSONSerialization.data(withJSONObject: resource!.asJSON(), options: .prettyPrinted)
                    let string = String(data: data, encoding: String.Encoding.utf8)
                    jsonVC.jsonString = string
                }
                catch let error {
                    jsonVC.jsonString = "\(error)"
                }
                navigationController?.pushViewController(jsonVC, animated: true)
            }
    }
    
    /// The prescription to show details about
	var resource: Resource?
		
	func configureView() {
        if let detail = resource {
            let resourceDisp = ResourceDisplay(res: detail)
            nameLabel.text = resourceDisp.name
            descriptionLabel.text = resourceDisp.description
        }
        else {
            nameLabel.text = "No resource selected"
            descriptionLabel.text = "Select a resource"
        }
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
	}
	
	
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

