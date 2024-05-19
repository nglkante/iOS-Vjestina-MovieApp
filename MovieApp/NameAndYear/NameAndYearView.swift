import UIKit

class NameAndYearView: UIView {

    let name: String
    let year: Int
    let defaultPadding: CGFloat = 8

    var stackView: UIStackView!
    var nameLabel: UILabel!
    var yearLabel: UILabel!

    init(name: String, year: Int) {
        self.name = name
        self.year = year

        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
