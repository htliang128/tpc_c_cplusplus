#!/bin/bash

# 文件列表
files=(
    "resip/stack/test/testApplicationSip"
    "resip/stack/test/testCorruption"
    "resip/stack/test/testConnectionBase"
    "resip/stack/test/testEmptyHeader"
    "resip/stack/test/testEmbedded"
    "resip/stack/test/testPksc7"
    "resip/stack/test/testMultipartMixedContents"
    "resip/stack/test/testMessageWaiting"
    "resip/stack/test/testRlmi"
    "resip/stack/test/testIM"
    "resip/stack/test/testMultipartRelated"
    "resip/stack/test/testSdp"
    "resip/stack/test/testDtmfPayload"
    "resip/stack/test/testPidf"
    "resip/stack/test/testDialogInfoContents"
    "resip/stack/test/testGenericPidfContents"
    "resip/stack/test/testSipFrag"
    "resip/stack/test/testPlainContents"
    "resip/stack/test/testSipMessage"
    "resip/stack/test/testTuple"
    "resip/stack/test/testTime"
    "resip/stack/test/testUri"
    "resip/stack/test/testSipMessageMemory"
    "resip/stack/test/testWsCookieContext"
    "resip/stack/test/testParserCategories"
    "resip/stack/test/testStack"
    "resip/stack/test/testAppTimer"
    "resip/stack/test/testTcp"
    "resip/stack/test/testDigestAuthentication"
    "resip/stack/test/testSelectInterruptor"
    "resip/stack/test/testExternalLogger"
    "resip/stack/test/testTimer"
    "resip/dum/test/basicRegister"
    "resip/dum/test/basicMessage"
    "resip/dum/test/testContactInstanceRecord"
    "resip/dum/test/testPubDocument"
    "resip/dum/test/testRequestValidationHandler"
    "resip/dum/test/BasicCall"
    "rutil/test/testCompat"
    "rutil/test/testCoders"
    "rutil/test/testConfigParse"
    "rutil/test/testCountStream"
    "rutil/test/testData"
    "rutil/test/testDataPerformance"
    "rutil/test/testDataStream"
    "rutil/test/testDnsUtil"
    "rutil/test/testFifo"
    "rutil/test/testFileSystem"
    "rutil/test/testInserter"
    "rutil/test/testIntrusiveList"
    "rutil/test/testLogger"
    "rutil/test/testMD5Stream"
    "rutil/test/testNetNs"
    "rutil/test/testParseBuffer"
    "rutil/test/testRandomHex"
    "rutil/test/testRandomThread"
    "rutil/test/testSHA1Stream"
    "rutil/test/testThreadIf"
    "rutil/test/testXMLCursor"
)

# 循环遍历每个文件并替换内容
for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    sed -i 's|/usr/bin/sed|/bin/sed|g' "$file"
    echo "Processed $file"
  else
    echo "File $file not found"
  fi
done