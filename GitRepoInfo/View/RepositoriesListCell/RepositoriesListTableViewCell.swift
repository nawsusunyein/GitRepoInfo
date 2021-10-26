//
//  RepositoriesListTableViewCell.swift
//  GitRepoInfo
//
//  Created by Naw Su Su Nyein on 10/23/21.
//

import UIKit

class RepositoriesListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblGitRepoName : UILabel!
    @IBOutlet weak var lblGitRepoDescription : UILabel!
    @IBOutlet weak var lblVisibility : UILabel!
    @IBOutlet weak var lblLicense : UILabel!
    @IBOutlet weak var imgAvator : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //Bind data in table view cell
    func bindDataForRepoItem(repoItem : GitItems?){
        self.lblGitRepoName.text = repoItem?.name ?? ""
        self.lblVisibility.text = repoItem?.visibility ?? ""
        self.lblLicense.text = repoItem?.license?.name ?? ""
        self.lblGitRepoDescription.text = repoItem?.description
        self.imgAvator.image = ImageUtils.shared.getImageFromUrl(urlString: repoItem?.owner.avatar_url ?? "")
       
    }
    
}
