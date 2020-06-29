//
//  LocalTableViewCell.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

//
//  LocalTableViewCell.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import UIKit

protocol LocalTableViewCellDelegate: class {
    func followingButtonTappedFor(cell: LocalTableViewCell)
}

final class LocalTableViewCell: UITableViewCell {

    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var distance: UILabel!
    @IBOutlet private weak var followingButton: UIButton!

    private weak var delegate: LocalTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//MARK: - Configure functions
extension LocalTableViewCell {
    func configure(with local: LocalUI, delegate: LocalTableViewCellDelegate) {
        self.delegate = delegate

        name.text = local.name
        distance.text = local.distance  //TODO: Add km

        followingButton.backgroundColor = local.following ? .green : .red
        followingButton.setTitle(local.following ? "Following" : "Follow",
                                 for: .normal)
        followingButton.layer.cornerRadius = 8
    }
}

//MARK: - IBActions
extension LocalTableViewCell {
    @IBAction func followingButtonTapped(_ sender: Any) {
        delegate?.followingButtonTappedFor(cell: self)
    }
}
