import UIKit
import MovieAppData
import PureLayout
import Kingfisher

class MovieCategoriesListViewController: UIViewController {
    let cellIdentifier = "cellId"
    var popularMovies: [MovieModel] = []
    var trendingMovies: [MovieModel] = []
    var freeToWatchMovies: [MovieModel] = []
    var popularcollectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var freeToWatchCollectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var trendingCollectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    override func viewDidLoad() {
        view.backgroundColor = .white
        popularMovies = MovieUseCase().popularMovies
        trendingMovies = MovieUseCase().trendingMovies
        freeToWatchMovies = MovieUseCase().freeToWatchMovies
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        let darkBlue = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
        let popularLabel = UILabel()
        let freeToWatchLabel = UILabel()
        let trendingLabel = UILabel()
        view.addSubview(popularLabel)
        popularLabel.text = "What's popular"
        popularLabel.textColor = darkBlue
        popularLabel.font = UIFont.boldSystemFont(ofSize: 20)
        popularLabel.autoPinEdge(toSuperviewSafeArea: .top,withInset: 24)
        popularLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 12)
       
        popularcollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        popularcollectionView.backgroundColor = .white
        view.addSubview(popularcollectionView)
        popularcollectionView.translatesAutoresizingMaskIntoConstraints = false
        popularcollectionView.dataSource = self
        popularcollectionView.delegate = self
        popularcollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellA")
        popularcollectionView.autoPinEdge(.top, to: .bottom, of: popularLabel,withOffset: 16)
        popularcollectionView.autoPinEdge(toSuperviewEdge: .left,withInset: 10)
        popularcollectionView.autoPinEdge(toSuperviewEdge: .right,withInset: -10)
        popularcollectionView.autoSetDimension(.height, toSize: 142.0)
        
        view.addSubview(freeToWatchLabel)
        freeToWatchLabel.text = "Free to Watch"
        freeToWatchLabel.textColor = darkBlue
        freeToWatchLabel.font = UIFont.boldSystemFont(ofSize: 20)
        freeToWatchLabel.autoPinEdge(.top, to: .bottom, of: popularcollectionView, withOffset: 40)
        freeToWatchLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 12)
        
        freeToWatchCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        freeToWatchCollectionView.backgroundColor = .white
        view.addSubview(freeToWatchCollectionView)
        freeToWatchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        freeToWatchCollectionView.dataSource = self
        freeToWatchCollectionView.delegate = self
        freeToWatchCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellB")
        freeToWatchCollectionView.autoPinEdge(.top, to: .bottom, of: freeToWatchLabel,withOffset: 16)
        freeToWatchCollectionView.autoPinEdge(toSuperviewEdge: .left,withInset: 10)
        freeToWatchCollectionView.autoPinEdge(toSuperviewEdge: .right,withInset: -10)
        freeToWatchCollectionView.autoSetDimension(.height, toSize: 142.0)
        
        view.addSubview(trendingLabel)
        trendingLabel.text = "Trending"
        trendingLabel.textColor = darkBlue
        trendingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        trendingLabel.autoPinEdge(.top, to: .bottom, of: freeToWatchCollectionView, withOffset: 40)
        trendingLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 12)
        
        trendingCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        trendingCollectionView.backgroundColor = .white
        view.addSubview(trendingCollectionView)
        trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        trendingCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellC")
        trendingCollectionView.autoPinEdge(.top, to: .bottom, of: trendingLabel,withOffset: 16)
        trendingCollectionView.autoPinEdge(toSuperviewEdge: .left,withInset: 10)
        trendingCollectionView.autoPinEdge(toSuperviewEdge: .right,withInset: -10)
        trendingCollectionView.autoSetDimension(.height, toSize: 142.0)
    }
    
}
extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularcollectionView {
                return popularMovies.count
            }
        else if collectionView == self.freeToWatchCollectionView {
            return freeToWatchMovies.count
        }
        else{
            return trendingMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        if collectionView == self.popularcollectionView {
            let popularMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellA", for: indexPath) as! CategoryCell
            popularMovieCell.movie = popularMovies[indexPath.row]
            return popularMovieCell
        }
        else if collectionView == self.freeToWatchCollectionView{
            let freeToWatchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellB", for: indexPath) as! CategoryCell
            freeToWatchCell.movie = freeToWatchMovies[indexPath.row]
            return freeToWatchCell
        }
        else{
            let trendingMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellC", for: indexPath) as! CategoryCell
            trendingMovieCell.movie = trendingMovies[indexPath.row]
            return trendingMovieCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 179)
    }
}
