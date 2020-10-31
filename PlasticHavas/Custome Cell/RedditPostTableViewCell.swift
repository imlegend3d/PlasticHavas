//
//  RedditPostTableViewCell.swift
//  PlasticHavas
//
//  Created by David on 2020-10-29.
//

import UIKit

@objc class RedditPostTableViewCell: UITableViewCell {
    
    @objc static let identifier = "redditPostTableViewCell"
    
    @objc static func nib()-> UINib {
        return UINib(nibName: "redditPostTableViewCell", bundle: nil)
    }

    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postUpVotes: UILabel!
    @IBOutlet weak var postNumComments: UILabel!
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    var hint: String?
    
    var redditPost: RedditPost?
    
    @objc public func configure(with title: String, upVotes: Int, comments: Int, hint: String?, imageName: String?, iwidth: Int, iheight: Int, post: RedditPost){
        self.redditPost = post
        postTitle.text = title
        postUpVotes.text = "UpVotes: \(upVotes)"
        postNumComments.text = "Comments: \(comments)"
    
        if let hint = hint, hint == "image"{
            cellHeight.constant = 225
           
            if imageName != nil && imageName! != ""  {
               
                if let urlString = imageName, let url = URL(string: urlString) {
                   
                    URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                        if let data = data {
                            
                            DispatchQueue.main.async {
                                
                                self.postImage.image = UIImage(data: data)
                            }
                        }
                    }.resume()
                }
    //            postImage.image = UIImage(named: imageName!)
//                imageWidth.constant = CGFloat(iwidth)
//                imageHeight.constant = CGFloat(iheight)
            } else {
                imageWidth.constant = CGFloat.zero
                imageHeight.constant = CGFloat.zero
            }
        } else if let hint = hint, hint == "Link"{
            cellHeight.constant = 110
            imageWidth.constant = CGFloat.zero
            imageHeight.constant = CGFloat.zero
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

