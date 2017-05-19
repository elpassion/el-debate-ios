//
//  Created by Jakub Turek on 12.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import Anchorage
import UIKit

class AnswerViewController: UIViewController, AnswerControllerProviding {

    private var answerView: AnswerView {
        guard let answerView = view as? AnswerView else {
            fatalError("Failed casting UIView to AnswerView")
        }

        return answerView
    }

    private let yearCalculator: CurrentYearCalculating
    private let voteContext: VoteContext
    private let answerViewPresenter: AnswerViewPresenter
    private let apiClient: APIProviding
    private let alertView: AlertShowing

    var onCommentButtonTapped: ((String) -> Void)?

    // MARK: - Initializer

    init(yearCalculator: CurrentYearCalculating, voteContext: VoteContext,
         answerViewPresenter: AnswerViewPresenter, apiClient: APIProviding, alertView: AlertShowing) {
        self.yearCalculator = yearCalculator
        self.voteContext = voteContext
        self.answerViewPresenter = answerViewPresenter
        self.apiClient = apiClient
        self.alertView = alertView

        super.init(nibName: nil, bundle: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func loadView() {
        view = AnswerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        answerView.onCommentButtonTapped = { [weak self] in
            guard let `self` = self else { return }
            self.onCommentButtonTapped?(self.voteContext.authToken)
        }

        title = "EL Debate \(yearCalculator.year)"

        answerView.onAnswerSelected = { [weak self] answerType in
            guard let `self` = self else { return }
            self.apiClient.vote(
                authToken: self.voteContext.authToken,
                answer: self.voteContext.answer(for: answerType)
            ).then { [weak self] answer -> Void in
                self?.answerView.selectAnswer(type: answer.type)
            }.catch { [weak self] _ in
                guard let `self` = self else { return }
                self.alertView.show(in: self, title: "Error", message: "There was a problem submitting your vote")
            }.always { [weak self] in
                self?.answerView.stopSpinners()
            }
        }

        answerViewPresenter.present(debate: self.voteContext.debate, answerView: self.answerView)
    }

    // MARK: - ControllerProviding

    var controller: UIViewController { return self }

    // MARK: - Required initializer

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
