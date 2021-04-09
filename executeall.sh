#!/bin/bash
# cd /home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/
# cd /home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/2019/PreliminaryRound/GroupH/20190704144102-HillStone_1-vs-MT2019_5/
# cd /home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/2019/MainRound/GroupK/20190706093045-FRA-UNIted_1-vs-YuShan2019_1
cd /home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/2019/Elimination/
LOG_PATH=$PWD
RESULT_PATH="/home/nps2dsoccer/Project/logs/dataset/results"
# echo "Path:" $PWD
count=0
# jsonfiles=$( find . -name "R*")
# echo "$jsonfiles"

shopt -s extglob
# for file in **/**/**/R*; 
# for file in R*; 
for file in **/**/R*; 
do  
    ((count=count+1))
    cd $LOG_PATH
    # echo $file
    FILEPATH=$file
    

    rm /home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/slice.json
    cat $file > /home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/slice.json

    cd /home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/build/src
    ./rcssserver server::auto_mode=on &

   

    # cd /home/nps2dsoccer/Project/rcssmonitor-16.0.0/build/src
    # ./rcssmonitor &

    cd /home/nps2dsoccer/Project/rcsclient/receptivity/receptivity/src
    gnome-terminal -- sh -c "./start.sh; echo $$ ; bash"

    cd /home/nps2dsoccer/Project/rcsclient/cyrus
    gnome-terminal --  sh -c "./startAll; bash"

    sleep 10
   
    PIDTOKILL=$(pgrep -i bash -n)
    echo PIDTOKILL ${PIDTOKILL}
    kill $PIDTOKILL

    PIDTOKILL=$(pgrep -i bash -n)
    echo PIDTOKILL ${PIDTOKILL}
    kill $PIDTOKILL
    
    sleep 1
    pkill rcssserver

    FOLDER_NAME="${FILEPATH////-}" 
    FINAL_FOLDER_NAME="${FOLDER_NAME/.json/}"

    # echo $FINAL_FOLDER_NAME

    
    cd $RESULT_PATH
    mkdir -p cyrus/1/"$FINAL_FOLDER_NAME"
    
    cd
    # echo $PWD
    rm /home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/build/src/*.rcl
    mv "/home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/build/src/"*".rcg" "$RESULT_PATH/cyrus/1/"$FINAL_FOLDER_NAME"/"

done



echo Count $count
