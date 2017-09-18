import UIKit

public protocol PinEntryControllerProviding: class, ControllerProviding {

    var onVoteContextLoaded: ((VoteContext) -> Void)? { get set }

}
