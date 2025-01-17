# oneDNN集成到应用hap

本库是在RK3568开发板上基于OpenHarmony3.2 Release版本的镜像验证的，如果是从未使用过RK3568，可以先查看[润和RK3568开发板标准系统快速上手](https://gitee.com/openharmony-sig/knowledge_demo_temp/tree/master/docs/rk3568_helloworld)。

## 开发环境

- ubuntu20.04
- [OpenHarmony3.2Release镜像](https://gitee.com/link?target=https%3A%2F%2Frepo.huaweicloud.com%2Fopenharmony%2Fos%2F3.2-Release%2Fdayu200_standard_arm32.tar.gz)
- [ohos_sdk_public 4.0.8.1 (API Version 10 Release)](https://gitee.com/link?target=http%3A%2F%2Fdownload.ci.openharmony.cn%2Fversion%2FMaster_Version%2FOpenHarmony_4.0.8.1%2F20230608_091058%2Fversion-Master_Version-OpenHarmony_4.0.8.1-20230608_091058-ohos-sdk-public.tar.gz)
- [DevEco Studio 3.1 Release](https://gitee.com/link?target=https%3A%2F%2Fcontentcenter-vali-drcn.dbankcdn.cn%2Fpvt_2%2FDeveloperAlliance_package_901_9%2F81%2Fv3%2FtgRUB84wR72nTfE8Ir_xMw%2Fdevecostudio-windows-3.1.0.501.zip%3FHW-CC-KV%3DV1%26HW-CC-Date%3D20230621T074329Z%26HW-CC-Expire%3D315360000%26HW-CC-Sign%3D22F6787DF6093ECB4D4E08F9379B114280E1F65DA710599E48EA38CB24F3DBF2)
- [准备三方库构建环境](../../../tools/README.md#编译环境准备)
- [准备三方库测试环境](../../../tools/README.md#ci环境准备)

## 编译三方库

- 下载本仓库

  ```shell
  git clone https://gitee.com/openharmony-sig/tpc_c_cplusplus.git --depth=1
  ```

- 三方库目录结构

  ```shell
  tpc_c_cplusplus/thirdparty/oneDNN     #三方库avrocpp的目录结构如下
  ├── docs                              #三方库相关文档的文件夹
  ├── HPKBUILD                          #构建脚本
  ├── SHA512SUM                         #三方库校验文件
  ├── oneDNN_oh_pkg.patch               #PATCH 文件
  ├── README.OpenSource                 #说明三方库源码的下载地址，版本，license等信息
  ├── README_zh.md   
  ```

- 将oneDNN拷贝至tools/main目录下

  拷贝前要如果tools下没有main目录，需要自己创建。

  ```shell
  cd tpc_c_cplusplus
  cp -rf thirdparty/oneDNN tools/main
  ```
  oneDNN依赖openmp, 需要把openmp也拷贝到tools/main 下。

  编译环境的搭建参考[准备三方库构建环境](../../../tools/README.md#编译环境准备)

  ```shell
  cd tools
  ./build.sh oneDNN openmp
  ```

- 三方库头文件及生成的库

  在tools目录下会生成usr目录，该目录下存在已编译完成64位三方库

  ```shell
  oneDNN/arm64-v8a
  ```
- [测试三方库](#测试三方库)

## 应用中使用三方库

- 在IDE的cpp目录下新增thirdparty目录，将编译生成的库拷贝到该目录下，动态库文件会自动拷贝到libs目录下打包，如下图所示:
  
  ![thirdparty_install_dir](pic/oneDNN_js.png)
 
- 在最外层（cpp目录下）CMakeLists.txt中添加如下语句

  ```shell
  #将三方库加入工程中
  target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/oneDNN/${OHOS_ARCH}/lib/libdnnl.so)

  #将三方库的头文件加入工程中
  target_include_directories(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/oneDNN/${OHOS_ARCH}/include)

  #将动态库打包到libs
  file(GLOB allLibs "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/oneDNN/${OHOS_ARCH}/lib/*.so*")
  add_custom_command(TARGET entry POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
    ${allLibs}
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../libs/${OHOS_ARCH}/)
  ```
 修改IDE的entry/build-profile.json5 文件，增加编译架构过滤："abiFilters": ["arm64-v8a"], 该库不支持armeabi-v7a, 如下图所示：

 ![oneDNN_build](pic/oneDNN_build.png)

 第一次编译，可能IDE不能创建目录，需要在entry/libs/下创建arm64-v8a 目录， 如下图：

 ![entry_libs](pic/entry_libs.png)

 然后，执行编译运行.

## 测试三方库

三方库的测试使用原库自带的测试用例来做测试，[准备三方库测试环境](../../../tools/README.md#ci环境准备)

进入到构建目录,执行如下命令ctest（arm64-v8a-build为构建64位的目录）

![oneDNN_test](pic/oneDNN_test.png)

## 参考资料

- [润和RK3568开发板标准系统快速上手](https://gitee.com/openharmony-sig/knowledge_demo_temp/tree/master/docs/rk3568_helloworld)
- [OpenHarmony三方库地址](https://gitee.com/openharmony-tpc)
- [OpenHarmony知识体系](https://gitee.com/openharmony-sig/knowledge)
- [通过DevEco Studio开发一个NAPI工程](https://gitee.com/openharmony-sig/knowledge_demo_temp/blob/master/docs/napi_study/docs/hello_napi.md)
