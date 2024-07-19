# XNNPACK集成到应用hap

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
    tpc_c_cplusplus/thirdparty/xnnpack    #三方库XNNPACK的目录结构如下
    ├── docs                              #三方库相关文档的文件夹
    ├── HPKBUILD                          #构建脚本
    ├── HPKCHECK                          #测试脚本
    ├── OAT.xml                           #扫描结果文件
    ├── SHA512SUM                         #三方库校验文件
    ├── README.OpenSource                 #说明三方库源码的下载地址，版本，license等信息
    ├── README_zh.md                      #三方库简介
    ├── cpuinfo_ohos_pkg.patch            #用于cpuinfo库编译的补丁(xnnpack依赖)
    ├── xnnpack_ohos_pkg.patch            #用于xnnpack库编译的补丁
    ```

*   在lycium目录下编译三方库

    编译环境的搭建参考[准备三方库构建环境](../../../lycium/README.md#1编译环境准备)

    ```shell
    cd lycium
    ./build.sh xnnpack
    ```

*   三方库头文件及生成的库

    在lycium目录下会生成usr目录，该目录下存在已编译完成的32位和64位三方库

    ```shell
    xnnpack/arm64-v8a-build   xnnpack/armeabi-v7a-build
    ```

*   [测试三方库](#测试三方库)

## 应用中使用三方库

- 在IDE的cpp目录下新增thirdparty目录，将编译生成的头文件拷贝到该目录下，将生成的二进制文件以及头文件拷贝到该目录下，如下图所示：

&nbsp;![thirdparty_install_dir](pic/xnnpack-dev.png)

- 在最外层（cpp目录下）CMakeLists.txt中添加如下语句

  ```cmake
    #将三方库加入工程中
    target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/xnnpack/${OHOS_ARCH}/lib/libXNNPACK.a)
    target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/xnnpack/${OHOS_ARCH}/lib/libbenchmark.a)
    target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/xnnpack/${OHOS_ARCH}/lib/libbenchmark_main.a)
    target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/xnnpack/${OHOS_ARCH}/lib/libcpuinfo.a)
    target_link_libraries(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/xnnpack/${OHOS_ARCH}/lib/libpthreadpool.a)
    #将三方库的头文件加入工程中
    target_include_directories(entry PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/xnnpack/${OHOS_ARCH}/include)
  ```
  

## 测试三方库

- 编译出可执行的文件进行测试，[准备三方库测试环境](../../../lycium/README.md#3ci环境准备)

- 进入到构建目录运行测试ctest（注意arm64-v8a-build为构建64位的目录，armeabi-v7a-build为构建32位的目录），执行结果如图所示
```
cd /data/tpc_c_cplusplus/thirdparty/xnnpack/xnnpack-bc09d8f8b4681aaeaa82b9d9a078e7eae4838424/arm64-v8a-build
ctest
```

&nbsp;![XNNPACK_test](pic/test-cmd-ret.png)

## 参考资料

*   [OpenHarmony三方库地址](https://gitee.com/openharmony-tpc)
*   [OpenHarmony知识体系](https://gitee.com/openharmony-sig/knowledge)
*   [XNNPACK三方库地址](https://github.com/google/XNNPACK)

