//
//  HomeSectionLayaoutManager.swift
//  Jewllery Store Application
//
//  Created by Stefan Dojcinovic on 18.8.21..
//

import UIKit

final class HomeSectionLayoutManager {
    
    static let shared = HomeSectionLayoutManager()
    
    private init() { }
    
    public static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            return aboutUsCellLayoutModel()
        case 1:
            return productsCellLayoutModel()
        case 2:
            return productsCellLayoutModel()
        case 3:
            return productsCellLayoutModel()
        case 4:
            return contactUsCellLayoutSection()
        default:
            return defaultCellLayoutSection()
        }
    }
    
    /// Layout for cells in About us section
    private static func aboutUsCellLayoutModel() -> NSCollectionLayoutSection {
        let item = createLayoutItem(with: .fractionalWidth(1.0), height: .fractionalHeight(1.0))
        
        let group = createHorizontalGroup(with: item,
                                          count: 1,
                                          width: .fractionalWidth(1.0),
                                          height: .absolute(400))
        
        let header = createHeaderForSection(with: .top,
                                            elementKind: UICollectionView.elementKindSectionHeader,
                                            width: .fractionalWidth(1.0),
                                            height: .absolute(60))
        
        let section = createSection(with: group,
                                    header: header,
                                    orthogonalScroll: .none)
        return section
    }

    /// Layout for cells in sections where we need to present products
    private static func productsCellLayoutModel() -> NSCollectionLayoutSection {
        let item = createLayoutItem(with: .fractionalWidth(1.0), height: .fractionalHeight(1.0))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let horizontalGroup = createHorizontalGroup(with: item,
                                                    count: 1,
                                                    width: .fractionalWidth(1.0),
                                                    height: .absolute(300))
        
        let verticalGroup = createVerticalGroup(with: horizontalGroup,
                                                count: 1,
                                                width: .fractionalWidth(0.9),
                                                height: .absolute(300))
        
        let header = createHeaderForSection(with: .top,
                                            elementKind: UICollectionView.elementKindSectionHeader,
                                            width: .fractionalWidth(1.0),
                                            height: .absolute(60))
        
        let section = createSection(with: verticalGroup,
                                    header: header,
                                    orthogonalScroll: .continuous)
        
        return section
    }

    /// Layout for cells in ContactUs section
    private static func contactUsCellLayoutSection() -> NSCollectionLayoutSection {
        let item = createLayoutItem(with: .fractionalWidth(1.0), height: .fractionalHeight(1.0))
        
        let group = createHorizontalGroup(with: item,
                                          count: 1,
                                          width: .fractionalWidth(1.0),
                                          height: .absolute(250))
        
        let header = createHeaderForSection(with: .top,
                                            elementKind: UICollectionView.elementKindSectionHeader,
                                            width: .fractionalWidth(1.0),
                                            height: .absolute(60))
        
        let section = createSection(with: group,
                                    header: header,
                                    orthogonalScroll: .none)
        return section
    }

    /// Default layout for cells if the section index in switch goes out of bounds
    private static func defaultCellLayoutSection() -> NSCollectionLayoutSection {
        let item = createLayoutItem(with: .fractionalWidth(1.0), height: .fractionalHeight(1.0))
        
        let group = createHorizontalGroup(with: item,
                                          count: 1,
                                          width: .fractionalWidth(1.0),
                                          height: .absolute(400))
        
        let header = createHeaderForSection(with: .top,
                                            elementKind: UICollectionView.elementKindSectionHeader,
                                            width: .fractionalWidth(1.0),
                                            height: .absolute(60))
        
        let section = createSection(with: group,
                                    header: header,
                                    orthogonalScroll: .none)
        return section
    }
    
    /// Create an NSCollectionLayoutItem object
    private static func createLayoutItem(
        with width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension) -> NSCollectionLayoutItem {
         return NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: width,
                heightDimension: height))
    }
    
    /// Create a horizontal  NSCollectionLayoutGroup
    private static func createHorizontalGroup(
        with subitem: NSCollectionLayoutItem,
        count: Int,
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension) -> NSCollectionLayoutGroup {
        
        return NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: width,
                heightDimension: height),
            subitem: subitem,
            count: count)
    }
    
    /// Create a vertical  NSCollectionLayoutGroup
    private static func createVerticalGroup(
        with subitem: NSCollectionLayoutItem,
        count: Int,
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension) -> NSCollectionLayoutGroup {
        
        return NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: width,
                heightDimension: height),
            subitem: subitem,
            count: count)
    }
    
    /// Create a NSCollectionLayoutSection with a section header
    private static func createSection(
        with group: NSCollectionLayoutGroup,
        header: [NSCollectionLayoutBoundarySupplementaryItem],
        orthogonalScroll: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = orthogonalScroll
        section.boundarySupplementaryItems = header
        
        return section
    }
    
    /// Create a NSCollectionLayoutBoundarySupplementaryItem section header
    private static func createHeaderForSection(
        with aligment: NSRectAlignment,
        elementKind: String,
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension) -> [NSCollectionLayoutBoundarySupplementaryItem] {
        
        var headers: [NSCollectionLayoutBoundarySupplementaryItem] = []
        headers.append(NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: width,
                            heightDimension: height),
                        elementKind: elementKind,
                        alignment: aligment))
        return headers
    }
    
}
