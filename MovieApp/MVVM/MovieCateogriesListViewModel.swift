import Foundation
import Combine
import MovieAppData

class MovieCategoriesListViewModel {
    @Published private(set) var popularMovies: [MovieModel] = []
    @Published private(set) var trendingMovies: [MovieModel] = []
    @Published private(set) var freeToWatchMovies: [MovieModel] = []
    
    private let dataSource: MovieDataSource
    private let networkService: NetworkService
    var onGotData: (()->Void)?
    var ftwMovie: [MovieResponse] = []
    
    init(dataSource: MovieDataSource, networkService: NetworkService) {
        self.dataSource = dataSource
        self.networkService = networkService
    }
    
    func fetchMovies() {
        //        popularMovies = dataSource.popularMovies
        //        trendingMovies = dataSource.trendingMovies
        //        freeToWatchMovies = dataSource.freeToWatchMovies
        networkService.makeUrlRequest(categories: "free-to-watch", criteria: "MOVIE") { (result: Result<[MovieResponse], Error>) in
            switch result {
            case .failure(let error):
                print("Error")
            case .success(let value):
                print(value)
                self.ftwMovie.append(contentsOf: value)
                self.onGotData?()
            }
        }
    }
    
//    func movie(at indexPath: IndexPath, for category: MovieCategory) -> MovieModel {
//        switch category {
//        case .popular:
//            return popularMovies[indexPath.row]
//        case .trending:
//            return trendingMovies[indexPath.row]
//        case .freeToWatch:
//            return freeToWatchMovies[indexPath.row]
//        }
//    }
    
    enum MovieCategory {
        case popular
        case trending
        case freeToWatch
    }
}
