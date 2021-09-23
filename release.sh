#!/usr/bin/env bash
# This script builds and packages the project for release
# Lint with https://www.shellcheck.net/ when making changes
set -Eeuo pipefail

if [[ -d "build" ]]; then
  echo -e "\nRemoving existing build folder"
  rm -rfv "build"
fi

echo -e "\nBuilding the frameworks for distribution"
echo -e "\nBuilding iOS Device"
xcodebuild clean archive -project SLRDNSConfigurator.xcodeproj -scheme SLRDNSConfigurator -configuration Release -destination generic/platform=iOS -sdk iphoneos -archivePath build/archives/ios.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES ENABLE_BITCODE=YES
echo -e "\nBuilding iOS Simulator"
xcodebuild clean archive -project SLRDNSConfigurator.xcodeproj -scheme SLRDNSConfigurator -configuration Release -destination generic/platform=iOS\ Simulator -sdk iphonesimulator -archivePath build/archives/ios-sim.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
echo -e "\nBuilding Mac Catalyst"
xcodebuild clean archive -project SLRDNSConfigurator.xcodeproj -scheme SLRDNSConfigurator -configuration Release -destination 'platform=macOS,variant=Mac Catalyst' -archivePath build/archives/ios-cat.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
echo -e "\nBuilding macOS"
xcodebuild clean archive -project SLRDNSConfigurator.xcodeproj -scheme SLRDNSConfigurator -configuration Release -archivePath build/archives/mac.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
echo -e "\nBuilding tvOS Device"
xcodebuild clean archive -project SLRDNSConfigurator.xcodeproj -scheme SLRDNSConfigurator -configuration Release -destination generic/platform=tvOS -archivePath build/archives/tvos.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES ENABLE_BITCODE=YES
echo -e "\nBuilding tvOS Simulator"
xcodebuild clean archive -project SLRDNSConfigurator.xcodeproj -scheme SLRDNSConfigurator -configuration Release -destination generic/platform=tvOS\ Simulator -archivePath build/archives/tvos-sim.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
echo -e "\nBuilding watchOS Device"
xcodebuild clean archive -project SLRDNSConfigurator.xcodeproj -scheme SLRDNSConfigurator -configuration Release -destination generic/platform=watchOS -archivePath build/archives/watchos.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES ENABLE_BITCODE=YES
echo -e "\nBuilding watchOS Simulator"
xcodebuild clean archive -project SLRDNSConfigurator.xcodeproj -scheme SLRDNSConfigurator -configuration Release -destination generic/platform=watchOS\ Simulator -archivePath build/archives/watchos-sim.xcarchive SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

iOSBCMaps=()
tvBCMaps=()
watchBCMaps=()

echo -e "\nFinding iOS Bitcode Symbol Maps"
while IFS= read -d '' -r filename; do
    iOSBCMaps+=("$filename")
done < <(find "$(pwd -P)"/build/archives -path "*ios*" -name "*.bcsymbolmap" -print0)

echo -e "\nFinding tvOS Bitcode Symbol Maps"
while IFS= read -d '' -r filename; do
    tvBCMaps+=("$filename")
done < <(find "$(pwd -P)"/build/archives -path "*tv*" -name "*.bcsymbolmap" -print0)

echo -e "\nFinding watchOS Bitcode Symbol Maps"
while IFS= read -d '' -r filename; do
    watchBCMaps+=("$filename")
done < <(find "$(pwd -P)"/build/archives -path "*watch*" -name "*.bcsymbolmap" -print0)

set +u
iOSBCMapCount=${#iOSBCMaps[@]}
tvBCMapCount=${#tvBCMaps[@]}
watchBCMapCount=${#watchBCMaps[@]}
set -u

iOSDebugSymbols=""
tvDebugSymbols=""
watchDebugSymbols=""

echo -e "\nGenerating iOS Bitcode Symbol Map command"
for ((i=0;i<iOSBCMapCount;i++)); do
  iOSDebugSymbols+=" -debug-symbols ${iOSBCMaps[i]}"
done

echo -e "\nGenerating tvOS Bitcode Symbol Map command"
for ((i=0;i<tvBCMapCount;i++)); do
  tvDebugSymbols+=" -debug-symbols ${tvBCMaps[i]}"
done

echo -e "\nGenerating watchOS Bitcode Symbol Map command"
for ((i=0;i<watchBCMapCount;i++)); do
  watchDebugSymbols+=" -debug-symbols ${watchBCMaps[i]}"
done

echo -e "\nCreating XCFramework"
# shellcheck disable=SC2086
xcodebuild -create-xcframework -framework build/archives/ios.xcarchive/Products/Library/Frameworks/SLRDNSConfigurator.framework \
-debug-symbols "$(pwd -P)"/build/archives/ios.xcarchive/dSYMs/SLRDNSConfigurator.framework.dSYM \
$iOSDebugSymbols \
-framework build/archives/ios-sim.xcarchive/Products/Library/Frameworks/SLRDNSConfigurator.framework \
-debug-symbols "$(pwd -P)"/build/archives/ios-sim.xcarchive/dSYMs/SLRDNSConfigurator.framework.dSYM \
-framework build/archives/ios-cat.xcarchive/Products/Library/Frameworks/SLRDNSConfigurator.framework \
-debug-symbols "$(pwd -P)"/build/archives/ios-cat.xcarchive/dSYMs/SLRDNSConfigurator.framework.dSYM \
-framework build/archives/mac.xcarchive/Products/Library/Frameworks/SLRDNSConfigurator.framework \
-debug-symbols "$(pwd -P)"/build/archives/mac.xcarchive/dSYMs/SLRDNSConfigurator.framework.dSYM \
-framework build/archives/tvos.xcarchive/Products/Library/Frameworks/SLRDNSConfigurator.framework \
-debug-symbols "$(pwd -P)"/build/archives/tvos.xcarchive/dSYMs/SLRDNSConfigurator.framework.dSYM \
$tvDebugSymbols \
-framework build/archives/tvos-sim.xcarchive/Products/Library/Frameworks/SLRDNSConfigurator.framework \
-debug-symbols "$(pwd -P)"/build/archives/tvos-sim.xcarchive/dSYMs/SLRDNSConfigurator.framework.dSYM \
-framework build/archives/watchos.xcarchive/Products/Library/Frameworks/SLRDNSConfigurator.framework \
-debug-symbols "$(pwd -P)"/build/archives/watchos.xcarchive/dSYMs/SLRDNSConfigurator.framework.dSYM \
$watchDebugSymbols \
-framework build/archives/watchos-sim.xcarchive/Products/Library/Frameworks/SLRDNSConfigurator.framework \
-debug-symbols "$(pwd -P)"/build/archives/watchos-sim.xcarchive/dSYMs/SLRDNSConfigurator.framework.dSYM \
-output build/framework/SLRDNSConfigurator.xcframework

echo -e "\nCreating ZIP archive"
rootDirectory="$PWD"
cd build/framework/
zip -r -o SLRDNSConfigurator.zip .
mv SLRDNSConfigurator.zip "$rootDirectory"
cd "$rootDirectory"

echo -e "\nRelease Complete"
