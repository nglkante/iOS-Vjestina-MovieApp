import Foundation
import Combine
import MovieAppData

class MovieListViewModel {
    @Published private(set) var allMovies: [MovieModel] = []
    
    private let dataSource: MovieDataSource
    
    init(dataSource: MovieDataSource) {
        self.dataSource = dataSource
        fetchAllMovies()
    }
    
    private func fetchAllMovies() {
        allMovies = dataSource.allMovies
    }
}
