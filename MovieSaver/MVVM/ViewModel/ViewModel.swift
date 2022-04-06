//
//  ViewModel.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 5.04.22.
//

@MainActor
class ViewModel<Action> {

  typealias ActionHandler = (Action) -> Void

  private var listeners: [ObjectIdentifier: [ActionHandler]] = [:]

  final func bind(_ listener: AnyObject, handler: @escaping ActionHandler) {
    let objID = ObjectIdentifier(listener)
    var actionHandlers = listeners[objID] ?? []
    actionHandlers.append(handler)
    listeners[objID] = actionHandlers
    postBindingActions(to: listener)
  }

  final func unbind(_ listener: AnyObject) {
    listeners.removeValue(forKey: ObjectIdentifier(listener))
  }

  final func post(_ action: Action, to listener: AnyObject? = nil) {
    if let listener = listener {
      listeners[ObjectIdentifier(listener)]?.forEach { $0(action) }
    } else {
      listeners.values.forEach { $0.forEach { $0(action) } }
    }
  }

  func postBindingActions(to listener: AnyObject) { }
}
