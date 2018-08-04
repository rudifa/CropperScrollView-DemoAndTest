//
//  ViewController.swift
//  CropperScrollView-DemoAndTest
//
//  Created by Rudolf Farkas on 03.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView1: CropperScrollView!

    var scrollView2 = CropperScrollView(frame: .zero) 

    @IBOutlet weak var croppedImageView: UIImageView!

    @IBOutlet weak var labelUsing: UILabel!

    var usingScrollView1 = false

    @IBAction func cropButton(_ sender: UIButton) {
        let selectedScrollView = usingScrollView1 ? scrollView1 : scrollView2
        let cropped = selectedScrollView?.getCroppedImage()
        print("getCroppedImage", cropped?.size as Any)
        croppedImageView.image = cropped
    }

    @IBAction func swapButton(_ sender: UIButton) {
        selectScrollView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView2.frame = scrollView1.frame
        view.addSubview(scrollView2)

        scrollView1.layer.borderColor = UIColor.red.cgColor
        scrollView1.layer.borderWidth = 2
        scrollView2.layer.borderColor = UIColor.green.cgColor
        scrollView2.layer.borderWidth = 2

        let image = UIImage(named: "hodler_landscapes_27_940.jpg")
        scrollView1.loadImage(image: image!)
        scrollView2.loadImage(image: image!)

        selectScrollView()
    }

    private func selectScrollView() {
        usingScrollView1 = !usingScrollView1
        switch usingScrollView1 {
        case true:
            view.bringSubview(toFront: scrollView1)
            labelUsing.text = "Using scroll view instantiated by storyboard"
            labelUsing.textColor = .red
            scrollView1.alpha = 1
            scrollView2.alpha = 0.5
        case false:
            view.bringSubview(toFront: scrollView2)
            labelUsing.text = "Using scroll view instantiated in code"
            labelUsing.textColor = .green
            scrollView2.alpha = 1
            scrollView1.alpha = 0.5
        }
    }

}
