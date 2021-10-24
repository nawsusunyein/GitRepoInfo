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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindDataForRepoItem(repoItem : GitItems?){
        self.lblGitRepoName.text = repoItem?.name ?? ""
        self.lblVisibility.text = repoItem?.visibility ?? ""
        self.lblLicense.text = repoItem?.license?.name ?? ""
    }
    
}
