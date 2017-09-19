import Anchorage
import UIKit

class AnswerViewController: UIViewController, AnswerControllerProviding, AlertPresentingController {

    let voteContext: VoteContext
    private let apiClient: APIProviding
    let alertPresenter: AlertShowing
    private let commentPresenter: CommentControllerPresenting

    // MARK: - Initializer

    init(voteContext: VoteContext,
         apiClient: APIProviding,
         alertView: AlertShowing,
         commentPresenter: CommentControllerPresenting) {
        self.voteContext = voteContext
        self.apiClient = apiClient
        self.alertPresenter = alertView
        self.commentPresenter = commentPresenter

        super.init(nibName: nil, bundle: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func loadView() {
        view = AnswerView()
    }

    var answerView: AnswerView { return forceCast(view) }

    override func viewDidLoad() {
        super.viewDidLoad()

        answerView.onChatButtonTapped = { [weak self] in self?.didTapChat() }
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

        apiClient.vote(authToken: authToken, answer: answer)
            .then { [weak self] answer -> Void in
                self?.answerView.selectAnswer(type: answer.type)
            }.catch { [weak self] error in
                presentError(error, in: self)
            }.always { [weak self] in
                self?.answerView.cancelAnimations()
                self?.answerView.enabled = true
            }
    }

    private func didTapChat() {
        commentPresenter.present(in: self, with: voteContext)
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
