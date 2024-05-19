import UIKit

class RatingView: UIView {

    let rating: Double
    let defaultPadding: CGFloat = 8

    var stackView: UIStackView!
    var ratingLabel: UILabel!
    var userScoreLabel: UILabel!

    init(rating: Double) {
        self.rating = rating

        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
