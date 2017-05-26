//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class AnswerViewController: UIViewController, AnswerControllerProviding, AlertPresentingController {

    private let yearCalculator: CurrentYearCalculating
    private let voteContext: VoteContext
    private let apiClient: APIProviding
    let alertPresenter: AlertShowing

    var onCommentButtonTapped: ((String) -> Void)?

    // MARK: - Initializer

    init(yearCalculator: CurrentYearCalculating, voteContext: VoteContext,
         apiClient: APIProviding, alertView: AlertShowing) {
        self.yearCalculator = yearCalculator
        self.voteContext = voteContext
        self.apiClient = apiClient
        self.alertPresenter = alertView

        super.init(nibName: nil, bundle: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func loadView() {
        view = AnswerView()
    }

    private var answerView: AnswerView { return forceCast(view) }

    override func viewDidLoad() {
        super.viewDidLoad()

        answerView.onCommentButtonTapped = { [weak self] in self?.didTapComment() }
        answerView.onAnswerSelected = { [weak self] in self?.didSelectAnswer(with: $0) }

        title = "EL Debate \(yearCalculator.year)"

        let debate = voteContext.debate
        answerView.config(
            debateTitle: debate.topic,
            yesAnswerText: debate.positiveAnswer.value,
            undecidedAnswerText: debate.neutralAnswer.value,
            noAnswerText: debate.negativeAnswer.value
        )
    }

    private func didSelectAnswer(with answerType: AnswerType) {
        let authToken = voteContext.authToken
        let answer = voteContext.answer(for: answerType)

        apiClient.vote(authToken: authToken, answer: answer)
            .then { [weak self] answer -> Void in
                self?.answerView.selectAnswer(type: answer.type)
            }.catch { [weak self] _ in
                presentAlert(in: self, title: "Error", message: "There was a problem submitting your vote")
            }.always { [weak self] in
                self?.answerView.stopSpinners()
            }
    }

    private func didTapComment() {
        onCommentButtonTapped?(voteContext.authToken)
    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
