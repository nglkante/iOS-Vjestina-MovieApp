import Foundation
import Combine
import MovieAppData

class MovieDetailsViewModel {
    private let dataSource: MovieDataSource
    private(set) var movieDetails: MovieDetailsModel?
    
    @Published var rating: String = ""
    @Published var name: String = ""
    @Published var year: String = ""
    @Published var releaseDate: String = ""
    @Published var categories: [String] = []
    @Published var duration: String = ""
    @Published var summary: String = ""
    @Published var crewMembers: [MovieCrewMemberModel] = []
    @Published var imageUrl: String = ""
        
    init(dataSource: MovieDataSource, movieID: Int) {
        self.dataSource = dataSource
        fetchMovieDetails(movieID: movieID)
    }
    
    private func fetchMovieDetails(movieID: Int) {
        guard let details = dataSource.getDetails(id: movieID) else { return }
        self.movieDetails = details
        
        rating = String(details.rating)
        name = details.name
        year = String(details.year)
        releaseDate = formatDateString(from: details.releaseDate)
        categories = details.categories.map { categoryToString($0) }
        duration = formatDuration(minutes: details.duration)
        summary = details.summary
        crewMembers = details.crewMembers
        imageUrl = details.imageUrl
    }
    
    private func formatDateString(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }

    private func formatDuration(minutes: Int) -> String {
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

    private func categoryToString(_ category: MovieCategoryModel) -> String {
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
