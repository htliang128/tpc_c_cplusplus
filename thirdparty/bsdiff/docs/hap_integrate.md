# bsdiff集成到应用hap
本库是在RK3568开发板上基于OpenHarmony3.2 Release版本的镜像验证的，如果是从未使用过RK3568，可以先查看[润和RK3568开发板标准系统快速上手](https://gitee.com/openharmony-sig/knowledge_demo_temp/tree/master/docs/rk3568_helloworld)。
## 开发环境
- ubuntu20.04
- [OpenHarmony3.2Release镜像](https://gitee.com/link?target=https%3A%2F%2Frepo.huaweicloud.com%2Fopenharmony%2Fos%2F3.2-Release%2Fdayu200_standard_arm32.tar.gz)
- [ohos_sdk_public 4.0.8.1 (API Version 10 Release)](http://download.ci.openharmony.cn/version/Master_Version/OpenHarmony_4.0.8.1/20230608_091016/version-Master_Version-OpenHarmony_4.0.8.1-20230608_091016-ohos-sdk-full.tar.gz)
- [DevEco Studio 3.1 Release](https://contentcenter-vali-drcn.dbankcdn.cn/pvt_2/DeveloperAlliance_package_901_9/81/v3/tgRUB84wR72nTfE8Ir_xMw/devecostudio-windows-3.1.0.501.zip?HW-CC-KV=V1&HW-CC-Date=20230621T074329Z&HW-CC-Expire=315360000&HW-CC-Sign=22F6787DF6093ECB4D4E08F9379B114280E1F65DA710599E48EA38CB24F3DBF2)
- [准备三方库构建环境](../../../lycium/README.md#1编译环境准备)
- [准备三方库测试环境](../../../lycium/README.md#3ci环境准备)
## 编译三方库
- 下载本仓库
  ```
  git clone https://gitee.com/openharmony-sig/tpc_c_cplusplus.git --depth=1
  ```
  
- 三方库目录结构
  ```
  tpc_c_cplusplus/thirdparty/bsdiff     #三方库bsdiff的目录结构如下
  ├── HPKBUILD                          #构建脚本
  ├── HPKCHECK                          #自动化测试脚本
  ├── SHA512SUM                         #三方库校验文件
  |-- BUILD.gn            			  # Rom版编译构建脚本
  |-- export_api.txt       			  # bsdiff库对外导出的api接口
  |-- tested_api.txt      			  # 测试用例已测试的api接口
  |-- bundle.json         			  # 组件定义文件
  |-- README_zh.md        			  # bsdiff 说明文档
  |-- README.OpenSource   			  # bsdiff 开源信息说明文档
  |-- docs                			  # 存放bsdiff相关文档
  |-- bsdiff_oh_pkg.patch 			  # 存放bsdiff库patch文件
  |-- media               			  # 存放图片的文件夹
  |-- testdata            			  # 存放测试数据
      |-- run_test.sh     			  # 测试用例运行脚本，注意：在运行该测试用例时，需要将做拆分与合并的2个测试应用程序放到当前路径下。
      |-- note.txt        			  # 测试用例文件
      |-- note_new.txt    			  # 测试用例新文件，与之前文件存在差异，通过测试用例做拆分与合并，最终生成一个新的文件与该文件一致。
  ```
  
- 在tpc_c_cplusplus/lycium目录下编译三方库
  编译环境的搭建参考[准备三方库构建环境](../../../lycium/README.md#1编译环境准备)
  
  ```
  ./build.sh bzip2 bsdiff
  ```
  
- 三方库头文件及生成的库
  在tpc_c_cplusplus/lycium/目录下会生成usr目录，该目录下存在已编译完成的32位和64位三方库
  
  ```
  bsdiff/arm64-v8a   bsdiff/armeabi-v7a  bzip2/arm64-v8a   bzip2/armeabi-v7a
  ```
  
- [测试三方库](#测试三方库)

## 应用中使用三方库
- 在IDE的cpp目录下新增thirdparty目录，将编译生成的库拷贝到该目录下，如下图所示
  &nbsp;![thirdparty_install_dir](pic/bsdiff_install_dir.png)
- 在最外层（cpp目录下）CMakeLists.txt中添加如下语句
  ```
  #将三方库加入工程中
  target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/bsdiff/${OHOS_ARCH}/lib/libbsdiff_bspatch.a)
  target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/bzip2/${OHOS_ARCH}/lib/libbz2.a)
  
  #将三方库的头文件加入工程中
  target_include_directories(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/bsdiff/${OHOS_ARCH}/include)
  target_include_directories(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/bzip2/${OHOS_ARCH}/include)
  
  ```
  ![jbigkit_usage](pic/bsdiff_usage.png)

## 测试三方库
三方库的测试使用原库自带的测试用例来做测试，[准备三方库测试环境](../../../lycium/README.md#3ci环境准备)

拷贝整个tpc仓库，进入到lycium目录执行./check.sh运行测试用例

&nbsp;![jbigkit_test](pic/bsdiff_test.png)

## 参考资料
- [润和RK3568开发板标准系统快速上手](https://gitee.com/openharmony-sig/knowledge_demo_temp/tree/master/docs/rk3568_helloworld)
- [OpenHarmony三方库地址](https://gitee.com/openharmony-tpc)
- [OpenHarmony知识体系](https://gitee.com/openharmony-sig/knowledge)
- [通过DevEco Studio开发一个NAPI工程](https://gitee.com/openharmony-sig/knowledge_demo_temp/blob/master/docs/napi_study/docs/hello_napi.md)
