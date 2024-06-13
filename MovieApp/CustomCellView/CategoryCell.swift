import UIKit
import PureLayout
import Kingfisher
import MovieAppData

class CategoryCell: UICollectionViewCell {
    
    var movie: MovieResponse? {
        didSet {
            guard let movie = movie else{return}
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: URL(string: movie.imageUrl))
        }
    }
    let container = UIView()
    let movieImage = UIImageView()
    let heartImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(container)
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.autoPinEdge(toSuperviewEdge: .leading, withInset: 16.0)
        container.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16.0)
        container.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12.0)
        container.autoSetDimension(.height, toSize: 142.0)
        container.addSubview(movieImage)
        container.addSubview(heartImage)
        
        movieImage.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        movieImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        movieImage.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        movieImage.autoSetDimension(.width, toSize: 122)
        
        heartImage.image = UIImage(systemName: "heart.circle")
        heartImage.tintColor = .white
        heartImage.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        heartImage.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
