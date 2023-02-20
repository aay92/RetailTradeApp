//
//  UIView + Ext.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 22.11.2022.
//

import UIKit

//MARK: - button line under navigation controllers
extension UIView {
//    For color gradient
    enum Point {
        case topLeading
        case leading
        case bottomLeading
        case top
        case center
        case bottom
        case topTrailing
        case trailing
        case bottomTrailing

        var point: CGPoint {
            switch self {
            case .topLeading:
                return CGPoint(x: 0, y: 0)
            case .leading:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeading:
                return CGPoint(x: 0, y: 1.0)
            case .top:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottom:
                return CGPoint(x: 0.5, y: 1.0)
            case .topTrailing:
                return CGPoint(x: 1.0, y: 0.0)
            case .trailing:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomTrailing:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    
    func addBottomBorder(with color: UIColor, height: CGFloat) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        separator.frame = CGRect(x: 0,
                                 y: frame.height - height,
                                 width: frame.width,
                                 height: height)
        addSubview(separator)
    }
    
//MARK: - Animate button
    func makeSystem(_ button: UIButton) {
        button.addTarget(self, action: #selector(handleIn), for: [
            .touchDown,
            .touchDragInside
        ])
        
        button.addTarget(self, action: #selector(handleOut), for: [
            .touchDragOutside,
            .touchUpInside,
            .touchUpOutside,
            .touchDragExit,
            .touchCancel
        ])
    }
    
    @objc func handleIn(){
        UIView.animate(withDuration: 0.15) { self.alpha = 0.55}
    }
    
    @objc func handleOut(){
        UIView.animate(withDuration: 0.15) { self.alpha = 1}

    }
    
    func addViewWithoutTAMIC(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
//    Set color gradient
    func setGradient(view: UIView, firstColors:UIColor, secondColor: UIColor, x: Int, y: Int, width: Int, height: Int){
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.colors = [firstColors.cgColor, secondColor.cgColor]
        view.layer.addSublayer(layer)
    }
    
    func applyGradient(colours: [UIColor], cornerRadius: CGFloat?, startPoint: CGPoint, endPoint: CGPoint)  {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        if let cornerRadius = cornerRadius {
            gradient.cornerRadius = cornerRadius
        }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colours.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
      }
    
}




