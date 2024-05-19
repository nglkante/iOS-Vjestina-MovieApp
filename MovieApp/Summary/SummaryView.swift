import UIKit

class SummaryView: UIView {

    let summary: String
    let defaultPadding: CGFloat = 8

    var stackView: UIStackView!
    var summaryLabel: UILabel!

    init(summary: String) {
        self.summary = summary

        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
