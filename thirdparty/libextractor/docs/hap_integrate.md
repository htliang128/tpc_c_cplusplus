# libextractor集成到应用hap

本库是在RK3568开发板上基于OpenHarmony3.2 Release版本的镜像验证的，如果是从未使用过RK3568，可以先查看[润和RK3568开发板标准系统快速上手](https://gitee.com/openharmony-sig/knowledge_demo_temp/tree/master/docs/rk3568_helloworld)。

## 开发环境

- [开发环境准备](../../../docs/hap_integrate_environment.md)

## 编译三方库

*   下载本仓库

    ```shell
    git clone https://gitee.com/openharmony-sig/tpc_c_cplusplus.git --depth=1
    ```

*   三方库目录结构

    ```shell
    tpc_c_cplusplus/thirdparty/libextractor     #三方库libextractor的目录结构如下
    ├── docs                                    #三方库相关文档的文件夹
    ├── HPKBUILD                                #构建脚本
    ├── HPKCHECK                                #测试脚本
    ├── OAT.xml                                 #扫描结果文件
    ├── SHA512SUM                               #三方库校验文件
    ├── README.OpenSource                       #说明三方库源码的下载地址，版本，license等信息
    ├── README_zh.md                            #三方库简介
    ```

*   在lycium目录下编译三方库

    编译环境的搭建参考[准备三方库构建环境](../../../lycium/README.md#1编译环境准备)

    ```shell
    cd lycium
    ./build.sh libextractor
    ```

*   三方库头文件及生成的库

    在lycium目录下会生成usr目录，该目录下存在已编译完成的32位和64位三方库

    ```shell
    libextractor/arm64-v8a    libextractor/armeabi-v7a
    libtool/arm64-v8a         libtool/armeabi-v7a 
    gettext/arm64-v8a         gettext/armeabi-v7a
    zlib/arm64-v8a            zlib/armeabi-v7a
    ```

*   [测试三方库](#测试三方库)

## 应用中使用三方库

- 在IDE的cpp目录下新增thirdparty目录，将三方库及其依赖库编译生成的头文件拷贝到该目录下。如下图所示：

&nbsp;![libextractor_install_dir](pic/libextractor-dev.png)

- 在最外层（cpp目录下）CMakeLists.txt中添加如下语句

  ```cmake
    #将三方库的头文件和库文件加入工程中
    target_include_directories(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/libextractor/${OHOS_ARCH}/include)
    target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/libextractor/${OHOS_ARCH}/lib/libextractor.a
                                    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/libextractor/${OHOS_ARCH}/lib/libextractor_common.a)
    #将三方库依赖库的头文件和库文件加入工程中
    target_include_directories(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/gettext/${OHOS_ARCH}/include)
    target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/gettext/${OHOS_ARCH}/lib/libasprintf.a
                                    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/gettext/${OHOS_ARCH}/lib/libgettextlib.a
                                    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/gettext/${OHOS_ARCH}/lib/libgettextpo.a
                                    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/gettext/${OHOS_ARCH}/lib/libintl.a
                                    ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/gettext/${OHOS_ARCH}/lib/libtextstyle.a)
    target_include_directories(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/libtool/${OHOS_ARCH}/include)
    target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/libtool/${OHOS_ARCH}/lib/libltdl.a)
    target_include_directories(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/zlib/${OHOS_ARCH}/include)
    target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/zlib/${OHOS_ARCH}/lib/libz.a)
  ```

## 测试三方库

- 编译出可执行的文件进行测试，[准备三方库测试环境](../../../lycium/README.md#3ci环境准备)

- 进入到构建目录运行测试用例（注意arm64-v8a为构建64位的目录，armeabi-v7a为构建32位的目录），执行结果如图所示
```
  /data/tpc_c_cplusplus/thirdparty/libextractor/libextractor-1.6-arm64-v8a-build/src/main
  make check-TEST
```

&nbsp;![libextractor_test](pic/libextractor_test.png)

## 参考资料

*   [OpenHarmony三方库地址](https://gitee.com/openharmony-tpc)
*   [OpenHarmony知识体系](https://gitee.com/openharmony-sig/knowledge)
*   [libtomcrypt三方库地址](https://github.com/ndurner/libextractor)

