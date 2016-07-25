//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Nolan Lapham on 7/20/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController
{

	private let emotionalFaces: Dictionary<String, FacialExpression> = [
		"angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
		"happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
		"worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
		"mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin),
	]

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		var destinationVC = segue.destinationViewController
		if let navCon = destinationVC as? UINavigationController {						//If EmotionsVC is looking at the Nav, make it look at the FaceVC
			destinationVC = navCon.visibleViewController ?? destinationVC
		}
		if let faceVC = destinationVC as? FaceViewController {
			if let identifier = segue.identifier {
				if let expression = emotionalFaces[identifier] {
					faceVC.expression = expression
					if let sendingButton = sender as? UIButton {
						faceVC.navigationItem.title = sendingButton.currentTitle
					}
				}
			}
		}
		
    }
	
}
