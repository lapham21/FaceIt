//
//  ViewController.swift
//  FaceIt
//
//  Created by Nolan Lapham on 7/13/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController
{
	var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile) {
		didSet {
			updateUI()
		}
	}
	
	@IBOutlet weak var faceView: FaceView! {
		didSet {
			
			// PINCH GESTURE RECOGNIZER
			
			faceView.addGestureRecognizer(UIPinchGestureRecognizer(
				target: faceView, action: #selector(FaceView.changeScale(_:))
			))
			
			// SWIPE GESTURE RECOGNIZERS
			
			let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
				target: self, action: #selector(FaceViewController.increaseHappiness)
			)
			happierSwipeGestureRecognizer.direction = .Up
			faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
			
			let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
				target: self, action: #selector(FaceViewController.decreaseHappiness)
			)
			sadderSwipeGestureRecognizer.direction = .Down
			faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
			
			updateUI()
			
		}
	}
	
	@IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
		if recognizer.state == .Ended {
			switch expression.eyes {
			case .Open: expression.eyes = .Closed
			case .Closed: expression.eyes = .Open
			case .Squinting: break
			}
		}
	}
	
	func increaseHappiness() {
		expression.mouth = expression.mouth.happierMouth()
	}
	
	func decreaseHappiness() {
		expression.mouth = expression.mouth.sadderMouth()
	}
	
	private var mouthCurvatures = [
		FacialExpression.Mouth.Frown: -1.0,
		.Grin: 0.5,
		.Smile: 1.0,
		.Smirk: -0.5,
		.Neutral: 0.0
	]
	
	private var eyeBrowTilts = [
		FacialExpression.EyeBrows.Relaxed: 0.5,
		.Furrowed: -0.5,
		.Normal: 0.0
	]
	
	private func updateUI()
	{
		switch expression.eyes {
		case .Open: faceView.eyesOpen = true
		case .Closed: faceView.eyesOpen = false
		case .Squinting: faceView.eyesOpen = false
		}
		faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
		faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
	}
}

