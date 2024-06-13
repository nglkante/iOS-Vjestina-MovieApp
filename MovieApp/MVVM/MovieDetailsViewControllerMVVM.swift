import UIKit
import PureLayout
import Kingfisher

class MovieDetailsViewControllerMVVM: UIViewController {
    let viewModel: MovieDetailsViewModel
    var crewMemberLabels: [UILabel] = []

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        buildViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crewMemberLabels.forEach { $0.alpha = 0 }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        crewMemberLabels.forEach { fadeInView(view: $0, duration: 0.3) }
    }

    private func setupView() {
        view.backgroundColor = .white
        title = "Movie details"
    }

    private func buildViews() {
        let imageView = UIImageView()
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: viewModel.imageUrl))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoSetDimension(.height, toSize: view.bounds.height * 0.4)
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        imageView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        imageView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)

        let darkBlue = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
        let labelOverview = UILabel()
        labelOverview.text = "Overview"
        labelOverview.textAlignment = .center
        labelOverview.textColor = darkBlue
        labelOverview.font = UIFont(name: "ProximaNova", size: 20)
        view.addSubview(labelOverview)
        labelOverview.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 22)
        labelOverview.autoPinEdge(toSuperviewEdge: .left, withInset: 20)

        let joinedCategories = viewModel.categories.joined(separator: ", ")
        let labelCategory = UILabel()
        labelCategory.text = joinedCategories
        labelCategory.textAlignment = .center
        labelCategory.textColor = .white
        labelCategory.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelCategory)
        labelCategory.autoPinEdge(.bottom, to: .top, of: labelOverview, withOffset: -90)
        labelCategory.autoPinEdge(toSuperviewEdge: .left, withInset: 20)

        let labelDuration = UILabel()
        labelDuration.text = viewModel.duration
        labelDuration.textAlignment = .left
        labelDuration.textColor = .white
        labelDuration.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelDuration)
        labelDuration.autoPinEdge(.left, to: .right, of: labelCategory, withOffset: 8)
        labelDuration.autoPinEdge(.bottom, to: .top, of: labelOverview, withOffset: -90)

        let labelDate = UILabel()
        labelDate.text = viewModel.releaseDate
        labelDate.textAlignment = .center
        labelDate.textColor = .white
        labelDate.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelDate)
        labelDate.autoPinEdge(.bottom, to: .top, of: labelCategory, withOffset: 0)
        labelDate.autoPinEdge(toSuperviewEdge: .left, withInset: 20)

        let labelName = UILabel()
        labelName.text = viewModel.name
        labelName.textAlignment = .center
        labelName.textColor = .white
        labelName.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(labelName)
        labelName.autoPinEdge(.bottom, to: .top, of: labelDate, withOffset: -16)
        labelName.autoPinEdge(toSuperviewEdge: .left, withInset: 20)

        let labelYear = UILabel()
        labelYear.text = "(\(viewModel.year))"
        labelYear.textAlignment = .center
        labelYear.textColor = .white
        labelYear.font = .systemFont(ofSize: 24)
        view.addSubview(labelYear)
        labelYear.autoPinEdge(.bottom, to: .top, of: labelDate, withOffset: -16)
        labelYear.autoPinEdge(.left, to: .right, of: labelName, withOffset: 8)

        let labelRating = UILabel()
        labelRating.text = viewModel.rating
        labelRating.textAlignment = .center
        labelRating.textColor = .white
        labelRating.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(labelRating)
        labelRating.autoPinEdge(.bottom, to: .top, of: labelName, withOffset: -16)
        labelRating.autoPinEdge(toSuperviewEdge: .left, withInset: 20)

        let labelUserScore = UILabel()
        labelUserScore.text = "User score"
        labelUserScore.textColor = .white
        labelUserScore.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelUserScore)
        labelUserScore.autoPinEdge(.bottom, to: .top, of: labelName, withOffset: -16)
        labelUserScore.autoPinEdge(.left, to: .right, of: labelRating, withOffset: 8)

        let labelSummary = UILabel()
        labelSummary.text = viewModel.summary
        labelSummary.textAlignment = .left
        labelSummary.textColor = .black
        labelSummary.numberOfLines = 0
        labelSummary.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelSummary)
        labelSummary.autoPinEdge(.top, to: .bottom, of: labelOverview, withOffset: 8.38)
        labelSummary.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        labelSummary.autoPinEdge(toSuperviewEdge: .right, withInset: 16)

        for (index, crewMember) in viewModel.crewMembers.enumerated() {
            let labelCrewMember = UILabel()
            labelCrewMember.textAlignment = .center
            labelCrewMember.textColor = .black
            labelCrewMember.numberOfLines = 2
            labelCrewMember.font = UIFont.boldSystemFont(ofSize: 14)
            labelCrewMember.text = "\(crewMember.name) \n \(crewMember.role)"
            view.addSubview(labelCrewMember)
            
            if index == 0 {
                labelCrewMember.autoPinEdge(.top, to: .bottom, of: labelSummary, withOffset: 20)
                labelCrewMember.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
            } else {
                if index % 2 == 1 {
                    labelCrewMember.autoAlignAxis(.horizontal, toSameAxisOf: crewMemberLabels[index - 1])
                    labelCrewMember.autoPinEdge(.leading, to: .trailing, of: crewMemberLabels[index - 1], withOffset: 16)
                } else {
                    labelCrewMember.autoPinEdge(.top, to: .bottom, of: crewMemberLabels[index - 1], withOffset: 20)
                    labelCrewMember.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
                }
            }
            crewMemberLabels.append(labelCrewMember)
        }

        animateTextChange(label: labelOverview, newText: "Overview")
        animateTextChange(label: labelCategory, newText: joinedCategories)
        animateTextChange(label: labelDuration, newText: viewModel.duration)
        animateTextChange(label: labelDate, newText: viewModel.releaseDate)
        animateTextChange(label: labelName, newText: viewModel.name)
        animateTextChange(label: labelYear, newText: "(\(viewModel.year))")
        animateTextChange(label: labelRating, newText: viewModel.rating)
        animateTextChange(label: labelUserScore, newText: "User score")
        animateTextChange(label: labelSummary, newText: viewModel.summary)
               
        for label in crewMemberLabels {
            fadeInView(view: label, duration: 0.3)
        }
    }

    func animateTextChange(label: UILabel, newText: String) {
        UIView.transition(with: label, duration: 0.2, options: .transitionCrossDissolve, animations: {
            label.text = newText
            label.textAlignment = .left
        }, completion: nil)
    }

    func fadeInView(view: UIView, duration: TimeInterval = 0.3) {
        view.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 1
        })
    }
}
