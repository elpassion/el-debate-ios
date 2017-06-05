import UIKit
import PlaygroundSupport
import ELDebateFramework
import Swinject

let resolver = Assembler.defaultAssembler.resolver
let controllerFactory = ControllerFactory(resolver: resolver)
let pinEntryProvider = controllerFactory.makeController(of: .pinEntry)

PlaygroundPage.current.liveView = playgroundWrapper(
    child: pinEntryProvider.controller,
    device: .phone4inch,
    orientation: .portrait)
