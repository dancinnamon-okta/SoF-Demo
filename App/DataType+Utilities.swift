//
//  DataType+Utilities.swift
//
//  Created by Dave Carlson on 2/18/17.
//  Copyright © 2017 Clinical Cloud Solutions, LLC. All rights reserved.
//

import Foundation
import SMART

extension CodeableConcept {
	
	func displayString(system: String? = nil) -> String? {
		// if text is provided, use as default human-readable display
		if let text = text?.string {
			return text
		}
		
		var selectedCoding: Coding?
		
		if let codeableConcepts = coding {
			for coding in codeableConcepts {
				if let codeSystem = system {
					// if 'system' parameter included, use first matching Coding
					if codeSystem == coding.system?.absoluteString {
						selectedCoding = coding
						break
					}
				}
				else {
					// use the first coding
					selectedCoding = coding
					break
				}
			}
		}
		
		return selectedCoding?.display?.string ?? selectedCoding?.code?.string
	}
	
}


extension Period {
	
	func displayString() -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
		
		var startString: String?
		var endString: String?
		if let startDate = start {
			startString = dateFormatter.string(from: startDate.nsDate)
		}
		if let endDate = end {
			endString = dateFormatter.string(from: endDate.nsDate)
		}
		
		var displayString: String?
		if let from = startString, let to = endString {
			displayString = "Between " + from + " and " + to
		}
		else if let from = startString {
			displayString = "After " + from
		}
		else if let to = endString {
			displayString = "Before " + to
		}
		
		
		return displayString
	}
	
}

struct ResourceDisplay {
    var name: String = ""
    var description: String = ""
    init(res: Resource) {
        if let claim = res as? Claim {
            if let patient = claim.patient?.display {
                name = "Claim for " + patient.string
            }
            else {
                name = "Claim for unkown patient"
            }
            
            description = "Purpose: " + claim.item![0].productOrService!.displayString()! + "\n\n"
            description += "Payee: " + claim.provider!.display!.string + "\n\n"
            description += "Date: " + claim.billablePeriod!.start!.description + "\n\n"
            description += "Total Amount: $" + claim.total!.value!.description
        }
        else {
            name = (type(of: res).resourceType)
            description = try! res.relativeURLPath()
        }
    }
}
