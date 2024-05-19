//import UIKit
//import MovieAppData
//import PureLayout
//import Kingfisher
//
//class MovieDetailsViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        if let details = MovieUseCase().getDetails(id: 1375666){
//            let rating = details.rating
//            let name = details.name
//            let year = details.year
//            let releaseDate = details.releaseDate
//            let categories = details.categories
//            let duration = details.duration
//            let crewMembers = details.crewMembers
//            let summary = details.summary
//            let imageUrl = details.imageUrl
//            buildViews(rating: rating, name: name, year: year, releaseDate: releaseDate, categories: categories,duration: duration, summary: summary, crewMembers: crewMembers, image: imageUrl)
//        } else {
//            print("There is no movie with this ID.")
//        }
//        
//    }
//    
//    func buildViews(rating: Double, name: String,year: Int, releaseDate: String, categories: [MovieCategoryModel], duration: Int, summary: String, crewMembers: [MovieCrewMemberModel], image: String){
//        let imageView = UIImageView()
//        imageView.kf.indicatorType = .activity
//        imageView.kf.setImage(with: URL(string: image))
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.autoSetDimension(.height, toSize: view.bounds.height*0.4)
//        view.addSubview(imageView)
//        view.sendSubviewToBack(imageView)
//        imageView.autoPinEdge(toSuperviewEdge: .left,withInset: 0)
//        imageView.autoPinEdge(toSuperviewEdge: .right,withInset: 0)
//        imageView.autoPinEdge(toSuperviewEdge: .top,withInset: 0)
//
//        let darkBlue = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
//        let labelOverview = UILabel()
//        labelOverview.text = "Overview"
//        labelOverview.textAlignment = .center
//        labelOverview.textColor = darkBlue
//        labelOverview.font = UIFont(name: "ProximaNova", size: 20)
//        view.addSubview(labelOverview)
//        labelOverview.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 22)
//        labelOverview.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
//        
//        let categoryStrings = categories.map { categoryToString($0) }
//        let joinedCategories = categoryStrings.joined(separator: ", ")
//        let labelCategory = UILabel()
//        labelCategory.text = joinedCategories
//        labelCategory.textAlignment = .center
//        labelCategory.textColor = .white
//        labelCategory.font = UIFont(name: "ProximaNova", size: 14)
//        view.addSubview(labelCategory)
//        labelCategory.autoPinEdge(.bottom, to: .top, of: labelOverview, withOffset: -90)
//        labelCategory.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
//        
//        let durationString = formatDuration(minutes: duration)
//        let labelDuration = UILabel()
//        labelDuration.text = durationString
//        labelDuration.textAlignment = .left
//        labelDuration.textColor = .white
//        labelDuration.font = UIFont(name: "ProximaNova", size: 14)
//        view.addSubview(labelDuration)
//        labelDuration.autoPinEdge(.left, to: .right, of: labelCategory, withOffset: 8)
//        labelDuration.autoPinEdge(.bottom, to: .top, of: labelOverview, withOffset: -90)
//        
//        let labelDate = UILabel()
//        labelDate.text = formatDateString(from: releaseDate)
//        labelDate.textAlignment = .center
//        labelDate.textColor = .white
//        labelDate.font = UIFont(name: "ProximaNova", size: 14)
//        view.addSubview(labelDate)
//        labelDate.autoPinEdge(.bottom, to: .top, of: labelCategory, withOffset: 0)
//        labelDate.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
//        
//        let labelName = UILabel()
//        labelName.text = name
//        labelName.textAlignment = .center
//        labelName.textColor = .white
//        labelName.font = UIFont.boldSystemFont(ofSize: 24)
//        view.addSubview(labelName)
//        labelName.autoPinEdge(.bottom, to: .top, of: labelDate, withOffset: -16)
//        labelName.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
//        
//        let labelYear = UILabel()
//        labelYear.text = "(" + String(year) + ")"
//        labelYear.textAlignment = .center
//        labelYear.textColor = .white
//        labelYear.font = .systemFont(ofSize: 24)
//        view.addSubview(labelYear)
//        labelYear.autoPinEdge(.bottom, to: .top, of: labelDate, withOffset: -16)
//        labelYear.autoPinEdge(.left, to: .right, of: labelName, withOffset: 8)
//        
//        let labelRating = UILabel()
//        labelRating.text = String(rating)
//        labelRating.textAlignment = .center
//        labelRating.textColor = .white
//        labelRating.font = UIFont.boldSystemFont(ofSize: 16)
//        view.addSubview(labelRating)
//        labelRating.autoPinEdge(.bottom, to: .top, of: labelName, withOffset: -16)
//        labelRating.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
//        
//        let labelUserScore = UILabel()
//        labelUserScore.text = "User score"
//        labelUserScore.textColor = .white
//        labelUserScore.font = UIFont(name: "ProximaNova", size: 14)
//        view.addSubview(labelUserScore)
//        labelUserScore.autoPinEdge(.bottom, to: .top, of: labelName, withOffset: -16)
//        labelUserScore.autoPinEdge(.left, to: .right, of: labelRating, withOffset: 8)
//        
//        let labelSummary = UILabel()
//        labelSummary.text = summary
//        labelSummary.textAlignment = .left
//        labelSummary.textColor = .black
//        labelSummary.numberOfLines = 0
//        labelSummary.font = UIFont(name: "ProximaNova", size: 14)
//        view.addSubview(labelSummary)
//        labelSummary.autoPinEdge(.top, to: .bottom, of: labelOverview, withOffset: 8.38)
//        labelSummary.autoPinEdge(toSuperviewEdge: .left,withInset: 16)
//        labelSummary.autoPinEdge(toSuperviewEdge: .right,withInset: 16)
//
//        var crewMemberLabels: [UILabel] = []
//        for (index, crewMember) in crewMembers.enumerated() {
//            let labelCrewMember = UILabel()
//            labelCrewMember.textAlignment = .center
//            labelCrewMember.textColor = .black
//            labelCrewMember.numberOfLines = 2
//            labelCrewMember.font = UIFont.boldSystemFont(ofSize: 14)
//            labelCrewMember.text = "\(crewMember.name) \n \(crewMember.role)"
//            view.addSubview(labelCrewMember)
//            
//            if index ==  0 {
//                labelCrewMember.autoPinEdge(.top, to: .bottom, of: labelSummary, withOffset: 20)
//                labelCrewMember.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
//            } else {
//                if index%2 == 1{
//                    labelCrewMember.autoAlignAxis(.horizontal, toSameAxisOf: crewMemberLabels[index - 1])
//                    labelCrewMember.autoPinEdge(.leading, to: .trailing, of: crewMemberLabels[index - 1], withOffset: 16) // Assuming 16 is the horizontal spacing
//                } else {
//                    labelCrewMember.autoPinEdge(.top, to: .bottom, of: crewMemberLabels[index - 1], withOffset: 20) // Assuming 20 is the vertical spacing
//                    labelCrewMember.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
//                    
//                }
//            }
//            crewMemberLabels.append(labelCrewMember)
//        }
//    }
//    
//    func formatDateString(from dateString: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let date = dateFormatter.date(from: dateString)
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        return dateFormatter.string(from: date!)
//    }
//    
//    func formatDuration(minutes: Int) -> String {
//        let hours = minutes / 60
//        let remainingMinutes = minutes % 60
//        
//        var durationString = ""
//        if hours > 0 {
//            durationString += "\(hours)h"
//        }
//        if remainingMinutes > 0 {
//            if !durationString.isEmpty {
//                durationString += " "
//            }
//            durationString += "\(remainingMinutes)m"
//        }
//        return durationString
//    }
//    
//    func categoryToString(_ category: MovieCategoryModel) -> String {
//        switch category {
//        case .action: return "Action"
//        case .adventure: return "Adventure"
//        case .comedy: return "Comedy"
//        case .crime: return "Crime"
//        case .drama: return "Drama"
//        case .fantasy: return "Fantasy"
//        case .romance: return "Romance"
//        case .scienceFiction: return "Science Fiction"
//        case .thriller: return "Thriller"
//        case .western: return "Western"
//        }
//    }
//}
