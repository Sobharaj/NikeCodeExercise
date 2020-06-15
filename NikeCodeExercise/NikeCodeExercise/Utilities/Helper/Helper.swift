//
//  Helper.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/12/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

/// This method responsible to create a customView
///
/// - Returns:  UIView refrence
func customView() -> UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.clipsToBounds = true // this will make sure its children do not go out of the boundary
    return view
}

/// This method responsible to create a customLabel
///
/// - Parameters:
///   - UIFont: UIFont Refrence
/// - Returns:  UILabel refrence
func customLabel( _ font: UIFont) -> UILabel {
    let label = UILabel()
    label.font = font
    label.textColor = .black
    label.numberOfLines = 0
    label.text = StringKey.NA
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}

/// This method responsible to create a customImageView
///
/// - Returns:  UIImageView refrence
func customImageView() -> UIImageView {
    let img = UIImageView()
    img.contentMode = .scaleAspectFit // image will never be strecthed vertially or horizontally
    img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
    img.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.8183058647)
    img.clipsToBounds = true
    return img
}

/// This method responsible to create a customButton
///
/// - Returns:  UIButton refrence
func customButton() -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
    button.backgroundColor = #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 0.7737585616)
    button.setTitleColor(.white, for: .normal)
    return button
}

/// This method responsible  to create a customTableView
///
/// - Returns:  UITableView refrence
func customTableView() -> UITableView {
    let tableView = UITableView()
    tableView.backgroundColor = UIColor.white
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.tableFooterView = UIView()
    return tableView
}

/// This method responsible to create a customIndicator
///
/// - Returns:  UIActivityIndicatorView refrence
func customIndicator() -> UIActivityIndicatorView {
    let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    return indicator
}
