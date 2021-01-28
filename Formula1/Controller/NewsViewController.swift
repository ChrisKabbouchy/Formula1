//
//  NewsViewController.swift
//  Formula1
//
//  Created by Christian Kabouchy on 17/01/2021.
//

import UIKit

class NewsViewController: UIViewController ,UITableViewDelegate{

    @IBOutlet var newsTableView: UITableView!
    
    var newsModel : [NewsModel]?
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        var formulaManager = FormulaManger()
        formulaManager.delegate = self
        formulaManager.fetchNews()

        // Do any additional setup after loading the view.
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

//MARK: -Table view

extension NewsViewController :  UITableViewDataSource ,FormulaMangerDelegate ,ImageLoaderDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageLoader = ImageLoader(imageString: newsModel?[indexPath.row].imageUrl)
        imageLoader.delegate = self
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.newsImage.image = imageLoader.image
        cell.newsLabel.text = newsModel?[indexPath.row].title
        return cell
    }
    func newsDataDidLoad (newsModel : [NewsModel]){
        self.newsModel = newsModel
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    func errorOccurred(error:Error){
        
    }
    func imageDidLoad(image: UIImage) {
        self.image = image
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
}
