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
LIBS += ../mysql-connector-c-win64/lib/libmysql.lib
 
#生成你所需要的dll存放目录
DESTDIR= ./outputDir/
 
 
