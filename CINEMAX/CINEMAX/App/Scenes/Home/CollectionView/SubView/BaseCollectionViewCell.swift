//
//  BaseCollectionViewCell.swift
//  CINEMAX
//
//  Created by Dalia Hamada on 14/12/2024.
//
import Foundation
import UIKit
import SwiftUI

class BaseCollectionViewCell: UICollectionViewCell {
    
    private var hostingController: UIHostingController<MovieItemView>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
    
    func configure(with movie: Movie) {
        if hostingController == nil {
            hostingController = createHostingController(for: movie)
            addHostingControllerView()
        } else {
            hostingController?.rootView = MovieItemView(movie: movie)
        }
    }
    
    private func createHostingController(for movie: Movie) -> UIHostingController<MovieItemView> {
        return UIHostingController(rootView: MovieItemView(movie: movie))
    }
    
    private func addHostingControllerView() {
        guard let hostingView = hostingController?.view else { return }
        
        hostingView.frame = contentView.bounds
        hostingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(hostingView)
    }
}
