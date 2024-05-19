import UIKit
import MovieAppData


class CategoriesAndDurationView: UIView {

    let categories: [MovieCategoryModel]
    let duration: Int
    let defaultPadding: CGFloat = 8

    var stackView: UIStackView!
    var categoryLabel: UILabel!
    var durationLabel: UILabel!

    init(categories: [MovieCategoryModel], duration: Int) {
        self.categories = categories
        self.duration = duration

        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
