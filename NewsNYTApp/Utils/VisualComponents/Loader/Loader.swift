//
//  Loader.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import UIKit
import Lottie

public class Loader {

    public static let shared: Loader = Loader()
    private var loaderView: LoaderView?

    private init() { }
    
    func show(on parentViewController: UIViewController) {
        guard loaderView == nil else {
            return
        }
        
        let loaderView = LoaderView(frame: UIScreen.main.bounds)
        self.loaderView = loaderView
        parentViewController.view.addSubview(loaderView)
    }
    
    func dismiss() {
        guard loaderView != nil else {
            return
        }
        
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
}
