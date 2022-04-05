//
//  ButtonClickStyleView.swift
//  ButtonLayersButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 09.03.2022.
//

import UIKit

// MARK: - ButtonClickStyleView

@IBDesignable
class ButtonClickStyleView: UIView {
  
  @IBInspectable var animationType: Int = 0
  
  @IBInspectable var allSubviews: Bool = true
  @IBInspectable var animationValue: CGFloat = 0.0
  @IBInspectable var animationDuration: CGFloat = 0.0
  @IBInspectable var buttonColor: Bool = false
  @IBInspectable var startClick: Bool = false
  
  var addViews: [UIView]?
          
  var state: BtnCellState?
  
  private var style: ButtonClick.Style = .alpha(0.5)
  private let debugPrint: Bool = true
  private var setupDone = false
  
  
  var cornerRadius: CGFloat = 0.0
//  var animationTypeValue: CGFloat?
  var animationClickDuration: CGFloat?
  
  
//  var frontView: UIView?
  var button: UIButton?
  
  
  // MARK: - Initialize
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    if self.state == nil {
      var allSubviews = self.allSubviews
      if animationType == ButtonClick.StyleEasy.colorFlat.rawValue {
        allSubviews = false
      }
      
      let animVal: CGFloat? =  animationValue    != 0.0 ? animationValue    : nil
//      let animDur: CGFloat? =  animationDuration != 0.0 ? animationDuration : nil
      
      self.state = .init(
        allSubviews: allSubviews,
        animationType: animationType,
        animationTypeValue: animVal,
        startClick: startClick,
        buttonColor: buttonColor
      )
    }
    updateSubviews()
    
    if debugPrint { print(" ------------------------------------------") }
    if debugPrint { print(" ButtonClickStyleView 👹 init coder 👹 \(self) ") }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    if debugPrint { print(" ------------------------------------------") }
    if debugPrint { print(" ButtonClickStyleView 🥶 init frame 🥶 \(self) ") }
  }
  
  
  public init(
    state: BtnCellState,
    frame: CGRect,
    radius: CGFloat = 0.0,
    addViews: [UIView]? = nil
  ) {
    
    super.init(frame: frame)
    
    var state = state
    if state.animationType == ButtonClick.StyleEasy.colorFlat.rawValue {
      state.allSubviews = false
    }
    
    self.state = state
    self.cornerRadius = radius
    self.layer.cornerRadius = radius
    self.allSubviews = state.allSubviews
    self.animationType = state.animationType ?? 0
//    self.animationTypeValue = state.animationTypeValue
    self.buttonColor = state.buttonColor
    self.addViews = addViews
    self.startClick = state.startClick
    
    
    if debugPrint { print(" ------------------------------------------") }
    if debugPrint { print(" ButtonClickStyleView 🥶 init (STATE frame radius addViews) 🥶 \(self) ") }
    
  }
  
