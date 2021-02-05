// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class LoginQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Login($login: String, $password: String) {
      login(login: $login, password: $password)
    }
    """

  public let operationName: String = "Login"

  public var login: String?
  public var password: String?

  public init(login: String? = nil, password: String? = nil) {
    self.login = login
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["login": login, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("login", arguments: ["login": GraphQLVariable("login"),
                                          "password": GraphQLVariable("password")],
                                         type: .scalar(Bool.self))
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Bool? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "login": login])
    }

    public var login: Bool? {
      get {
        return resultMap["login"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }
}
