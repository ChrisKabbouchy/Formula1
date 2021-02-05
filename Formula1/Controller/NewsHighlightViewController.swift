//
//  NewsHighlightViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 03/02/2021.
//

import UIKit

class NewsHighlightViewController: UIViewController {
    
    var newsModel : NewsModel?
    
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var newsButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBAction func newsButtonPressed(_ sender: UIButton) {
        if let url = URL(string: newsModel?.newsUrl ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageLoader = ImageLoader(imageString: newsModel?.imageUrl)
        sourceLabel.text = newsModel?.sourceName
        authorLabel.text = newsModel?.author
        dateTimeLabel.text = newsModel?.date
        titleLabel.text = newsModel?.title
        descriptionLabel.text = newsModel?.description
        newsImage.image = imageLoader.image
        newsButton.layer.cornerRadius = 10
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
