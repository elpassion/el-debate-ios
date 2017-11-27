import UIKit

protocol AnswerControllerProviding: ControllerProviding {

    var onChatButtonTapped: ((VoteContext) -> Void)? { get set }

}