//  public init(
//    frame: CGRect,
//    radius: CGFloat = 0.0,
//    animation: Int = 0,
//    allSubviews: Bool = true,
//    value: CGFloat? = nil,
//    duration: CGFloat? = nil,
//    addViews: [UIView]? = nil,
//    startClick: Bool = false
//  ) {
//    super.init(frame: frame)
//    self.cornerRadius = radius
//    self.allSubviews = allSubviews
//    self.layer.cornerRadius = radius
//    self.animationType = animation
//    self.animationTypeValue = value
//    self.animationClickDuration = duration
//    self.addViews = addViews
//    self.startClick = startClick
//
//    if debugPrint { print(" ------------------------------------------") }
//    if debugPrint { print(" ButtonClickStyleView 🥶 init (frame radius animation value duration addViews startClick) 🥶 \(self) ") }
////    updateSubviews()
//  }
  
  
  // MARK: - Layout subViews Update
  
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    if debugPrint { print(" ButtonClickStyleView 😢Designable💙 draw(_ rect: CGRect)  \(self) ")}
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if debugPrint { print(" ButtonClickStyleView 😢Designable💚 layoutSubviews  \(self) ")}
    updateSubviews()
  }
  
  // MARK: - Update Subviews
  
  public func updateSubviews() {
    if debugPrint { print(" ButtonClickStyleView 🟨 updateSubviews 🟨🥷🏻 setupDone \(setupDone ? "❌" : "✅") \(self) ")}
    
    
    if setupDone { return }
    guard let state = state else { return }
    
    let style = ButtonClick.Style.getClick(state: state)
    
    var onlyButtonReturn = true
    switch style.typeEasy() {
    case .color, .androidClickable, .androidClickableDark: onlyButtonReturn = false
    default: break
    }
    
    if button == nil { createButton() }
    
    if onlyButtonReturn {
      let nviews = getViews()
      if nviews.count == 1 {
        if nviews[0] is UIButton {
          if debugPrint { print(" ButtonClickStyleView 🅿️ nviews ONLY BUTTON 🅿️‼️ return ")}
          return
        }
      }
    }
    
    setAnimation(style: style)
      
    updateStartClick()
    
    setupDone = true
  }
  
  func updateStartClick() {
    if startClick {
      startClick = false
      
      let nviews = getViews()
      button?.onClick(views: nviews, radius: cornerRadius, style: style, duration: animationClickDuration)
    }
  }
  
  public func update(animationType: Int, allSubviews: Bool = true) {
    button?.removeFromSuperview()
    button = nil
    
    self.state?.animationType = animationType
    self.state?.allSubviews = allSubviews
    
    self.animationType = animationType
    self.allSubviews = allSubviews
    
    setupDone = false
//    button?.removeTarget(nil, action: nil, for: .allEvents)
    updateSubviews()
    if let btn = button {
//      btn.backgroundColor = .red.withAlphaComponent(0.25)
      btn.isUserInteractionEnabled = true
    }
  }
  
  
  // MARK: - Set Animation Style
  
  public func setAnimation(style: ButtonClick.Style, views: [UIView]? = nil) {
    self.style = style
    //    updateSubviews()
    
    layer.cornerRadius = cornerRadius
    
    let nviews = getViews(views: views)
    
    if debugPrint { print(" ButtonClickStyleView 🅿️ nviews 🅿️🥷🏻 \(nviews) ")}
    button?.addClickStyle(views: nviews, radius: cornerRadius, style: style, callback: { event in
      if event == .touchUpInside {
        
      }
    })
    if debugPrint { print(" ButtonClickStyleView Ⓜ️ self.subviews Ⓜ️🥷🏻 \(self.subviews) ")}
  }
  
  // MARK: - On Ckick Action
  
  public func onClick(_ duration: CGFloat? = nil) {
    guard let state = state else { return }
    
    self.style = ButtonClick.Style.getClick(state: state)
    button?.onClick(views: getViews(), radius: cornerRadius, style: style, duration: duration)
  }
  
  // MARK: - Create Button
  
  
  
