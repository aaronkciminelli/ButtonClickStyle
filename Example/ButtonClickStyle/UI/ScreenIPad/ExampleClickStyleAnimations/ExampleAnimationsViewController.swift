import UIKit

//MARK: - ExampleAnimations Screen

class ExampleAnimationsViewController: StoryboardController {
  
  var colorChanging: Bool = false
  @IBOutlet var colorButtonClickStyleDesignView: ButtonClickStyleDesignView!
  var colorSelected: UIColor?
  
  @IBOutlet var allSubviewsSwitch: UISwitch!
  @IBOutlet var addBackgroundColorSwitch: UISwitch!
  @IBOutlet var createStartClick: UISwitch!
  
  @IBOutlet var testValueLabel: UILabel!
  @IBOutlet var testTypePicker: UIPickerView?
  @IBOutlet var testValueSlider: UISlider!
  var animationType: Int = 0
  var buttonType: Int = 1
  
  var buttonsAdded: [BtnView] = []
  var labelsAdded: [UILabel] = []
  var buttonTypes: [ButtonClick.Full] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    title = "Click Style Animations"
    
    buttonTypes = ButtonClick.Style.allNameFull
    
    allSubviewsSwitch.addTarget(self, action: #selector(allSubviewsSwitchAction(swtch:event:)), for: .valueChanged)
    
    addBackgroundColorSwitch.addTarget(self, action: #selector(addBackgroundColorSwitchAction(swtch:event:)), for: .valueChanged)
    
    testValueSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    
    
    createStartClick.addTarget(self, action: #selector(createStartClickSwitchAction(swtch:event:)), for: .valueChanged)
    
    update()
  }
  
  var aaa: CGFloat = 0
  var bbb: CGFloat = 0
  
  func update() {
    
    buttonsAdded.forEach { $0.removeFromSuperview() }
    buttonsAdded.removeAll()
    
    labelsAdded.forEach { $0.removeFromSuperview() }
    labelsAdded.removeAll()
    
    aaa = 0
    bbb = 0
    
    buttonTypes.enumerated().forEach {  (index, name) in
//      self.buttonType = index
      self.animationType = index
//      self.animationType =  Int(arc4random_uniform(13))
      self.updateButtons()
    }
    
    
    
  }
  
  
  var buttonTypesCopy: [Int] = []
  
  //MARK: - Get State
  
  func getValue() -> CGFloat {
    CGFloat(testValueSlider.value)
  }
  
  func getState() -> ButtonClick.State {
    return .init(
      titleText: buttonTypes[animationType].base,
      allSubviews: animationType == ButtonClick._Style.color.rawValue ? false : allSubviewsSwitch.isOn,
      animationType: animationType,
      animationTypeValue: getValue(),
      new: buttonType == 1,
      color: colorSelected,
      startClick: createStartClick.isOn,
      addBackgrondColor: addBackgroundColorSwitch.isOn
    )
  }
  
  func getFrame() -> CGRect {
    let size: CGSize = .init(width: 240, height: 98)
    let padding: CGPoint = .init(x: 40, y: 70)
    let offs: CGPoint = .init(x: 10, y: 10)
    let framee: CGRect = .init(
      x: padding.x + ((aaa) * size.width + offs.x) ,
      y: padding.y + ((bbb) * size.height + offs.y) ,
      width: size.width,
      height: size.height
    )
    
    return framee
  }
  
  @IBAction func colorPickerAction(_ sender: Any) {
    resetAllColorChangeFlags()
    colorChanging = true
    if #available(iOS 14.0, *) {
      let colorPicker = UIColorPickerViewController()
      colorPicker.delegate = self
      present(colorPicker, animated: true, completion: nil)
    } else {
      colorNotPicker()
    }
  }
  
  func colorNotPicker() {
    colorSelected = UIColor.random()
    update()
    colorButtonClickStyleDesignView.fillColor = colorSelected
    colorButtonClickStyleDesignView.setNeedsLayout()
    resetAllColorChangeFlags()
  }
  
  @objc func allSubviewsSwitchAction(swtch: UISwitch, event: UIEvent) {
    update()
  }
  
  @objc func addBackgroundColorSwitchAction(swtch: UISwitch, event: UIEvent) {
    update()
  }
  
  @objc func createStartClickSwitchAction(swtch: UISwitch, event: UIEvent) {
    update()
  }
  
  @IBAction func buttonReloadAction(_ sender: Any) {
    update()
  }
  
  @IBAction func buttonColorClear(_ sender: Any) {
    colorSelected = nil
    colorButtonClickStyleDesignView.fillColor = .clear
    colorButtonClickStyleDesignView.setNeedsLayout()
    update()
  }
  
  
  //MARK: - Slider Action
  
  @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
    if let touchEvent = event.allTouches?.first {
      switch touchEvent.phase {
      case .ended:
//        updateButtons()
        update()
      default:
        break
      }
    }
    
    let v = String(format: "%.2f",slider.value)
    
    testValueLabel.text = v
    
    testTypePicker?.reloadAllComponents()
  }
  
  //MARK: - Update Buttons View
  
