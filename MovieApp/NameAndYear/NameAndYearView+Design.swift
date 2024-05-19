import UIKit
import PureLayout

extension NameAndYearView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        nameLabel = UILabel()
        stackView.addArrangedSubview(nameLabel)

        yearLabel = UILabel()
        stackView.addArrangedSubview(yearLabel)
    }

    private func styleViews() {
        backgroundColor = .clear

        stackView.axis = .horizontal
        stackView.spacing = defaultPadding
        stackView.distribution = .fillProportionally
        
        nameLabel.text = name
        nameLabel.font = UIFont(name: "ProximaNova", size: 24)?.boldFont()
        
        yearLabel.text = String("(" + String(year) + ")")
        yearLabel.font = UIFont(name: "ProximaNova", size: 24)
    }

    private func defineLayoutForViews() {
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: 300)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
//        stackView.autoPinEdge(toSuperviewEdge: .trailing)
//        stackView.autoPinEdge(toSuperviewEdge: .bottom)
    }

}

