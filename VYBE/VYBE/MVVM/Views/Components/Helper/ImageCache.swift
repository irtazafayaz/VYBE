//
//  ImageCache.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 27/07/2024.
//

import Foundation
import SwiftUI
import Combine

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {} // Private singleton
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let key = url.absoluteString
        
        // Check for a cached image.
        if let cachedImage = getImage(forKey: key) {
            completion(cachedImage)
            return
        }
        
        // If not cached, download it.
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.setImage(image, forKey: key)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}

struct CachedAsyncImageView: View {
    let url: URL
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
                    .foregroundStyle(.white)
                    .tint(.white)
                    .onAppear {
                        ImageCache.shared.loadImage(url: url) { fetchedImage in
                            self.image = fetchedImage
                        }
                    }
            }
        }
    }
}
