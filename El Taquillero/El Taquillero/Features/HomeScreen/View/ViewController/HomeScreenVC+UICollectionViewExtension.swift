//
//  HomeScreenVC+UICollectionViewExtension.swift
//  El Taquillero
//
//  Created by Andrés Fonseca on 06/11/2024.
//

import UIKit

extension HomeScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.titles.count
        case 1:
            return self.titles.count - 15
        default:
            return self.titles.count - 15
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let context = self.titles[indexPath.row]
        switch section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePosterCell.reuseIdentifier, for: indexPath) as? HomePosterCell {
                cell.setupCell(with: context)
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTitleCell.reuseIdentifier, for: indexPath) as? HomeTitleCell {
                cell.setupCell(with: context)
                return cell
            }
        default:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTitleCell.reuseIdentifier, for: indexPath) as? HomeTitleCell {
                cell.setupCell(with: context)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? HeaderView {
                switch indexPath.section {
                case 0:
                    headerView.label.text = ""
                case 1:
                    let navTitle = String(localized: "HOME_TOP_MOVIES_CAPTION")
                    headerView.label.text = navTitle
                    headerView.navTitle = navTitle
                case 2:
                    let navTitle = String(localized: "HOME_TOP_SERIES_CAPTION")
                    headerView.label.text = navTitle
                    headerView.navTitle = navTitle
                default:
                    break
                }
                return headerView
            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            
            let pagesInBanner = self.titles.count
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as? PageControlFooterView {
                footerView.pagesInBanner = pagesInBanner
                return footerView
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        
        if let footerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: 0)) as? PageControlFooterView {
            footerView.updateCurrentPage(to: indexPath.item)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let navigationBarAlpha = min(1, offsetY / 100)
        simulatedNavBarView.alpha = navigationBarAlpha
    }
}

