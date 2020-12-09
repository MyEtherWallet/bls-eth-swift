ARCHIVES=archives
PROJECT_NAME=bls_framework
FRAMEWORK_NAME=${PROJECT_NAME}.framework
XCFRAMEWORK_NAME=${PROJECT_NAME}.xcframework
XCFRAMEWORKZIP_NAME=${PROJECT_NAME}.xcframework.zip
SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
BUILD_PATH=`dirname $SCRIPT`

echo "Preparing mcl..."
echo "Applying patch"
$(cd Sources/mcl && git reset --hard && git apply ../../patches/mcl.patch.diff)

echo "Preparing bls..."
echo "Applying patch"
$(cd Sources/bls && git reset --hard && git apply ../../patches/bls.patch.diff)

BUILD_MATRIX_WIDTH=5
buildmatrix=()
#               PLATFORM            PLATFORM_EXTRAS     ARCH      EXCLUDED_ARCHS    BCMAPS_INCLUDED
#iOS Simulator
#buildmatrix+=("iOS Simulator"       ""                  "x32"     "arm64 x86_64"    false) #Use in case if you need 32bit-support
buildmatrix+=("iOS Simulator"       ""                  "x64"     "i386"            false)
#iOS
buildmatrix+=("iOS"                 ""                  "x64"     "armv7"           true)
#buildmatrix+=("iOS"                 ""                  "x32"     "arm64"           true) #Use in case if you need 32bit-support
#macOS
buildmatrix+=("macOS"               ""                  "x64"     ""                false)
#watchOS
buildmatrix+=("watchOS"             ""                  "x64"     "armv7k"          true)
#buildmatrix+=("watchOS"             ""                  "x32"     "arm64_32"        true) #Use in case if you need 32bit-support
#watchOS Simulator
buildmatrix+=("watchOS Simulator"   ""                  "x64"     ""                false)
#tvOS
buildmatrix+=("tvOS"                ""                  "x64"     ""                true)
#tvOS Simulator
buildmatrix+=("tvOS Simulator"      ""                  "x64"     ""                false)

count=$((${#buildmatrix[@]}/$BUILD_MATRIX_WIDTH))

i="0"

FRAMEWORKS=""

rm -r ${ARCHIVES}

while [ $i -lt ${count} ]
  do
    PLATFORM=${buildmatrix[$(($i*$BUILD_MATRIX_WIDTH))]}
    PLATFORM_EXTRAS=${buildmatrix[$(($i*$BUILD_MATRIX_WIDTH+1))]}
    ARCH=${buildmatrix[$(($i*$BUILD_MATRIX_WIDTH+2))]}
    EXCLUDED_ARCHS=${buildmatrix[$(($i*$BUILD_MATRIX_WIDTH+3))]}
    BCMAPS_INCLUDED=${buildmatrix[$(($i*$BUILD_MATRIX_WIDTH+4))]}

    ARCHIVE_NAME="$(printf %q ${PLATFORM})-${ARCH}"
    ARCHIVE_PATH_WO_EXTENSION="${ARCHIVES}/${ARCHIVE_NAME}"
    ARCHIVE_PATH=${ARCHIVE_PATH_WO_EXTENSION}.xcarchive
    
    # To make an XCFramework, we first build the framework for every type seperately
    echo "XCFramework: Archiving ${PLATFORM}..."

    xcodebuild archive -project ${PROJECT_NAME}.xcodeproj -scheme ${PROJECT_NAME} -destination "generic/platform=${PLATFORM}${PLATFORM_EXTRAS}" -archivePath ${ARCHIVE_PATH_WO_EXTENSION} SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES EXCLUDED_ARCHS="${EXCLUDED_ARCHS}" -configuration Release-${ARCH}

    echo "XCFramework: Generating ${PLATFORM} BCSymbolMap paths..."
    
    FRAMEWORK_PATH=${ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}
    DSYMS_PATH=${BUILD_PATH}/${ARCHIVE_PATH}/dSYMs/${FRAMEWORK_NAME}.dSYM
    echo ${BUILD_PATH}
    
    if $BCMAPS_INCLUDED ; then
      BCSYMBOLMAP_PATHS=(${ARCHIVE_PATH}/BCSymbolMaps/*)
      BCSYMBOLMAP_COMMANDS=""
      for path in "${BCSYMBOLMAP_PATHS[@]}"; do
        BCSYMBOLMAP_COMMANDS="$BCSYMBOLMAP_COMMANDS -debug-symbols $BUILD_PATH/$path "
      done
      FRAMEWORKS+="-framework ${FRAMEWORK_PATH} -debug-symbols ${DSYMS_PATH} ${BCSYMBOLMAP_COMMANDS} "
    else
      FRAMEWORKS+="-framework ${FRAMEWORK_PATH} -debug-symbols ${DSYMS_PATH} "
    fi
    
    i=$[$i+1]
done

echo "Reverting mcl..."
$(cd Sources/mcl && git reset --hard)

echo "Reverting bls..."
$(cd Sources/bls && git reset --hard)

rm -r ${XCFRAMEWORK_NAME}
xcodebuild -create-xcframework ${FRAMEWORKS} -output ${XCFRAMEWORK_NAME}

XCFRAMEWORKZIP_PATH=../${XCFRAMEWORKZIP_NAME}
rm -r ${XCFRAMEWORKZIP_PATH}
zip -vr ${XCFRAMEWORKZIP_PATH} ${XCFRAMEWORK_NAME} -x "*.DS_Store"
echo "XCFFramework checksum: " $(swift package compute-checksum ${XCFRAMEWORKZIP_PATH})

open ${BUILD_PATH}
