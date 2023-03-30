//
//  TableViewCell.swift
//  MVVMDemo
//
//  Created by sudhir on 22/06/22.
//

import UIKit
import Kingfisher

class HomeFeedTVC: UITableViewCell {
    //MARK: - class variable
    static let identifier = "HomeFeedTVC"
    static func nibID() -> UINib { UINib(nibName: self.identifier, bundle: nil) }
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imgViewArtwork: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArtistDetail: UILabel!
    @IBOutlet weak var lblArtworkType: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - properties (PI)
    var viewModel:HomeFeedPresentable? {
        didSet{
            self.imgViewArtwork.kf.setImage(with : viewModel?.imageURL, options: [ .transition(.fade(1))]) {[weak self] r in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                switch r {
                    case .failure(_):
                        self?.imgViewArtwork.image = UIImage(named: "naru")
                    
                    case .success(_):
                                    ()
                }
            }
            self.lblTitle.text = viewModel?.title
            self.lblArtistDetail.text = viewModel?.artist_display
            self.lblArtworkType.text = viewModel?.artist_display
            self.lblDate.text = viewModel?.date
        }
    }
    
    //MARK: - view Life
    override func awakeFromNib() {
        super.awakeFromNib()
        initialConfiguation()
        
        self.selectionStyle = .none
        activityIndicator.style = .large
        activityIndicator.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        activityIndicator.color = .purple
        activityIndicator.startAnimating()
    }
    
    deinit{
        debugPrint("---- Deinit  HomeFeedTV Cell ------")
    }
    
    //MARK: - IBActions
    
    //MARK: - Action(OBJC)
    
}


//MARK: - Custom functions
extension HomeFeedTVC {
    func initialConfiguation(){
        viewCard.roundCorners(cornerRadius: 10)
        viewCard.backgroundColor = .yellow
        lblArtworkType.textColor = .blue
        lblArtworkType.backgroundColor = UIColor(hex: "#D9FFFF4f")
        [lblTitle,lblArtistDetail,lblDate].forEach{
            $0?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            $0?.backgroundColor = UIColor(hex: "#D9FFFF4f")
        }
    }
}
