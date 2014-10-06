#!/bin/bash
##############################################################
## file name: sougo.sh                                     ##
##  function :file shuffle                                 ##
##############################################################


# shuffle function
sougo_file(){
  srcDir=$1
  dstDir=$2

  echo srcDir is [$srcDir]
  echo dstDir is [$dstDir]
  

  cd $srcDir

  #report Data
  repData=(`ls`)
  echo ${repData[@]}
  
  #total Data
  toData=${#repData[@]}
#  echo $toData

  for i in `seq 1 $toData`
  do
      rand=$((RANDOM % $toData))

      hoge=${repData[$rand]}
      repData[$rand]=${repData[$toData-1]}
      repData[$toData-1]=$hoge
      toData=`expr $toData - 1`

      echo rand = $rand
      echo toData = $toData
      
      
  done
  echo ${repData[@]}
  

}
 
echo "###############################################"
echo "##                   START                   ##"
echo "###############################################"
echo ""
 
# start function
# sougo srcDir destDir

sougo_file ~/admin ~/shdbg/home/class/j2/prog/j13/j2pro1007/sougo1

 
echo ""
echo "###############################################"
echo "##                    END                    ##"
echo "###############################################"
 
exit
