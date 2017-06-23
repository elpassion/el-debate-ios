//
//  Created by Jakub Turek on 23.06.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

@testable import ELDebateFramework
import Nimble
import Quick
import Swinject

internal class ControllerFactorySpec: QuickSpec {

    override func spec() {
        describe("ControllerFactory") {
            var sut: ControllerFactory!

            beforeEach {
                let assembler = Assembler.defaultAssembler
                sut = ControllerFactory(resolver: assembler.resolver)
            }

            it("should build pin entry view controller") {
                let controller = sut.makeController(of: .pinEntry)

                expect(controller).to(beAKindOf(PinEntryViewController.self))
            }

            it("should build answer view controller passing vote context") {
                let type = ControllerType.answer(voteContext: VoteContext.testDefault)

                let controller = sut.makeController(of: type) as? AnswerViewController

                expect(controller).toNot(beNil())
                expect(controller?.voteContext.authToken) == VoteContext.testDefault.authToken
                expect(controller?.voteContext.debate.topic) == VoteContext.testDefault.debate.topic
                expect(controller?.voteContext.username) == VoteContext.testDefault.username
            }

            it("should build comment controller passing vote context") {
                let type = ControllerType.comment(voteContext: VoteContext.testDefault)

                let controller = sut.makeController(of: type) as? CommentController

                expect(controller).toNot(beNil())
                expect(controller?.voteContext.authToken) == VoteContext.testDefault.authToken
                expect(controller?.voteContext.debate.topic) == VoteContext.testDefault.debate.topic
                expect(controller?.voteContext.username) == VoteContext.testDefault.username
            }
        }
    }

}
