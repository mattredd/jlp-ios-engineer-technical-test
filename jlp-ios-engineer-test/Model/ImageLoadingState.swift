//
//  ImageLoadingState.swift
//  jlp-ios-engineer-test
//
//  Created by Matthew Reddin on 27/05/2022.
//

import UIKit

enum ImageLoadingState {
    case uninitialised, error, loading
    case loaded(img: UIImage)
}
