//
//  ImageViewExtension.swift
//  Personal
//
//  Created by 으정이 on 2021/09/20.
//

import UIKit
import AlamofireImage
import Foundation

@IBDesignable
public class RoundedBorderView: UIView {
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
}

private struct ImageSupport {
    static let backingBundle = Bundle(for: RoundedBorderView.self)
    static let noImage: UIImage = UIImage(named: "Unknown", in: backingBundle, compatibleWith: nil)!
}

extension UIImageView {
    func loadImageWithURL(_ url: URL?,
                          cacheKey: String? = nil,
                          filter: ImageFilter? = nil) {
        guard let _url = url else {
            self.image = UIImage.getPlaceholder(size: self.bounds.size)
            return
        }
        
        self.af.setImage(withURL: _url, cacheKey: cacheKey, placeholderImage: UIImage.getPlaceholder(size: self.bounds.size), serializer: nil, filter: filter, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: false, completion: nil)
    }
    
    func loadImageWithURLString(_ urlString: String, cacheKey: String? = nil, filter: ImageFilter? = nil) {
        
        guard let url = URL(string: urlString) else {
            self.image = UIImage.getPlaceholder(size: self.bounds.size)
            return
        }
        
        self.loadImageWithURL(url, cacheKey: cacheKey, filter: filter)
        
    }
}

extension UIImage {
    static func getPlaceholder(size: CGSize) -> UIImage {
        //사이즈별로 다른 place holder를 분기할 수 있다.
        return ImageSupport.noImage
    }
}