//  public func createFrontView() {
//
//    let v = UIView(frame: bounds)
//    v.backgroundColor = .clear
//    v.clipsToBounds = false
//    addSubview(v)
//    self.frontView = v
//  }
  
  public func createButton() {
    let btn = UIButton(type: .system)
    btn.frame = bounds
    btn.backgroundColor = buttonColor ? UIColor.systemRed.withAlphaComponent(0.4) : .clear
    btn.setTitle(nil, for: .normal)
    btn.layer.cornerRadius = cornerRadius
    btn.clipsToBounds = true
    addSubview(btn)
    self.button = btn
  }
  
  // MARK: - Get Views
  
  func getViews(views: [UIView]? = nil) -> [UIView] {
    
    var nviews: [UIView] = []
    
    if let views = views {
      nviews = views
    } else {

//      if let addViews = addViews {
//        nviews = addViews
//      }
//      else {
        if allSubviews {
        
          if animationType == ButtonClick.StyleEasy.color.rawValue ||
            animationType == ButtonClick.StyleEasy.androidClickable.rawValue ||
            animationType == ButtonClick.StyleEasy.androidClickableDark.rawValue {
          
          if let btn = button {
            
            if let addViews = addViews {
            if animationType == ButtonClick.StyleEasy.androidClickable.rawValue ||
                animationType == ButtonClick.StyleEasy.androidClickableDark.rawValue {
              
                if addViews.count == 1 {
                  let vi = addViews[0]
                  if let bb = button {
                    
                    bb.frame = vi.frame
                    //                vi.getButtonRadius(bb)
                    nviews.append(bb)
                  }
                }
              }
            } else {
              
              
              if !subviews.isEmpty, let vw = subviews.first {
                //              nviews.append(vw)
                
                let framee = vw.convert(vw.bounds, to: superview)
                btn.frame = framee
                //              vw.getButtonRadius(btn)
                nviews.append(btn)
                
              }
            }
            
          } else {
            if !subviews.isEmpty, let vw = subviews.first {
              nviews.append(vw)
            }
          }
          
          
        } else {
          
          nviews.append(self)
          subviews.forEach {
            nviews.append($0)
          }
        }
        
      }
        else {
          if animationType == ButtonClick.StyleEasy.color.rawValue {
//
          if let addViews = addViews {

            if addViews.count == 1 {
              let vi = addViews[0]
              if let bb = button {
                
                bb.frame = vi.frame
//                vi.getButtonRadius(bb)
                nviews.append(bb)
              }
            } else {

              for vv in addViews {
                if let _ = vv as? UILabel {
                  nviews.append(vv)
                } else if let desFig = vv as? DesignableView, desFig.brWidth != 0, desFig.brColor != .clear {
                  nviews.append(vv)
                } else if vv.layer.borderWidth != 0, vv.layer.borderColor != UIColor.clear.cgColor {
                  nviews.append(vv)
                } else
                if let bb = button {
                  bb.frame = vv.frame
                  
//                  vv.getButtonRadius(bb)
                  nviews.append(bb)
                }
              }
            }
          } else {
            if let btn = button {
              
//              let sFrame = superview?.bounds ?? .zero
//              let cFrame = btn.bounds
//
//              if sFrame.width == cFrame.width, sFrame.height == cFrame.height {
//
//                subviews.forEach {
//                  let subFrame = $0.bounds
//
//                  var tempViews: [UIView] = []
//                  if sFrame.width == subFrame.width, sFrame.height == subFrame.height {
//
//                  } else {
//                    tempViews.append($0)
//                  }
//                  if !tempViews.isEmpty {
//                    let vi = tempViews[0]
//                    let frame = vi.convert(vi.bounds, to: superview)
//                    btn.frame = frame
////                    vi.getButtonRadius(btn)
//                    nviews.append(btn)
//                  }
//                }
//
//              } else {
                nviews.append(btn)
//              }
              
             
            }
          }
        }
        
          else if animationType == ButtonClick.StyleEasy.androidClickable.rawValue ||
              animationType == ButtonClick.StyleEasy.androidClickableDark.rawValue,
                let btn = button
        {
          
        
          if let addViews = addViews {
            btn.frame = addViews[0].frame
            let oneView = addViews[0]
            let frame = oneView.convert(oneView.bounds, to: superview)

            btn.frame = frame
//            oneView.getButtonRadius(btn)
          }
          if let addViews = addViews {
            nviews = addViews
          }
          nviews.append(btn)
        }
        else if subviews.count != 0 {
          
          if let addViews = addViews {
            nviews = addViews
          } else {
            let mainView = subviews[0]
            nviews.append(mainView)
          }
        }
      }
      
    }
    return nviews
  }
}

//MARK: - Colors random

extension UIColor {
  
  static func random() -> UIColor {
    func r() -> CGFloat { CGFloat(arc4random()) / CGFloat(UInt32.max) }
    return UIColor(red: r(), green: r(), blue: r(), alpha: 1.0)
  }
}

extension UIView {
  func getButtonRadius(_ btn: UIButton) {
    if btn.layer.cornerRadius == 0 {
      if let desFig = self as? DesignableView, desFig.cornerRadius != 0 {
        btn.layer.cornerRadius = desFig.cornerRadius
      } else if self.layer.cornerRadius != 0 {
        btn.layer.cornerRadius = self.layer.cornerRadius
      }
    }
  }
}
