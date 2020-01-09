#!/usr/bin/env bash

export HDP_VERSION=$HADOOP_VERSION
export HADOOP_HOME=$HADOOP_INSTALL_DIR/hadoop
export HADOOP_LOG_DIR=$HADOOP_HOME/logs
mkdir -p $HADOOP_LOG_DIR
export HADOOP_PID_DIR=$HADOOP_INSTALL_DIR/pids
mkdir -p $HADOOP_PID_DIR
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME

export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export HADOOP_TMP_DIR=$HADOOP_HOME/tmp
mkdir -p $HADOOP_TMP_DIR
mkdir -p $HADOOP_TMP_DIR/hdfs/datanode
mkdir -p $HADOOP_TMP_DIR/hdfs/namenode
cp -f /settings/core-site.xml $HADOOP_CONF_DIR
sed -i "s~HADOOP_TMP_DIR~$HADOOP_TMP_DIR~" $HADOOP_CONF_DIR/core-site.xml

cp -f /settings/hdfs-site.xml $HADOOP_CONF_DIR
sed -i "s~HADOOP_TMP_DIR~$HADOOP_TMP_DIR~g" $HADOOP_CONF_DIR/hdfs-site.xml

cp /settings/mapred-site.xml $HADOOP_CONF_DIR
cp /settings/yarn-site.xml $HADOOP_CONF_DIR 

sed -i "s~\${JAVA_HOME}~$JAVA_HOME~" $HADOOP_CONF_DIR/hadoop-env.sh

chown -R $DOCKER_USER:$DOCKER_GROUP $HADOOP_HOME

/etc/init.d/ssh start
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
hdfs namenode -format -force

# start-dfs.sh &&./start-yarn.sh