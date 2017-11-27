import UIKit

public protocol PinEntryControllerProviding: ControllerProviding {

    var onVoteContextLoaded: ((VoteContext) -> Void)? { get set }

}
