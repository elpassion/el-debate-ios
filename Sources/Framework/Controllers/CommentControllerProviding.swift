import UIKit

protocol CommentControllerProviding: class, ControllerProviding {

    var onChatButtonTapped: (() -> Void) { get set }

}
