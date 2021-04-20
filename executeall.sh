#!/bin/bash
# To Benchmark shoot skill for 20 iteratation, execute this script. 

LOG_PATH="/home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/2019/"
RESULT_PATH="/home/nps2dsoccer/Project/logs/dataset/results"
# echo "Path:" $PWD
count=0
# jsonfiles=$( find . -name "R*")
# echo "$jsonfiles"

shopt -s extglob
for i in {1..20}
do
    cd $LOG_PATH
    for file in **/**/**/R*; 
    # for file in R*; 
    # for file in **/**/R*; 
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

        # Path to L-team here
        cd /home/nps2dsoccer/Project/rcsclient/receptivity/receptivity/src
        gnome-terminal -- sh -c "./start.sh; bash"

        # Change the path to binary for R-team here 
        cd /home/nps2dsoccer/Project/rcsclient/yushan
        gnome-terminal --  sh -c "./start.sh; bash"

        sleep 10
    
        PIDTOKILL=$(pgrep -i bash -n)
        echo PIDTOKILL ${PIDTOKILL}
        kill $PIDTOKILL

        PIDTOKILL=$(pgrep -i bash -n)
        echo PIDTOKILL ${PIDTOKILL}
        kill $PIDTOKILL

        pkill rcssserver

        FOLDER_NAME="${FILEPATH////-}" 
        FINAL_FOLDER_NAME="${FOLDER_NAME/.json/}"


        
        cd $RESULT_PATH
        # mkdir -p cyrus/"$i"/"$FINAL_FOLDER_NAME"
        # mkdir -p helios/"$i"/"$FINAL_FOLDER_NAME"
        mkdir -p yushan/"$i"/"$FINAL_FOLDER_NAME"
        
        cd
        rm /home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/build/src/*.rcl
        # mv "/home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/build/src/"*".rcg" "$RESULT_PATH/cyrus/"$i"/"$FINAL_FOLDER_NAME"/"
        #  mv "/home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/build/src/"*".rcg" "$RESULT_PATH/helios/"$i"/"$FINAL_FOLDER_NAME"/"
        mv "/home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/build/src/"*".rcg" "$RESULT_PATH/yushan/"$i"/"$FINAL_FOLDER_NAME"/"

    done
done


