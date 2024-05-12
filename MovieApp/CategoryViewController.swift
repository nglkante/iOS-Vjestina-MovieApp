import UIKit
import MovieAppData
import PureLayout
import Kingfisher

class MovieListByCategoryView: UIViewController {
    let cellIdentifier = "cellId"
    var popularMovies: [MovieModel] = []
    var trendingMovies: [MovieModel] = []
    var freeToWatchMovies: [MovieModel] = []
    override func viewDidLoad() {
        view.backgroundColor = .white
        popularMovies = MovieUseCase().popularMovies
        trendingMovies = MovieUseCase().trendingMovies
        freeToWatchMovies = MovieUseCase().freeToWatchMovies
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let collectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: view.bounds.height),
            collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
extension MovieListByCategoryView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return popularMovies.count
        case 1:
            return trendingMovies.count
        case 2:
            return freeToWatchMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CollectionViewForCatList
        let popularMovie = popularMovies[indexPath.row]
        cell.movie = popularMovie
        return cell
    }
}
extension MovieListByCategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Logic when cell is selected
    }
}
