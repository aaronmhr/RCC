//
//  ErrorPresenter.swift
//  RCC
//
//  Created by Aaron Huánuco on 25/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit

protocol ErrorPresenter where Self: UIViewController {
    func alert(title: String, message: String, action: @escaping () -> Void)
}

extension ErrorPresenter {
    func alert(title: String = Localizables.title, message: String, action: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: Localizables.ok, style: .default, handler: { _ in
            action()
        })
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

private enum Localizables {
    static let title = "Something went wrong!"
    static let ok = "OK"
}
