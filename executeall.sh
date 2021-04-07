
# cd /home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/
# cd /home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/2019/PreliminaryRound/GroupH/20190704144102-HillStone_1-vs-MT2019_5/
# cd /home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/2019/MainRound/GroupK/20190706093045-FRA-UNIted_1-vs-YuShan2019_1
cd /home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/2019/Elimination/3rdPlace/20190707110008-CYRUS2019_0-vs-Fractals2019_2

echo "Path:" $PWD
count=0
# jsonfiles=$( find . -name "R*")
# echo "$jsonfiles"

shopt -s extglob
# for file in **/**/**/**/R*; 
for file in R*; 
do 
    ((count=count+1))
    echo $file;
    # rm /home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/slice.json
    cat $file > /home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/slice.json

    cd /home/nps2dsoccer/Project/rlercssserver/rcssserver-16.0.0/build/src
    ./rcssserver server::auto_mode=on &

    cd /home/nps2dsoccer/Project/rcssmonitor-16.0.0/build/src
    ./rcssmonitor &

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


    cd /home/nps2dsoccer/Project/logs/dataset/shoots/RoboCup/2019/Elimination/3rdPlace/20190707110008-CYRUS2019_0-vs-Fractals2019_2




done



echo Count $count
