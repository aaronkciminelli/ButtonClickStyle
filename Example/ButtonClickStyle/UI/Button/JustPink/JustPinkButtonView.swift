import UIKit

class JustPinkButtonView: BtnView {
  
  // MARK: Outlets
  
  @IBOutlet var fillView: DesignableView!
  @IBOutlet var mainView: UIView!
  @IBOutlet var mainShadowView: DesignableView!
  @IBOutlet var subMainView: DesignableView!
  @IBOutlet var mainDetailsView: DesignableView!
  @IBOutlet var gradientView: DesignableView!
  @IBOutlet var titleLabel: UILabel!
  
  // MARK: Initialize
 
  override func fill(state: ButtonClick.State?) {
     guard let state = state else { return }
     self.state = state

   if let type = state.animationType {
     let fr: CGRect = .init(x: 13 , y: 10, width: 176, height: 56)
     var views: [UIView]? = []
     
     
     if state.new {
       let color: UIColor = #colorLiteral(red: 0.568627451, green: 0.2784313725, blue: 1, alpha: 1)
       fillView.fillColor =  #colorLiteral(red: 0.1529411765, green: 0.6823529412, blue: 0.3764705882, alpha: 1).withAlphaComponent(0.08)
       
//       gradientView.isHidden = true
//       gradientView.alpha = 0
       gradientView.isHidden = false
       gradientView.alpha = 1.5
       
       mainDetailsView.fillColor = color
       
       mainDetailsView.grColor1 = #colorLiteral(red: 0.568627451, green: 0.2784313725, blue: 1, alpha: 1)
       mainDetailsView.grColor2 = #colorLiteral(red: 0.568627451, green: 0.7273057943, blue: 1, alpha: 1)
       mainDetailsView.grStartPoint = .init(x: 0, y: 1)
       mainDetailsView.grEndPoint = .init(x: 1, y: 0)
       
       mainShadowView.fillColor = color.withAlphaComponent(0.8)
       mainShadowView.blur = 36
       views = [subMainView]
       
     } else {
       fillView.fillColor = .systemGray5.withAlphaComponent(0.55)
       gradientView.isHidden = false
       gradientView.alpha = 1
       mainShadowView.blur = 24
//       gradientView.grColor1 = #colorLiteral(red: 0.568627451, green: 0.2784313725, blue: 1, alpha: 1)
//       gradientView.grColor2 = #colorLiteral(red: 0.568627451, green: 0.8245446441, blue: 1, alpha: 1)
       
       
       mainDetailsView.grColor1 = nil
       mainDetailsView.grColor2 = nil
       
       let color: UIColor = #colorLiteral(red: 0.9215686275, green: 0.2078431373, blue: 0.5058823529, alpha: 1)
       mainDetailsView.fillColor = color
       mainShadowView.fillColor = color.withAlphaComponent(0.58)
       views = [mainView]
     }
     fillView.blur = 20
     
     fillView.layoutSubviews()
     gradientView.layoutSubviews()
     mainShadowView.layoutSubviews()
     mainDetailsView.layoutSubviews()
     
     
     if type == ButtonClick.Style.color(0.5, color: .red).indx()  {
//        type == ButtonClick.Style.androidClickable(0.5, dark: true).indx() ||
//        type == ButtonClick.Style.androidClickable(0.5, dark: false).indx() {
       views = [subMainView]
     }
     if type == ButtonClick.Style.press(0.5).indx() {
       views = [subMainView, mainShadowView]
     }
     if type == ButtonClick.Style.colorFlat(0.5, color: .red).indx() {
       views = [subMainView, titleLabel]// [mainDetailsView]
     }
    if type == ButtonClick._Style.androidClickable.rawValue ||
              type == ButtonClick._Style.androidClickableDark.rawValue {
//       views = nil
      views = [subMainView]
     }
     
     mainDetailsView.setNeedsLayout()
     mainShadowView.setNeedsLayout()
     
     let viewAn = ButtonClickStyleView(
      state: state,
      frame: fr,
      radius: 8,
      addViews: views
     )
     viewAn.insertSubview(mainView, at: 0)
     viewAn.updateSubviews()
     
     
     
     addSubview(viewAn)
     viewAn.translatesAutoresizingMaskIntoConstraints = false
     viewAn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
     viewAn.topAnchor.constraint(equalTo: self.topAnchor, constant: fr.origin.y).isActive = true
     viewAn.widthAnchor.constraint(equalToConstant: fr.width).isActive = true
     viewAn.heightAnchor.constraint(equalToConstant: fr.height).isActive = true
     
     self.animation?.removeFromSuperview()
     self.animation = viewAn
     mainView.origin = .zero
     
     
   }
   
     titleLabel?.text = state.titleText
        
  }
}