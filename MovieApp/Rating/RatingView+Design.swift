import UIKit
import PureLayout

extension RatingView {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        stackView = UIStackView()
        addSubview(stackView)

        ratingLabel = UILabel()
        stackView.addArrangedSubview(ratingLabel)

        userScoreLabel = UILabel()
        stackView.addArrangedSubview(userScoreLabel)
    }

    private func styleViews() {
        backgroundColor = .clear

        stackView.axis = .horizontal
        stackView.spacing = defaultPadding
        stackView.distribution = .fillProportionally

        ratingLabel.text = String(rating)
        ratingLabel.font = UIFont(name: "ProximaNova", size: 16)?.boldFont()
        
        userScoreLabel.text = String("User score")
        userScoreLabel.font = UIFont(name: "ProximaNova", size: 14)
        
    }

    private func defineLayoutForViews() {
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: 134)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
//        stackView.autoPinEdge(toSuperviewEdge: .trailing)
//        stackView.autoPinEdge(toSuperviewEdge: .bottom)
    }

}
