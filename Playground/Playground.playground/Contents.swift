import UIKit
import PlaygroundSupport
import ELDebateFramework
import Swinject

let device: Device = .phone4inch
let orientation: Orientation = .portrait

Display.bounds = CGRect(origin: .zero, size: size(for: device, and: orientation))

let resolver = Assembler.defaultAssembler.resolver
let controllerFactory = ControllerFactory(resolver: resolver)
let pinEntryProvider = controllerFactory.makeController(of: .pinEntry)

let controller = playgroundWrapper(child: pinEntryProvider.controller,
                                   device: device,
                                   orientation: orientation)

PlaygroundPage.current.liveView = controller