  func updateButtons() {
    
    
    
    let state: ButtonClick.State = getState()
    
    
    var child: BtnView?
    
    switch buttonType { //
    case  0: child = JustPinkButtonView()
    case  1: child = JustPinkButtonView()
    case  2: child = BlueButtonView()
    case  3: child = BuyNowButtonView()
    case  4: child = DownloadButtonView()
    case  5: child = DeleteButtonView()
    case  6: child = SearchButtonView()
    case  7: child = SubscribeButtonView()
    case  8: child = FirefoxButtonView()
    case  9: child = GoogleButtonView()
    case 10: child = GradientBlueBasicButtonView()
    case 11: child = NeomorphismButtonView()
    case 12: child = TestDemoGradientButtonView()
    case 13: child = TestDemoBlurButtonView()
    case 14: child = TestDemoSquaresButtonView()
    case 15: child = BorderGreenDarkButtonView()
    default:  break
    }
    
    var label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 19)
    label.frame = getFrame()
    label.text =  buttonTypes[animationType].name
    label.frame = .init(x: label.frame.origin.x + 250, y: label.frame.origin.y - 12, width: label.frame.size.width + 100, height: label.frame.size.height)
    
    self.view.addSubview(label)
    labelsAdded.append(label)
    
    var xX: CGFloat = 440
    let xP: CGFloat = 20
    let xW: CGFloat = 40
    let xA: CGFloat = 0.7
    let xC: CGFloat = 0.025
    let xF: CGFloat = 19
    
    label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: xF)
    label.textAlignment = .center
    label.frame = getFrame()
    label.text = buttonTypes[animationType].base // //.isEmpty ? "" : "☑️"
    label.frame = .init(x: xX, y: label.frame.origin.y - 12, width: xW + 30, height: label.frame.size.height)
    
    label.alpha = 0.0
    label.backgroundColor = .black.withAlphaComponent(xC)
    self.view.addSubview(label)
    labelsAdded.append(label)
    xX = label.frame.origin.x + label.frame.size.width + xP
    
    let xD: CGFloat = 1.5
    label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: xF)
    label.textAlignment = .center
    label.frame = getFrame()
    label.text = buttonTypes[animationType].emoji.color //.isEmpty ? "" : "☑️"
    
    label.frame = .init(x: xX, y: label.frame.origin.y - 12, width: xW, height: label.frame.size.height)
    
    label.alpha = xA / xD
    label.backgroundColor = .black.withAlphaComponent(xC * xD)
    self.view.addSubview(label)
    labelsAdded.append(label)
    xX = label.frame.origin.x + label.frame.size.width + xP
    
    label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: xF)
    label.textAlignment = .center
    label.frame = getFrame()
    label.text = buttonTypes[animationType].emoji.repeats.isEmpty ? "" : "☑️"
    label.frame = .init(x: xX, y: label.frame.origin.y - 12, width: xW, height: label.frame.size.height)
    label.alpha = xA
    label.backgroundColor = .black.withAlphaComponent(xC)
    self.view.addSubview(label)
    labelsAdded.append(label)
    xX = label.frame.origin.x + label.frame.size.width + xP
    
    label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: xF)
    label.textAlignment = .center
    label.frame = getFrame()
    label.text = buttonTypes[animationType].emoji.new //.isEmpty ? "" : "☑️"
    label.frame = .init(x: xX, y: label.frame.origin.y - 12, width: xW, height: label.frame.size.height)
    label.alpha = xA
    label.backgroundColor = .black.withAlphaComponent(xC)
    self.view.addSubview(label)
    labelsAdded.append(label)
    
    if let child = child {
      child.fill(state: state)
      child.frame = getFrame()
      self.view.addSubview(child)
      buttonsAdded.append(child)
    }
    
    aaa = aaa + 1
    if aaa == 1 {
      aaa = 0
      bbb = bbb + 1
    }
  }
  
  
}

extension ExampleAnimationsViewController: UIColorPickerViewControllerDelegate {
  
  @available(iOS 14.0, *)
  func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    
    if colorChanging
    {
      colorSelected = viewController.selectedColor
    }
  }
  
  @available(iOS 14.0, *)
  func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController)
  {
    update()
    colorButtonClickStyleDesignView.fillColor = colorSelected
    colorButtonClickStyleDesignView.setNeedsLayout()
    resetAllColorChangeFlags()
    
  } // ends colorPickerViewControllerDidFinish
  
  func resetAllColorChangeFlags()
  {
    colorChanging = false
    
  } // ends resetAllColorChangeFlags
}

//MARK: - PickerView DataSource

extension ExampleAnimationsViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ButtonClick.Style.allNameFull.count
  }
}


//MARK: - PickerView Delegate

extension ExampleAnimationsViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var pickerLabel: UILabel? = (view as? UILabel)
    if pickerLabel == nil {
      pickerLabel = UILabel()
      pickerLabel?.font = UIFont.systemFont(ofSize: 18)
      pickerLabel?.adjustsFontSizeToFitWidth = true
      pickerLabel?.minimumScaleFactor = 0.7
      pickerLabel?.textAlignment = .right
    }
    
    var text: String = ""
        text = ButtonClick.Style.allNameFull[row].name

    
    pickerLabel?.text = text
    pickerLabel?.textColor = UIColor.black
    
    return pickerLabel!
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

    return ButtonClick.Style.allNameFull[row].name
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    animationType = row
    update()
  }
}
