//
//  ToDoItemCell.swift
//  ToDo
//
//  Created by Shoumik on 07/05/24.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let locationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(locationLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
