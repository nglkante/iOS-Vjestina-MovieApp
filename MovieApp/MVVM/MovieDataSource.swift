import Foundation
import MovieAppData

class MovieDataSource {
    private let movieUseCase: MovieUseCaseProtocol
    
    init(movieUseCase: MovieUseCaseProtocol = MovieUseCase()) {
        self.movieUseCase = movieUseCase
    }
    
    var allMovies: [MovieModel] {
        return movieUseCase.allMovies
    }
    
    var popularMovies: [MovieModel] {
        return movieUseCase.popularMovies
    }
    
    var freeToWatchMovies: [MovieModel] {
        return movieUseCase.freeToWatchMovies
    }
    
    var trendingMovies: [MovieModel] {
        return movieUseCase.trendingMovies
    }
    
    func getDetails(id: Int) -> MovieDetailsModel? {
        return movieUseCase.getDetails(id: id)
    }
}
