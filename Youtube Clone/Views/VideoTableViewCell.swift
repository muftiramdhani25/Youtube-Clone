//
//  VideoTableViewCell.swift
//  Youtube Clone
//
//  Created by Mufti Ramdhani on 18/03/21.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
  
  
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  var video:Video?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setCell(_ v:Video){
    
    self.video = v
    
    // cek apakah data video ada
    guard self.video != nil else {
      return
    }
    
    // untuk set data judul
    self.titleLabel.text = video?.title
    
    // untuk set data tanggal
    let df = DateFormatter()
    df.dateFormat = "EEEE, MMM d, yyyy"
    self.dateLabel.text = df.string(from: video!.published)
    
    // ngecek ada gak thumbnailnya
    guard self.video!.thumbnail != "" else {
      return
    }
    
    if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail){
      
      // untuk set gambar thumbnail
      self.thumbnailImageView.image = UIImage(data: cachedData)
      return
    }
    
    // download gambar thumbnail
    let url = URL(string: self.video!.thumbnail)
    
    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: url!) { (data, response, error) in
      
      // kalo gak ada error dan datanya ada
      if error == nil && data != nil{
        
        // Save gambarnya ke cache
        CacheManager.setVideoCache(url!.absoluteString, data)
        
        if url!.absoluteString != self.video?.thumbnail {
          return
        }
        
        let image = UIImage(data: data!)
        
        // untuk ngeset gambar secara asyncronous (paralel)
        DispatchQueue.main.async {
          self.thumbnailImageView.image = image
        }
      }
    }
    
    dataTask.resume()
  }
  
}
