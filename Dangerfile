APP_DIR = 'Sources'
TESTS_DIR = 'Tests'
TEST_SCHEME = 'ELDebate'
XC_WORKSPACE = 'ELDebate.xcworkspace'
BASE_PATH = Dir.pwd

# Start message
start_time = Time.now
message("#{`whoami`.strip} started Danger at #{start_time}")

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress", sticky: true) if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR", sticky: true) if git.lines_of_code > 300

# Only accept prs to the master branch
fail("Please re-submit this PR to master.", sticky: true) if github.branch_for_base != "master"

# Ensure that all prs have and assignee
warn("This PR does not have any assignees yet.", sticky: true) unless github.pr_json["assignee"]

# Check for WIP leftovers in tests
fail("`fit` found in tests", sticky: true) if `grep -rI "fit(" #{TESTS_DIR}/`.length > 1
fail("`fdescribe` found in tests", sticky: true) if `grep -r fdescribe #{TESTS_DIR}/`.length > 1
fail("`fcontext` found in tests", sticky: true) if `grep -r fcontext #{TESTS_DIR}/`.length > 1
fail("`xit` left in tests", sticky: true) if `grep -rI "xit(" #{TESTS_DIR}/`.length > 1
fail("`xdescribe` left in tests", sticky: true) if `grep -r xdescribe #{TESTS_DIR}/`.length > 1
fail("`xcontext` left in tests", sticky: true) if `grep -r xcontext #{TESTS_DIR}/`.length > 1
fail("`recordMode = true` found in snapshot tests", sticky: true) if `grep -r "recordMode = true" #{TESTS_DIR}/` .length > 1
fail("`recordSnapshot()` found in snapshot tests", sticky: true) if `grep -r "recordSnapshot()" #{TESTS_DIR}/` .length > 1
fail("`recordDeviceAgnosticSnapshot()` found in snapshot tests", sticky: true) if `grep -r "recordDeviceAgnosticSnapshot()" #{TESTS_DIR}/` .length > 1

# Run SwiftLint on new or modified files
app_path = File.join(BASE_PATH, APP_DIR)
test_path = File.join(BASE_PATH, TESTS_DIR)
files = (git.added_files + git.modified_files).map { |path| File.join(BASE_PATH, path) }
app_files = files.select { |path| path.start_with?(app_path + '/') }
test_files = files.select { |path| path.start_with?(test_path + '/') }
swiftlint.directory = app_path
swiftlint.lint_files(app_files, inline_mode: false)
swiftlint.directory = test_path
swiftlint.lint_files(test_files, inline_mode: false)

# Generate code ceoverage report
xcov.report(
  workspace: File.join(BASE_PATH, XC_WORKSPACE),
  scheme: TEST_SCHEME,
  only_project_targets: true,
  ignore_file_path: File.join(BASE_PATH, '.xcovignore'),
  minimum_coverage_percentage: 75.0
)

# Done message
seconds_elapsed = ((Time.now - start_time) * 1000.0).to_i / 1000.0
message("Danger finished after #{seconds_elapsed}s")