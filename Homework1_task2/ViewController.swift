//
//  ViewController.swift
//  Homework1_task2
//
//  Created by Mark Osipov on 06.07.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var redLightView: UIView!
    @IBOutlet weak var yellowLightView: UIView!
    @IBOutlet weak var greenLightView: UIView!
    @IBOutlet weak var switchLightButton: UIButton!

    let lightTurnOnAlpha: CGFloat = 1.0
    let lightTurnOffAlpha: CGFloat = 0.3

    lazy var lightViews = [redLightView, yellowLightView, greenLightView]

    var currentLight: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        switchLightButton.layer.cornerRadius = 10

        lightViews.forEach { lightView in
            if let lightView = lightView{
                lightView.alpha = lightTurnOffAlpha
            }
        }
    }

    override func viewWillLayoutSubviews() {
        //Неправильно рассчитывается радиус, если делать это в viewDidLoad(), круги получаются с углами
        resizeLightsCircles()
    }

    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        //При повороте пересчитываем радиус, иначе круги будут с углами
        resizeLightsCircles()
    }

    @IBAction func switchLightButtonPressed() {
        if let currentLight = currentLight {
            switchLight(nextLight: getNextLight(currentLight))
        } else {
            switchLight(nextLight: 0)
            switchLightButton.setTitle("NEXT", for: .normal)
        }
    }

    func getNextLight(_ currentLight: Int) -> Int {
        return (currentLight + 1) % 3
    }

    func switchLight(nextLight: Int) {
        for i in 0 ..< lightViews.endIndex {
            lightViews[i]?.alpha = (i == nextLight) ? lightTurnOnAlpha : lightTurnOffAlpha
        }
        currentLight = nextLight
    }

    func resizeLightsCircles() {
        redLightView.layer.cornerRadius = redLightView.frame.width / 2
        yellowLightView.layer.cornerRadius = yellowLightView.frame.width / 2
        greenLightView.layer.cornerRadius = greenLightView.frame.width / 2
    }
}

