//
//  InfoCell.swift
//  SwiftWorkOut
//
//  Created by EricHo on 20/11/2015.
//  Copyright © 2015 Eric Ho. All rights reserved.
//

import UIKit
import SDWebImage

class InfoCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var thumbnailImageView:UIImageView!

    
    func setupCell(title:String?, subTitle:String?, imageLink:String?) -> Void {
        self.titleLabel.text = title ?? "n/a"
        self.subTitleLabel.text = subTitle ?? "u/a"
        if let url = NSURL(string: imageLink ?? "") {
            self.thumbnailImageView.sd_setImageWithURL(url, completed: { response -> Void in
                print("hello")

                dispatch_async(dispatch_get_main_queue(), { () -> Void in

                })
            })
        }
        
        /*
        self.activityView.hidesWhenStopped = YES;
        [self.activityView startAnimating];
        [self.productImageView sd_setImageWithURL:[NSURL URLWithString:[self.product productImageUrl]]
        placeholderImage: [UIImage imageNamed:@"placeholder.png"]
        options:SDWebImageRetryFailed
        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityView stopAnimating];
        });
        }];
        
        */
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
