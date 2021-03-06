//
//  UserEntryCell.swift
//  Sadhana
//
//  Created by Alexander Koryttsev on 8/22/17.
//  Copyright © 2017 Alexander Koryttsev. All rights reserved.
//


import AlamofireImage
import EasyPeasy

class GraphCell : UITableViewCell {
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let entryView = EntryView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white
        contentView.backgroundColor = .white

        contentView.addSubview(avatarImageView)
        avatarImageView.easy.layout([
            Left(10),
            CenterY(),
            Size(44)
        ])

        contentView.addSubview(nameLabel)
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.easy.layout([
            Top().to(avatarImageView, .top),
            Left(10).to(avatarImageView),
            Right(10)
        ])
        nameLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)

        entryView.backgroundColor = .white
        contentView.addSubview(entryView)
        entryView.easy.layout([
            Right().to(nameLabel, .right),
            Bottom(2).to(avatarImageView, .bottom),
            Left().to(nameLabel, .left)
        ])

        separatorInset = UIEdgeInsetsMake(0, 10, 0, 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func map(entry:Entry?, name:String, avatarURL:URL?) {
        if let entry = entry {
            entryView.map(entry, maxRoundsCount: max(16, entry.japaSum))
        }
        else {
            entryView.clear()
        }
        nameLabel.text = name
        avatarImageView.avatarURL = avatarURL
    }

    func clear() {
        entryView.clear()
        nameLabel.text = nil
        avatarImageView.af_cancelImageRequest()
        avatarImageView.avatarURL = Remote.URL.defaultAvatar.fullURL
    }
}
