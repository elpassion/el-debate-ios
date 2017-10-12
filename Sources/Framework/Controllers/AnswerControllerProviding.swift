import UIKit

protocol AnswerControllerProviding: class, ControllerProviding {

    var onChatButtonTapped: (() -> Void)? { get set }

}
