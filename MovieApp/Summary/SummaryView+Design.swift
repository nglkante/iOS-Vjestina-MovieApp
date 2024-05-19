import UIKit
import PureLayout

extension SummaryView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        summaryLabel = UILabel()
        stackView.addArrangedSubview(summaryLabel)
    }

    private func styleViews() {
        backgroundColor = .clear

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = defaultPadding
        
        summaryLabel.numberOfLines = 0
        summaryLabel.text = summary
        summaryLabel.font = UIFont(name: "ProximaNova", size: 14)
    }

    private func defineLayoutForViews() {
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: 200)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 200)
    }

}
