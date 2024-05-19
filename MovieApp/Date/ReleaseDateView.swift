import UIKit

class ReleaseDateView: UIView {

    let releaseDate: String
    let defaultPadding: CGFloat = 8

    var stackView: UIStackView!
    var releaseDateLabel: UILabel!

    init(releaseDate: String) {
        self.releaseDate = releaseDate

        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
