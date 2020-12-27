import UIKit

class CollectionViewLayout: UICollectionViewLayout {
	private let numberOfColumns = 3
	private var cache: [UICollectionViewLayoutAttributes] = []
	private var contentHeight: CGFloat = 0
	private var contentWidth: CGFloat {
		guard let collectionView = collectionView else {
			return 0
		}
		let insets = collectionView.contentInset
		return collectionView.bounds.width - (insets.left + insets.right)
	}
	override var collectionViewContentSize: CGSize {
		return CGSize(width: contentWidth, height: contentHeight)
	}
	override func prepare() {
		guard let collectionView = collectionView else { return }
		cache.removeAll()

		let columnWidth = contentWidth / CGFloat(numberOfColumns)
		var xOffset: [CGFloat] = []
		for column in 0..<numberOfColumns {
			xOffset.append(CGFloat(column) * columnWidth)
		}
		var column = 0
		var yOffset: [CGFloat] = [CGFloat](repeating: 0, count: numberOfColumns)

		for item in 0..<collectionView.numberOfItems(inSection: 0) {
			let width = (item % 9 == 4 ? 2.0 : 1.0) * columnWidth
			let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: width)

			let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: item, section: 0))
			attributes.frame = frame
			cache.append(attributes)

			contentHeight = max(contentHeight, frame.maxY)
            if (item % 9 == 4) {
                yOffset[column+1] = yOffset[column+1] + width
            }
            yOffset[column] = yOffset[column] + width
            let itemPoModolyu = item % 9
            column = (itemPoModolyu < 2) ? itemPoModolyu + 1 : ((itemPoModolyu == 2 || itemPoModolyu == 4 ||  itemPoModolyu == 5 || itemPoModolyu == 8) ? 0 : ((itemPoModolyu == 3) ? 1 : itemPoModolyu < 8 ? itemPoModolyu - 5 : (itemPoModolyu - 6)))
		}
	}
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var layoutAttributes = [UICollectionViewLayoutAttributes]()

		for attributes in cache {
			if attributes.frame.intersects(rect) {
				layoutAttributes.append(attributes)
			}
		}

		return layoutAttributes
	}
	override func layoutAttributesForItem(at indexPath: IndexPath)
	-> UICollectionViewLayoutAttributes? {
		return cache[indexPath.item]
	}
}
