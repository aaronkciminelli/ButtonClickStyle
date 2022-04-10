//
//  ButtonClick+StyleEmoji.swift
//  ButtonClickStyle
//
//  Created by Рустам Мотыгуллин on 10.04.2022.
//

import UIKit

public extension ButtonClick.Style {
  
  func emojiNew() -> String {
    switch self {
    case .alpha(_):                         return                ""
    case .flash(_):                         return                ""
    case .shadow(_, let color):             return color == nil ? ""  : "🆕"
    case .color(_, _):                      return                ""
    case .colorFlat(_, _):                  return                "" // border text
    case .press(_):                         return                ""
    case .pulsate(_, let new):              return new ? "🆕"  :  ""
    case .shake(_, let new):                return new ? "🆕"  :  ""
    case .androidClickable(_, let color):   return color == nil ? ""  : ""
    case .test_Hide(_): return "test"
    }
  }
  
  func emojiType() -> String {
    switch self {
    case .alpha(_):                 return "👁"
    case .flash(_):                 return "👁"
    case .shadow(_, _):             return "🕳"
    case .color(_, _):              return ""
    case .colorFlat(_, _):          return "🔲 "
    case .press(_):                 return "👇"
    case .pulsate(_, _):            return "💢"
    case .shake(_, _):              return "🔛"
    case .androidClickable(_, _):   return "🧿"
    case .test_Hide(_): return "test"
    }
  }
  
  func emojRepeat() -> String {
    switch self {
    case .alpha(_):                      return ""
    case .flash(_):                      return "♻️"
    case .shadow(_, _):                  return ""
    case .color(_, _):                   return ""
    case .colorFlat(_, _):               return "" // border text
    case .press(_):                      return ""
    case .pulsate(_, _):                 return "♻️"
    case .shake(_, _):                   return "♻️"
    case .androidClickable(_, _):        return ""
    case .test_Hide(_): return "test"
    }
  }
  
  
  func emojiColor() -> String {
    switch self {
    case .alpha(_):                      return         ""
    case .flash(_):                      return         ""
    case .shadow(_, let color):   return color == nil ? "⚫️"  : "🔵"
    case .color(_, _):                   return         "🔵"
    case .colorFlat(_, _):               return         "🔵" // border text
    case .press(_):                      return         ""
    case .pulsate(_, let new):           return new   ? ""  : ""
    case .shake(_, let new):             return new   ? ""  : ""
    case .androidClickable(_, let color):   return color == nil ? "⚫️"  : "🔵"
    case .test_Hide(_): return "test"
    }
  }
  
  func emoji() -> ButtonClick.Emoji {
    return (emojiType(), emojiColor(), emojRepeat(), emojiNew())
  }
  
}
