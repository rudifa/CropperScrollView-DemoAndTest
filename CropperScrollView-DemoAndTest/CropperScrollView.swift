//
//  CropperScrollView.swift
//  CropperScrollView-DemoAndTest
//
//  Created by Rudolf Farkas on 04.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit


class CropperScrollView: UIScrollView {

    var imageView: UIImageView

    override init(frame: CGRect) {
        imageView = UIImageView()
        super.init(frame: frame)
        addSubview(imageView)
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        imageView = UIImageView()
        super.init(coder: aDecoder)
        addSubview(imageView)
        delegate = self
    }

    func loadImage(image: UIImage) {
        imageView.image = image
        imageView.sizeToFit()
        contentSize = imageView.bounds.size
        updateZoomScales()
    }

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
        let minScale = min(scaleWidth, scaleHeight) // leaves bands
        let midScale = max(scaleWidth, scaleHeight) // fills the smaller dimension, overflows the larger one
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
