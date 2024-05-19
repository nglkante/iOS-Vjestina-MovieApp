import UIKit
import PureLayout

extension CategoriesAndDurationView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        categoryLabel = UILabel()
        stackView.addArrangedSubview(categoryLabel)

        durationLabel = UILabel()
        stackView.addArrangedSubview(durationLabel)
    }

    private func styleViews() {
        backgroundColor = .clear

        stackView.axis = .horizontal
        stackView.spacing = defaultPadding
        stackView.distribution = .fillProportionally

        let categoryStrings = categories.map{$0.toString()}
        let joinedCategories = categoryStrings.joined(separator: ", ")
        categoryLabel.font = UIFont(name: "ProximaNova", size: 14)
        categoryLabel.text = joinedCategories
        
        durationLabel.font = UIFont(name: "ProximaNova", size: 14)?.boldFont()
        durationLabel.text = duration.formatDuration()
    }

    private func defineLayoutForViews() {
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: 700)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
//        stackView.autoPinEdge(toSuperviewEdge: .trailing)
//        stackView.autoPinEdge(toSuperviewEdge: .bottom)
    }

}
