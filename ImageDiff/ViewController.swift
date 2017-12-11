//
//  ViewController.swift
//  ImageDiff
//
//  Created by Super Hrvoje on 22/10/2017.
//  Copyright © 2017 Hrvoje Baić. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: - Properties -
    
    @IBOutlet weak var upperImageView: NSImageView!
    @IBOutlet weak var lowerImageView: NSImageView!
    @IBOutlet weak var diffButton: NSButton!
    @IBOutlet weak var diffImageView: NSImageView!
    
    var sampleBitmap: NSBitmapImageRep!
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Helpers -
    
    private func pixelize(image: NSImage) -> [Pixel] {
        
        guard let bitmap = image.representations[0] as? NSBitmapImageRep,
              var data = bitmap.bitmapData
              else { return [] }
        
        sampleBitmap = bitmap
        var pixels = [Pixel]()
        let format = bitmap.bitmapFormat
        
        for _ in 0..<bitmap.pixelsHigh {
            for _ in 0..<bitmap.pixelsWide {
                
                let red: UInt8
                let green: UInt8
                let blue: UInt8
                let alpha: UInt8
                
                if format == .alphaFirst {
                    alpha = data.pointee
                    data = data.advanced(by: 1)
                    
                    red = data.pointee
                    data = data.advanced(by: 1)
                    
                    green = data.pointee
                    data = data.advanced(by: 1)
                    
                    blue = data.pointee
                    data = data.advanced(by: 1)
                } else {
                    red = data.pointee
                    data = data.advanced(by: 1)
                    
                    green = data.pointee
                    data = data.advanced(by: 1)
                    
                    blue = data.pointee
                    data = data.advanced(by: 1)
                    
                    alpha = data.pointee
                    data = data.advanced(by: 1)
                }
                
                let pixel = Pixel(red: red, green: green, blue: blue, alpha: alpha)
                pixels.append(pixel)
            }
        }
        
        return pixels
    }
    
    private func diff(firstImage: NSImage, secondImage: NSImage) -> [Pixel] {
        let firstImagePixels = pixelize(image: firstImage)
        let secondImagePixels = pixelize(image: secondImage)
        
        var diffPixelsArray = [Pixel]()
        
        for (firstImagePixel, secondImagePixel) in zip(firstImagePixels, secondImagePixels) {
            
            var pixel: Pixel
            
            if firstImagePixel == secondImagePixel {
                let red = firstImagePixel.red
                let green = firstImagePixel.green
                let blue = firstImagePixel.blue
                let alpha: UInt8 = 128
                
                pixel = Pixel(red: red, green: green, blue: blue, alpha: alpha)
            } else {
                let red: UInt8 = 0
                let green: UInt8 = 0
                let blue: UInt8 = 0
                let alpha: UInt8 = 255
                
                pixel = Pixel(red: red, green: green, blue: blue, alpha: alpha)
            }
            
            diffPixelsArray.append(pixel)
        }
        
        return diffPixelsArray
    }
    
    private func imageFrom(pixels: [Pixel]) -> NSImage? {
        
        var imageBytes = [UInt8]()
        for pixel in pixels {
            imageBytes.append(pixel.red)
            imageBytes.append(pixel.green)
            imageBytes.append(pixel.blue)
            imageBytes.append(pixel.alpha)
        }
        
        var pointer: UnsafeMutablePointer? = UnsafeMutablePointer(mutating: &imageBytes)
        
        if let bitmapRep = NSBitmapImageRep(bitmapDataPlanes: &pointer, pixelsWide: sampleBitmap.pixelsWide, pixelsHigh: sampleBitmap.pixelsHigh, bitsPerSample: sampleBitmap.bitsPerSample, samplesPerPixel: sampleBitmap.samplesPerPixel, hasAlpha: sampleBitmap.hasAlpha, isPlanar: sampleBitmap.isPlanar, colorSpaceName: sampleBitmap.colorSpaceName, bytesPerRow: sampleBitmap.bytesPerRow, bitsPerPixel: sampleBitmap.bitsPerPixel) {
            
            let image = NSImage(size: NSSize(width: sampleBitmap.pixelsWide, height: sampleBitmap.pixelsHigh))
            image.addRepresentation(bitmapRep)
            return image
        }
        
        return nil
    }

    // MARK: - Actions -
    
    @IBAction func didPressDiffButton(_ sender: NSButton) {
        if let upperImage = upperImageView.image, let lowerImage = lowerImageView.image {
            let diffPixels = diff(firstImage: upperImage, secondImage: lowerImage)
            let diffImage = imageFrom(pixels: diffPixels)
            diffImageView.image = diffImage
        }
    }
    
    @IBAction func imageSelected(_ sender: NSImageView) {
        if upperImageView.image != nil && lowerImageView.image != nil {
            diffButton.isEnabled = true
        } else {
            diffButton.isEnabled = false
        }
    }
}
