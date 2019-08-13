//
//  AddSourceViewController.swift
//  RSSNewsFeed
//
//  Created by Syrov Nikita on 10/08/2019.
//  Copyright © 2019 Syrov Nikita. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class AddSourceViewController: UIViewController {
    var viewModel: SourceEditViewModel!
    @IBOutlet weak var sourceURLTextField: UITextField!
    @IBOutlet weak var sourceNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        configureTextFields()
        super.viewDidLoad()
    }
    
    private func configureTextFields() {
        if let source = viewModel.editingSource {
            sourceNameTextField.text = source.sourceName
            sourceURLTextField.text = source.sourceURL.absoluteString
        }
    }
    
    @IBAction func didTapSave(_ sender: UIButton) {
        MBProgressHUD.showAdded(to: view, animated: true)
        viewModel.saveSource(name:sourceNameTextField.text, urlString: sourceURLTextField.text) { (error) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                if let addSourceError = error {
                    let alertViewController = UIAlertController(title: "Error occured", message: addSourceError.rawValue, preferredStyle: .alert)
                    alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            switch addSourceError {
                            case .invalidName:
                                self.sourceNameTextField.text = nil
                            case .invalidURL:
                                self.sourceURLTextField.text = nil
                            }
                    }))
                    self.present(alertViewController, animated: true, completion: nil)
                }
            }
        }
    }
}
