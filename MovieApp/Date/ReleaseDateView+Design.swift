import UIKit
import PureLayout

extension ReleaseDateView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        releaseDateLabel = UILabel()
        stackView.addArrangedSubview(releaseDateLabel)
    }

    private func styleViews() {
        backgroundColor = .clear

        stackView.axis = .horizontal
        stackView.spacing = defaultPadding
        stackView.distribution = .fillProportionally

        releaseDateLabel.font = UIFont(name: "ProximaNova", size: 14)
        releaseDateLabel.text = releaseDate.formatDateString()
    }

    private func defineLayoutForViews() {
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: 444)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
//        stackView.autoPinEdge(toSuperviewEdge: .trailing)
//        stackView.autoPinEdge(toSuperviewEdge: .bottom)
    }

}
