#!/bin/bash
##############################################################
## file name: sougo.sh                                     ##
##  function :file shuffle                                 ##
##############################################################


# シャッフルの挙動はOK
# 実際にファイル交換を行う＋変更したファイル名を別ファイルに吐きだし
# 3回分まとめて出力できるように改良


# shuffle function
sougo_file(){
  srcDir=$1
  dstDir=$2

  echo "srcDir is [$srcDir]" 
  echo "dstDir is [$dstDir]" 
  echo  

  cd $srcDir


  #report Data
  repData=(`ls`)

  #shuffle Data
  shuData=(`ls`)

  #total Data
  toData=${#repData[@]}
  count=${#repData[@]}
#  echo $toData

  for i in `seq 1 $count`
  do
      rand=$((RANDOM % $toData))

      hoge=${repData[$rand]}
      repData[$rand]=${repData[$toData-1]}
      repData[$toData-1]=$hoge

#このif文が機能していないっぽい 被りなしが実現できていない
#      if [[ ${repData[$toData-1]} = ${shuData[$toData-1]} ]]
#      then
#	  ((i--))
#	  echo $i
#      else
      toData=`expr $toData - 1`
#      fi

#      echo rand = $rand
#      echo toData = $toData
      
      
  done
  
#  echo ${shuData[@]}
#  echo ${repData[@]}
  


  toData=${#repData[@]}
  for i in `seq 1 $toData`
  do
      fName=`find . -name "${repData[$i-1]}"`
      cp -f $fName $dstDir
      
      
  done
  
  for i in `seq 1 $toData`
  do
      cd $srcDir
      fName=`find . -name "${shuData[$i-1]}"`
      rName=`find . -name "${repData[$i-1]}"`

      fName=`echo ${fName:2:6}`
      fName=`echo $fName | sed -e "s/$/.c/"`

      cd $dstDir
      rName=`echo ${rName:2:6}`
      rName=`echo $rName | sed -e "s/^/s1/"`
      rName=`echo $rName | sed -e "s/$/.c/"`

#      echo ${shuData[$i-1]}

      echo "$fName to $rName " 
      echo "" >> sougo_output1

      mv $fName $rName
     
  done
  
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
