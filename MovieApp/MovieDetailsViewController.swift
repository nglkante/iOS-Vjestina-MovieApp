//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Antun Blazic on 02.04.2024..
//

import UIKit
import MovieAppData
import PureLayout

class MovieDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let details = MovieUseCase().getDetails(id: 1375666)
        let raiting = details!.rating
        let name = details!.name
        let year = details!.year
        let dateString = details!.releaseDate
        let categories = details!.categories
        let duration = details!.duration
        let crewMembers = details!.crewMembers
        let summary = details!.summary
        let image = details!.imageUrl
        
        buildViews(raiting: raiting, name: name, year: year, dateString: dateString, categories: categories,duration: duration, summary: summary, crewMembers: crewMembers, image: image)
    }
    
    func buildViews(raiting: Double, name:String,year: Int, dateString:String, categories: [MovieCategoryModel], duration: Int, summary: String,crewMembers: [MovieCrewMemberModel], image: String){
        let imageView = UIImageView(image: UIImage(named: "inception"))
        imageView.contentMode = .scaleToFill
        imageView.autoSetDimension(.height, toSize: view.bounds.height*0.4)
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        imageView.autoPinEdge(toSuperviewEdge: .left,withInset: 0)
        imageView.autoPinEdge(toSuperviewEdge: .right,withInset: 0)
        imageView.autoPinEdge(toSuperviewEdge: .top,withInset: 0)
        
        let labelRaiting = UILabel()
        labelRaiting.text = String(raiting)
        labelRaiting.textAlignment = .center
        labelRaiting.textColor = .white
        labelRaiting.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(labelRaiting)
        labelRaiting.autoSetDimension(.width, toSize: 25)
        labelRaiting.autoSetDimension(.height, toSize: 19)
        labelRaiting.autoPinEdge(toSuperviewEdge: .top,withInset: 134)
        labelRaiting.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
        
        let labelUserScore = UILabel()
        labelUserScore.text = "User score"
        labelUserScore.textAlignment = .center
        labelUserScore.textColor = .white
        labelUserScore.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelUserScore)
        labelUserScore.autoSetDimension(.width, toSize: 100)
        labelUserScore.autoSetDimension(.height, toSize: 17)
        labelUserScore.autoPinEdge(.left, to: .right, of: labelRaiting, withOffset: 8)
        labelUserScore.autoPinEdge(toSuperviewEdge: .top,withInset: 135)
        
        let labelName = UILabel()
        labelName.text = name
        labelName.textAlignment = .center
        labelName.textColor = .white
        labelName.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(labelName)
        labelName.autoPinEdge(.top, to: .bottom, of: labelUserScore, withOffset: 16)
        labelName.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
        
        let labelYear = UILabel()
        labelYear.text = " (" + String(year) + ")"
        labelYear.textAlignment = .center
        labelYear.textColor = .white
        labelYear.font = .systemFont(ofSize: 24)
        view.addSubview(labelYear)
        labelYear.autoPinEdge(.left, to: .right, of: labelName, withOffset: 0)
        labelYear.autoPinEdge(.top, to: .bottom, of: labelUserScore, withOffset: 16)
        
        let labelDate = UILabel()
        labelDate.text = formatDateString(from: dateString)
        labelDate.textAlignment = .center
        labelDate.textColor = .white
        labelDate.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelDate)
        labelDate.autoPinEdge(.top, to: .bottom, of: labelName, withOffset: 16)
        labelDate.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
        
        let categoryStrings = categories.map { categoryToString($0) }
        let joinedCategories = categoryStrings.joined(separator: ", ")
        let labelCategory = UILabel()
        labelCategory.text = joinedCategories
        labelCategory.textAlignment = .center
        labelCategory.textColor = .white
        labelCategory.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelCategory)
        labelCategory.autoPinEdge(.top, to: .bottom, of: labelDate, withOffset: 0)
        labelCategory.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
        
        let durationString = formatDuration(minutes: duration)
        let labelDuration = UILabel()
        labelDuration.text = durationString
        labelDuration.textAlignment = .left
        labelDuration.textColor = .white
        labelDuration.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelDuration)
        labelDuration.autoPinEdge(.left, to: .right, of: labelCategory, withOffset: 8)
        labelDuration.autoPinEdge(.top, to: .bottom, of: labelDate, withOffset: 0)
        
        let darkBlue = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
        let labelOverview = UILabel()
        labelOverview.text = "Overview"
        labelOverview.textAlignment = .center
        labelOverview.textColor = darkBlue
        labelOverview.font = UIFont(name: "ProximaNova", size: 20)
        view.addSubview(labelOverview)
        labelOverview.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 22)
        labelOverview.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
        
        let labelSummary = UILabel()
        labelSummary.text = summary
        labelSummary.textAlignment = .left
        labelSummary.textColor = .black
        labelSummary.numberOfLines = 0
        labelSummary.font = UIFont(name: "ProximaNova", size: 14)
        view.addSubview(labelSummary)
        labelSummary.autoPinEdge(.top, to: .bottom, of: labelOverview, withOffset: 8.38)
        labelSummary.autoPinEdge(toSuperviewEdge: .left,withInset: 16)
        labelSummary.autoPinEdge(toSuperviewEdge: .right,withInset: 16)
        
        var crewMemberLabels: [UILabel] = []
        var accumulatedWidth: CGFloat = 0
        for (index, crewMember) in crewMembers.enumerated() {
            let labelCrewMember = UILabel()
            labelCrewMember.textAlignment = .center
            labelCrewMember.textColor = .black
            labelCrewMember.numberOfLines = 2
            labelCrewMember.font = UIFont.boldSystemFont(ofSize: 14)
            labelCrewMember.text = "\(crewMember.name) \n \(crewMember.role)"
            view.addSubview(labelCrewMember)
            
            // Calculate the vertical position of the label
            
            if index == 0 {
                    // Position the first label below labelSummary
                    labelCrewMember.autoPinEdge(.top, to: .bottom, of: labelSummary, withOffset: 20)
                    labelCrewMember.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
            } else {
                // Calculate the accumulated width of previous labels
                    accumulatedWidth += crewMemberLabels[index-1].intrinsicContentSize.width
                // Calculate the remaining width
                var remainingWidth = view.bounds.width - accumulatedWidth - 16 // Assuming 16 is the horizontal spacing
                if remainingWidth >= crewMemberLabels[index-1].intrinsicContentSize.width{
                    // Enough space to position to the right
                    labelCrewMember.autoAlignAxis(.horizontal, toSameAxisOf: crewMemberLabels[index - 1])
                    labelCrewMember.autoPinEdge(.leading, to: .trailing, of: crewMemberLabels[index - 1], withOffset: 16) // Assuming 16 is the horizontal spacing
                } else {
                    // Place the label below the previous label
                    labelCrewMember.autoPinEdge(.top, to: .bottom, of: crewMemberLabels[index - 1], withOffset: 20) // Assuming 20 is the vertical spacing
                    labelCrewMember.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
                    remainingWidth = view.bounds.width
                    accumulatedWidth = 0
                    
                }
            }
            // Keep track of created labels for positioning
            crewMemberLabels.append(labelCrewMember)
        }
        //        var crewRoleLabels: [UILabel] = []
        //        for (index, crewMember) in crewMembers.enumerated() {
        //            let labelCrewRole = UILabel()
        //            labelCrewRole.textAlignment = .center
        //            labelCrewRole.textColor = .black
        //            labelCrewRole.font = UIFont.systemFont(ofSize: 14)
        //            labelCrewRole.text = "\(crewMember.role))"
        //            view.addSubview(labelCrewRole)
        //
        //            // Calculate the vertical position of the label
        //            let yOffset = CGFloat(index) * 30
        //            if index == 0 {
        //                labelCrewRole.autoPinEdge(.top, to: .bottom, of: labelUserScore, withOffset: 16 + yOffset)
        //            } else {
        //                labelCrewRole.autoPinEdge(.top, to: .bottom, of: crewMemberLabels[index - 1], withOffset: 30)
        //            }
        //
        //            labelCrewRole.autoPinEdge(.left, to: .right, of: labelName, withOffset: 0)
        //
        //            // Keep track of created labels for positioning
        //            crewRoleLabels.append(labelCrewRole)
        //        }
    }
    
    func formatDateString(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date!)
    }
    
    func formatDuration(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        var durationString = ""
        if hours > 0 {
            durationString += "\(hours)h"
        }
        if remainingMinutes > 0 {
            if !durationString.isEmpty {
                durationString += " "
            }
            durationString += "\(remainingMinutes)m"
        }
        return durationString
    }
    
    func categoryToString(_ category: MovieCategoryModel) -> String {
        switch category {
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .comedy: return "Comedy"
        case .crime: return "Crime"
        case .drama: return "Drama"
        case .fantasy: return "Fantasy"
        case .romance: return "Romance"
        case .scienceFiction: return "Science Fiction"
        case .thriller: return "Thriller"
        case .western: return "Western"
        }
    }
}

