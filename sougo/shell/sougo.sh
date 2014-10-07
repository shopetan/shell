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
#  dst2Dir=$3
#  dst3Dir=$4
  null=0
  i=0

  echo "srcDir is [$srcDir]" 
  echo "dstDir is [$dstDir]" 
  echo  

  cd $srcDir

  #report Data
  repData=(`ls`)

#  sougo1Data

  #shuffle Data
  shuData=(`ls`)

  #total Data
  toData=${#repData[@]}
  count=${#repData[@]}



#自分含む重複を許さないランダムシャッフル
  while [ $i != $toData ] 
  do
      rand=$((RANDOM % $count))
      
      if [ $rand = `expr $count - 1` ]
      then
	  if [ $null != `expr $count - 1` ]
	  then
	      i=`expr $i - 1`
	  fi
      else
	  hoge=${repData[$rand]}
	  repData[$rand]=${repData[$count-1]}
	  repData[$count-1]=$hoge
	  count=`expr $count - 1`
      fi
      i=`expr $i + 1`
  done
  
#  echo ${shuData[@]}
#  echo ${repData[@]}
#  echo ""
  
  
#該当ファイルをコピー
  toData=${#repData[@]}
  for i in `seq 1 $toData`
  do
      fName=`find . -name "${repData[$i-1]}"`
      cp -f $fName $dstDir
      
  done
  
#該当ファイルをリネーム
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

      mv $fName $rName     
      echo "$fName to $rName "
#renameしたいけどこれではできないみたい
#      fName=`echo ${rName:2:8}"`
#      mv $rName $fName
  done
  
  
  
}


echo "###############################################" 
echo "##                   START                   ##" 
echo "###############################################" 
echo "" 

# start function
# sougo srcDir destDir

sougo_file ~/Desktop/shell/sougo/admin ~/Desktop/shell/sougo/shdbg/home/class/j2/prog/j13/j2pro1007/sougo1 


echo "" 
echo "###############################################" 
echo "##                    END                    ##" 
echo "###############################################" 

exit
