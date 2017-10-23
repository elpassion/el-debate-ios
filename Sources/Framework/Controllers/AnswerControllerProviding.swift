import UIKit

protocol AnswerControllerProviding: class, ControllerProviding {

    var onChatButtonTapped: ((VoteContext) -> Void)? { get set }

}
