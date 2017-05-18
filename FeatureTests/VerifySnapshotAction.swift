//
//  Created by Jakub Turek on 18.05.2017.
//  Copyright © 2017 EL Passion. All rights reserved.
//

import EarlGrey
import FBSnapshotTestCase
import PySwiftyRegex

func grey_verifySnapshot(_ testName: String?) -> GREYActionBlock {
    return grey_fbSnapshotTest(testName: testName, recordMode: false)
}

func grey_recordSnapshot(_ testName: String?) -> GREYActionBlock {
    return grey_fbSnapshotTest(testName: testName, recordMode: true)
}

private func grey_fbSnapshotTest(testName: String?, recordMode: Bool) -> GREYActionBlock {
    guard let testName = testName else { fatalError("Invalid nil test name passed") }
    let parsedTestName = parse(testName: testName)

    return grey_fbSnapshotTest(testName: parsedTestName.testClassName,
                               snapshot: parsedTestName.testMethodName,
                               recordMode: recordMode)
}

private func grey_fbSnapshotTest(testName: String, snapshot: String, recordMode: Bool) -> GREYActionBlock {
    return GREYActionBlock.action(withName: "verify snapshot", perform: { element, errorOrNil -> Bool in
        guard let view = element as? UIView else { return false }

        let testController: FBSnapshotTestController = FBSnapshotTestController(testName: testName)
        testController.isDeviceAgnostic = true
        testController.recordMode = recordMode
        testController.usesDrawViewHierarchyInRect = false
        testController.referenceImagesDirectory = ProcessInfo.processInfo.environment["FB_REFERENCE_IMAGE_DIR"]

        do {
            try testController.compareSnapshot(ofViewOrLayer: view,
                                               selector: Selector(snapshot),
                                               identifier: nil,
                                               tolerance: 0.0)
        } catch let error as NSError {
            errorOrNil?.pointee = error
        }

        if recordMode {
            errorOrNil?.pointee = NSError(domain: "GREYFBSnapshotErrorDomain", code: 1, userInfo: [
                NSLocalizedFailureReasonErrorKey: "Image recorded successfully, replace with grey_verifySnapshot()"
            ])
        }

        return errorOrNil?.pointee == nil
    })
}

private func parse(testName: String) -> TestName {
    guard let match = re.search("-\\[(\\w+)\\s+(\\w+)\\]", testName) else {
        fatalError("Could not parse regular expression for test case name")
    }
    guard let testClassName = match.group(1) else { fatalError("Could not extract test file name") }
    guard let testMethodName = match.group(2) else { fatalError("Could not extract test method name") }

    return TestName(testClassName: testClassName, testMethodName: testMethodName)
}

struct TestName {

    let testClassName: String
    let testMethodName: String

}
