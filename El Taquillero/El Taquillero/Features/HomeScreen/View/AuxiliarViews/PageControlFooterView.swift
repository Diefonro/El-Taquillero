//
//  PageControlFooterView.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 07/11/2024.
//

import UIKit

class PageControlFooterView:  UICollectionReusableView {
    
    var pagesInBanner = 0 {
        didSet {
            pageControl.numberOfPages = pagesInBanner
        }
    }
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .etLightGrayGreen
        pageControl.currentPageIndicatorTintColor = .etTeal
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70)
        ])
    }
    
    func updateCurrentPage(to index: Int) {
        pageControl.currentPage = index
        print("Current page: \(index + 1)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


