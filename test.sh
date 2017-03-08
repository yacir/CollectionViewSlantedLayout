#! /bin/bash
TEST_CMD="xcodebuild analyze build test -workspace YBSlantedCollectionViewLayout.xcworkspace -scheme YBSlantedCollectionViewLayout -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 7' GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES"

which -s xcpretty
XCPRETTY_INSTALLED=$?

if [[ $TRAVIS || $XCPRETTY_INSTALLED == 0 ]]; then
  eval "${TEST_CMD} | xcpretty"
else
  eval "$TEST_CMD"
fi

pod lib lint --quick