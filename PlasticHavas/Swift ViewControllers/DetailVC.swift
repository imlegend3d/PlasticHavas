//
//  DetailVC.swift
//  PlasticHavas
//
//  Created by David on 2020-10-30.
//

import UIKit

@objc class DetailVC: UIViewController {
    
    @objc var redditPostInfo: RedditPost?
    
    private let postImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = UIColor.systemPink
        return imageView
    }()
    
    private let postTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants().twenty))
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let postText: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.numberOfLines = Constants().zero
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants().twentyFive))
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let separatorView: UIView = {
        let view = UIView()
    
        view.backgroundColor = UIColor.white
        return view
    }()
    private let commentsView: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.numberOfLines = Constants().zero
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants().twentyFive))
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let upVotesView: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.numberOfLines = Constants().zero
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants().twentyFive))
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    private let superView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.2
        setupViews()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //Sets navigation bar view to appear but clear
        
    }
    
    private func setupViews(){
        //Adds all the views to the screen
        
        let deviceScreen = UIScreen.main.bounds.size
        
        var ratio: Double? = 0.6
        
        if let height = redditPostInfo?.thumbnail_height as? Int, let width = redditPostInfo?.thumbnail_width as? Int {
            ratio = Double(height) / Double(width)
            print(ratio)
        }
        
        
        [superView, mainView, upVotesView, postTitle, postImageView, separatorView, postText, commentsView].forEach{view.addSubview($0)}
        
        //sets up all the autolayout of the views.
        
        superView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        mainView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: CGFloat(40), left: CGFloat(40), bottom: CGFloat(-40), right: -CGFloat(40)), size: CGSize(width: (deviceScreen.width * 0.2), height: (deviceScreen.height * 0.2)))
        
        upVotesView.anchor(top: mainView.topAnchor, leading: mainView.leadingAnchor, bottom: nil, trailing: mainView.trailingAnchor, size: .init(width: mainView.frame.size.width, height: ( CGFloat(40))))
        
        postTitle.anchor(top: upVotesView.bottomAnchor, leading: mainView.leadingAnchor, bottom: nil, trailing: mainView.trailingAnchor, size:  .init(width: mainView.frame.size.width, height: CGFloat(160)))
        
        
        //loads the picture on the UIImageView
        if let postHint = redditPostInfo?.post_hint, postHint == "image", let image = redditPostInfo?.url {
            if let url =  URL(string:image){
                
                postImageView.anchor(top: postTitle.bottomAnchor, leading: mainView.leadingAnchor, bottom: nil, trailing: mainView.trailingAnchor, size: .init(width: mainView.frame.size.width, height: CGFloat(200))) //(mainView.frame.size.height * CGFloat(ratio!))))
                
                postImageView.loadImage(from:url)
                
                separatorView.anchor(top: postImageView.bottomAnchor, leading: mainView.leadingAnchor, bottom: postText.bottomAnchor, trailing: mainView.trailingAnchor, size: .init(width: mainView.frame.size.width, height: ( CGFloat(20))))
                
                postText.anchor(top: separatorView.bottomAnchor , leading: mainView.leadingAnchor, bottom: commentsView.topAnchor, trailing: mainView.trailingAnchor, size: .init(width: mainView.frame.size.width, height: ( CGFloat(40))))
                
                commentsView.anchor(top: postText.bottomAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor, size: .init(width: mainView.frame.size.width, height: ( CGFloat(40))))

            }
        } else {
            separatorView.anchor(top: postTitle.bottomAnchor, leading: mainView.leadingAnchor, bottom: postText.bottomAnchor, trailing: mainView.trailingAnchor, size: .init(width: mainView.frame.size.width, height: ( CGFloat(20))))
            
            postText.anchor(top: separatorView.bottomAnchor , leading: mainView.leadingAnchor, bottom: commentsView.topAnchor, trailing: mainView.trailingAnchor, size: .init(width: mainView.frame.size.width, height: ( CGFloat(40))))
            
            commentsView.anchor(top: postText.bottomAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor, size: .init(width: mainView.frame.size.width, height: ( CGFloat(40))))
        }
        
        
        //loads the title
        if let title = redditPostInfo?.title {
            postTitle.text = title
        }
        
        //loads description
        if let text = redditPostInfo?.selftext {
            postText.text = text
        }
        
        //loads upVotes
        if let upVotes = redditPostInfo?.ups {
            upVotesView.text = "UpVotes: \(upVotes)"
        }
        //loads number of comments
        if let numOfComments = redditPostInfo?.num_comments {
            commentsView.text = "Comments: \(numOfComments)"
        }
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
