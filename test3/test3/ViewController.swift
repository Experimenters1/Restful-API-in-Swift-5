//
//  ViewController.swift
//  test3
//
//  Created by Huy Vu on 2/21/24.
//

import UIKit

struct APIResponse: Codable{
    let total: Int
    let total_pages: Int
    let results: [Result]
}


struct Result: Codable{
    let id: String
    let urls: URLS
}

struct URLS: Codable{
    let regular: String
}

class ViewController: UIViewController {

    @IBOutlet weak var collection_View: UICollectionView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    var results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        collection_View.register(UINib(nibName: "ImageCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "sdfsdf")
        
        
        let margin: CGFloat = 12
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        var sizeCell = (view.frame.size.width - 3 * margin) / 2 - 2
        if UIDevice.current.userInterfaceIdiom == .pad {
            sizeCell = (view.frame.size.width - 5 * margin) / 4
        }
                    
        layout.itemSize = CGSize(width: sizeCell, height: sizeCell)
        layout.sectionInset = UIEdgeInsets.init(top: margin, left: margin, bottom: margin, right: margin)
        collection_View.collectionViewLayout = layout
    }
    
    
   

    
    func fetchPhotos(query:String){
        
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=150&query=\(query)&client_id=1vEY3UguPxk44VTgEoyaQJOHwMGNKOOKkQWCxSXmXGU"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil else{
                return
            }
           
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
//                print(jsonResult.results.count)
                DispatchQueue.main.async {
                    self.results = jsonResult.results
                    self.collection_View?.reloadData() // Reload collection view data
                }
                
            }
            catch {
                print(error)
            }
        }
        

        task.resume()
    }


}



extension ViewController:  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageURLString = results[indexPath.row].urls.regular
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sdfsdf", for: indexPath) as! ImageCollectionViewCell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sdfsdf", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: imageURLString)
        
        return cell
    }
    

}


extension ViewController:  UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        if let text = searchbar.text{
            results = []
            collection_View?.reloadData()
            fetchPhotos(query: text)
        }
    }
}
