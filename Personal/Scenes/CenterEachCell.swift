//
//  CenterEachCell.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import UIKit

class CenterEachCell: UITableViewCell {

    //    private let labelHeight: CGFloat = 20
        private let margin: CGFloat = 5
        public var facilityNameLabel: UILabel? = {
            let v = UILabel()
            v.text = ""
            v.setAttributeString(font: .title, txtColor: .txTblack, isStrike: true)
            return v
        }()
        public var addressLabel : UILabel? = {
            let v = UILabel()
            v.text = ""
            return v
        }()
        public var updatedAtLabel : UILabel? = {
            let v = UILabel()
            v.text = ""
            return v
        }()
        
        // MARK: Initialize & Configure
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            self.selectionStyle = .gray
            self.addSubview(self.contentView)
            self.configure()
        }

        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure() {
            guard let facilityNameLabel = facilityNameLabel, let addressLabel = addressLabel,let updatedAtLabel = updatedAtLabel else {
                return
            }
            self.contentView.addSubViews([facilityNameLabel, addressLabel, updatedAtLabel])
            self.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.4777094355)

            facilityNameLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(margin)
                make.leading.equalToSuperview().offset(margin)
    //            make.height.equalTo(labelHeight)
            }
            addressLabel.snp.makeConstraints { make in
                make.top.equalTo(facilityNameLabel.snp.bottom).offset(margin)
                make.leading.equalToSuperview().offset(margin)
    //            make.height.equalTo(labelHeight)
            }
            updatedAtLabel.snp.makeConstraints { make in
                make.top.equalTo(addressLabel.snp.bottom).offset(margin)
                make.leading.equalToSuperview().offset(margin)
    //            make.height.equalTo(labelHeight)
                make.bottom.equalToSuperview().inset(margin)
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
