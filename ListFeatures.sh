#!/bin/bash

# List Swift language features the compiler knows about.
#
# Usage:
#
#     swift-list-features [version]     # default: main branch
#
# Examples:
#
#     swift-list-features               # Queries main branch
#     swift-list-features 5.9           # Queries release/5.9 branch
#
# This script uses curl to download the file in which the language features
# are defined from the Swift repo and uses Clang to parse it.
#
# Original author: Gor Gyolchanyan
# <https://forums.swift.org/t/how-to-test-if-swiftc-supports-an-upcoming-experimental-feature/69095/10>
#
# Enhanced/modified by: Ole Begemann

swift_version=$1

if test -z "$swift_version" || test "$swift_version" = "main"; then
  branch="main"
else
  branch="release/${swift_version}"
fi

GITHUB_URL="https://raw.githubusercontent.com/apple/swift/${branch}/include/swift/Basic/Features.def"
FEATURES_DEF_FILE="$(curl --fail-with-body --silent "${GITHUB_URL}")"
curlStatus=$?
if test $curlStatus -ne 0; then
    echo "$FEATURES_DEF_FILE"
    echo "Error: failed to download '$GITHUB_URL'. Invalid URL?"
    exit $curlStatus
fi

echo "Swift language features in $branch"
echo "======================================"
clang --preprocess --no-line-commands -nostdinc -x c - <<EOF | sort
    #define LANGUAGE_FEATURE(FeatureName, SENumber, Description, ...) FeatureName
    #define UPCOMING_FEATURE(FeatureName, SENumber, Version)   [Upcoming] FeatureName (Swift Version)
    #define EXPERIMENTAL_FEATURE(FeatureName, AvailableInProd) [Experimental] FeatureName
    ${FEATURES_DEF_FILE}
EOF