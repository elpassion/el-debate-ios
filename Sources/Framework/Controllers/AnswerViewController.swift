import Anchorage
import UIKit

class AnswerViewController: UIViewController, AnswerControllerProviding, AlertPresentingController {

    let voteContext: VoteContext
    private let voteService: VoteServiceProtocol
    let alertPresenter: AlertShowing

    var onChatButtonTapped: ((VoteContext) -> Void)?

    // MARK: - Initializer

    init(voteContext: VoteContext,
         voteService: VoteServiceProtocol,
         alertView: AlertShowing) {
        self.voteContext = voteContext
        self.voteService = voteService
        self.alertPresenter = alertView

        super.init(nibName: nil, bundle: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func loadView() {
        view = AnswerView()
    }

    var answerView: AnswerView { return forceCast(view) }

    override func viewDidLoad() {
        super.viewDidLoad()

        answerView.onChatButtonTapped = { [weak self] in
            guard let `self` = self else { return }

            self.onChatButtonTapped?(self.voteContext)
        }
        answerView.onAnswerSelected = { [weak self] in self?.didSelectAnswer(with: $0) }

        title = "EL Debate"

        let debate = voteContext.debate
        answerView.config(
            debateTitle: debate.topic,
            yesAnswerText: debate.positiveAnswer.value,
            undecidedAnswerText: debate.neutralAnswer.value,
            noAnswerText: debate.negativeAnswer.value
        )

        selectInitialAnswer()
    }

    private func didSelectAnswer(with answerType: AnswerType) {
        let authToken = voteContext.authToken
        let answer = voteContext.answer(for: answerType)
        answerView.enabled = false

        voteService.vote(authToken: authToken, answer: answer)
            .then { [weak self] answer -> Void in
                self?.answerView.selectAnswer(type: answer.type)
            }.catch { [weak self] error in
                presentError(error, in: self)
            }.always { [weak self] in
                self?.answerView.cancelAnimations()
                self?.answerView.enabled = true
            }
    }

    private func selectInitialAnswer() {
        guard let answerType = voteContext.debate.lastAnswerType else {
            return
        }

        answerView.selectAnswer(type: answerType)
    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private func presentError(_ error: Error, in controller: AlertPresentingController?) {
    if case RequestError.throttling = error {
        presentSlowDownError(in: controller)
    } else {
        presentGenericError(in: controller)
    }
}

private func presentGenericError(in controller: AlertPresentingController?) {
    presentAlert(in: controller, title: "Error", message: "There was a problem submitting your vote")
}

private func presentSlowDownError(in controller: AlertPresentingController?) {
    presentAlert(in: controller, title: "Slow down", message: "You are voting too fast")
}
