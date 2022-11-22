# qt6_mysql_driver

### 1.项目概述（若要编译，请确定项目编译环境是64位）
> 目前Qt6一般不提供mysql驱动，而且也没有pro文件来生成对应的驱动文件
在Qt连接mysql数据库时，一般由于没有相应的驱动文件，在编译过程中会出现下面的问题：QSqlDatabase: QMYSQL driver not loaded
而通过本工程手动编译就可以实现相应环境下mysql驱动文件的生成

### 2.编译文件
！！如果你的项目实在**Desktop Qt 6.4.0 MSVC2019 64bit**下建立的，你可以直接使用**dll_and_lib**文件夹里面的动态链接文件，而无需再下面的编译工作；
- 首先，下载本工程到本地，通过使用
```
git clone git@github.com:sokestudio/qt6_mysql_driver.git
cd qt6_mysql_driver
```
- 其次，使用Qt Creator打开mysql/mysql.pro工程，在‘项目’栏选择对应的编译环境准备构建，另外本工程仅支持64位的环境
```
TARGET = qsqlmysql
 
HEADERS += $$PWD/qsql_mysql_p.h
SOURCES += $$PWD/qsql_mysql.cpp $$PWD/main.cpp
 
#QMAKE_USE += mysql
 
OTHER_FILES += mysql.json
 
PLUGIN_CLASS_NAME = QMYSQLDriverPlugin
include(../qsqldriverbase.pri)
 
#这个主要是添加.h依赖文件使用
INCLUDEPATH += ../mysql-connector-c-win64/include
 
#添加依赖的.lib文件
LIBS += ../mysql-connector-c-win64/lib/*.lib
 
#生成你所需要的dll存放目录
DESTDIR= ./outputDir/
```
- 最后，选择‘构建’并生成相应驱动文件，其中生成的驱动链接文件放在outputDir中 (可能编译会出现:Cannot read C:/Users/.qmake.conf: No such file or directory，可忽略不影最终响驱动文件生成)

### 3.复制文件(重要)
- **这里，以MSVC2019 64bit环境下编译为例，将生成的文件qsqlmysql.dll复制到./Qt/6.4.0/msvc2019_64/plugins/sqldrivers/下，同时也可将debug环境下qsqlmysqld.dll放入**
- **此外，还需要将mysql-connector-c-win64/bin文件下的libmysql.dll复制到./Qt/6.4.0/msvc2019_64/bin/下，同样也可将libmysqld.dll放入，用于debug环境**

### 4.测试连接
```
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("主机地址");  //连接本地主机
    db.setPort(3306);
    db.setDatabaseName("数据库名称");
    db.setUserName("账户");
    db.setPassword("密码");
    bool ok = db.open();
    if (ok){
        QMessageBox::information(this, "infor", "link success");
    }
    else {
        QMessageBox::information(this, "infor", "link failed");
    }
```

### 其他
> 目前本工程仅支持编译64位环境下mysql的驱动文件，mysql版本对应的头、库文件，动静态链接库都放在mysql-connector-c-win64文件夹中，如果你想编译其他版本的可访问[这里](https://downloads.mysql.com/archives/c-c/)，来选择下载对应的版本的zip文件夹
>
![t1](https://user-images.githubusercontent.com/50172682/203330902-3d3b3e90-a832-4b47-b14e-d0cf381ef821.png)

### 参考文件
[1] [彻底解决qt6.1.2,qmysql驱动.](https://blog.csdn.net/qq_40303500/article/details/118384147)
