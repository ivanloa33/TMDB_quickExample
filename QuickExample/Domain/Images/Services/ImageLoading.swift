//
//  ImageLoading.swift
//  QuickExample
//
//  Created by Ivan Lopez on 17/04/26.
//

import UIKit.UIImage

protocol ImageLoading {
    func loadImage(from posterPath: String) async throws -> UIImage
}
