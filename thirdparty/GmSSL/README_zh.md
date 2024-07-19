# GmSSL三方库说明
## 功能简介
GmSSL是支持国密算法和标准的 [OpenSSL](http://www.oschina.net/p/openssl) 分支，增加了对国密 SM2/SM3/SM4 算法和 ECIES、CPK、ZUC 算法的支持，实现了这些算法与 EVP API 和命令行工具的集成.

## 使用约束
- IDE版本：

  DevEco Studio 3.1 Release

  DevEco Studio 4.0.3.500

- SDK版本：

  ohos_sdk_public 4.0.8.1 (API Version 10 Release)

  ohos_sdk_public 4.0.10.7 (API Version 10 Release)

- 三方库版本：v3.1.0

- 当前适配的功能：支持国密 SM2/SM3/SM4 算法和 ECIES、CPK、ZUC 算法

## 集成方式
+ [应用hap包集成](docs/hap_integrate.md)
