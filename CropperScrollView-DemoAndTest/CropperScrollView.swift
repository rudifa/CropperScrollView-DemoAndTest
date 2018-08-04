//
//  CropperScrollView.swift
//  CropperScrollView-DemoAndTest
//
//  Created by Rudolf Farkas on 04.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit


/**
 Creates a scrollable and zoomable view of an image.

 An instance can be created from a storyboard or in the owner's code.

 Owner calls `csv.loadImage(image)` to load and display the image.

 Owner calls `getCroppedImage()` to retrieve the cropped image.

 Example:
 ```
 class ViewController: UIViewController {

     @IBOutlet weak var scrollView1: CropperScrollView!

     var scrollView2 = CropperScrollView()

     @IBAction func cropButton(_ sender: UIButton) {
         let croppedImage = scrollView1.getCroppedImage() // or scrollView2
         print("getCroppedImage", cropped.size as Any)
        // do something with croppedImage
     }

     override func viewDidLoad() {
         super.viewDidLoad()

         scrollView2.frame = scrollView1.frame // as defined in storyboard
         scrollView2.frame.origin.y += scrollView1.frame.size.height // displace vertically
         view.addSubview(scrollView2)

         let image = UIImage(named: "myimage.jpg")
         scrollView1.loadImage(image!)
         scrollView2.loadImage(image!)
     }
 }
  ```
 */

 class CropperScrollView: UIScrollView {

    lazy var imageView = UIImageView()

    // Called on instantiation from the owning object's code.
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
    }

    // Called on instantiation from a storyboard.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selfInit()
    }

    private func selfInit() {
        addSubview(imageView)
        delegate = self
    }

    /// Input to the cropper
    ///
    /// - Parameter image: to display, zoom, scroll and crop
    func loadImage(_ image: UIImage) {
        imageView.image = image
        imageView.sizeToFit()
        contentSize = imageView.bounds.size
        updateZoomScales()
    }

    /// Output from the cropper
    ///
    /// - Returns: cropped image
    func getCroppedImage() -> UIImage {

        let croppedSize = bounds.size / zoomScale
        let croppedOrigin = contentOffset / zoomScale * -1.0

        UIGraphicsBeginImageContextWithOptions(croppedSize, true, 0.0)

        print("---croppedImage", "scrollViewSize=", bounds.size, "croppedSize=", croppedSize)

        imageView.image?.draw(at: croppedOrigin)
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();

        return croppedImage!
    }

    private func updateZoomScales() {
        let scaleWidth = frame.size.width / contentSize.width
        let scaleHeight = frame.size.height / contentSize.height
        let minScale = min(scaleWidth, scaleHeight) // image fills the larger dimension
        let midScale = max(scaleWidth, scaleHeight) // image fills the smaller dimension, overflows the larger one
        minimumZoomScale = minScale / 2
        maximumZoomScale = 2
        zoomScale = midScale
    }

}

extension CropperScrollView: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //print("viewForZooming")
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //print("scrollViewDidZoom")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrollViewDidScroll")
    }

}
