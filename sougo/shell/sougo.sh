#!/bin/bash
##############################################################
## file name: sougo.sh                                     ##
##  function :file shuffle                                 ##
##############################################################


# シャッフルの挙動はOK


# shuffle function
sougo_file(){

#拡張性に欠けるが，初めから3人に採点をしてもらう前提でプログラムを書く
  srcDir=$1
  dstDir1=$2
  dstDir2=$3
  dstDir3=$4
  null=0
  error=0
  flag1='0'
  flag2='0'
  dbg=0

  i=0
#  echo "srcDir is [$srcDir]" 
#  echo "dstDir1 is [$dstDir1]" 
#  echo "dstDir2 is [$dstDir2]"
#  echo "dstDir3 is [$dstDir3]"

  cd $srcDir

  #report Data
  repData=(`ls`)
  
#  sougo1Data

  #shuffle Data
  shuData=(`ls`)
  prshuData=(`ls`)
  prprshuData=(`ls`)


  #total Data
  toData=${#repData[@]}
  count=${#repData[@]}
  
  #ランダムシャッフル* 3
  for j in `seq 1 3`
  do

      #init Data
      toData=${#repData[@]}
      count=${#repData[@]}
      i=`expr $toData - 1 `

      # 自分含む重複を許さないランダムシャッフル
      # 参照されるファイルが少ない場合,
      # 重複ファイルが必ず出来てしまうために終了されないプログラムになる．

      while [ $i != $null ] 
      do

	  rand=$((RANDOM % $count))

#	  echo dbg i = $i
#	  echo dbg count = $count
#	  echo rand = $rand
	  

	  dbg=`expr $count - 1 `
	  #自分のファイルと同じファイルになってしまった場合
#	  if [ "${shuData[$rand]}" = "${repData[`expr $count - 1`]" ]
#	      echo dbg shuData[$rand] = ${shuData[$rand]}
#	      echo dbg repData[`expr $count - 1`] = ${repData[`expr $count - 1`]}
	  if [ "$rand" = "$dbg" ]
	  then
#	      echo bug
	      if [ "$null" != "dbg" ]
	      then
		  i=`expr $i + 1`
	      fi
	  else

	      unset hoge
	      hoge=${shuData[$rand]}

#	      echo dbg repData[`expr $count - 1`] = ${repData[`expr $count - 1`]}
#	      echo dbg shuData[`expr $count - 1`] = ${shuData[`expr $count - 1`]}
#	      echo dbg hoge = $hoge
#	      echo dbg prshuData[`expr $count - 1`] = ${prshuData[`expr $count - 1`]}
#	      echo dbg prprshuData[`expr $count - 1`] = ${prprshuData[`expr $count - 1`]}
	      

	      #過去のファイルと一致しないユニークなファイルだった場合
	      if [ "${prshuData[`expr $count - 1 `]}" != "$hoge" ]
	      then
		  flag1='0'
	      fi
	      if [ "${prprshuData[`expr $count - 1 `]}" != "$hoge" ]
	      then
		  flag2='0'
	      fi
	      
	      #過去のファイルと同じファイルになってしまった場合
	      if [ "${prshuData[`expr $count - 1`]}" = "$hoge" ]
	      then
		  #		  echo dbg prshuData[`expr $count - 1`] is ${prshuData[`expr $count - 1`]}
		  #		  echo dbg hoge is $hoge
		  count=`expr $count + 1`
		  i=`expr $i + 1`
		  flag1='1'
		  error=`expr $error + 1`  	      
	      elif [ "${prprshuData[`expr $count - 1 `]}" = "$hoge" ]
	      then		  
		  count=`expr $count + 1`
		  i=`expr $i + 1`
		  flag2='1'
		  error=`expr $error + 1`
	      fi
	      	      

	      #過去のファイルのどちらとも同じになってしまった場合
	      if [ $flag1 = '1' ]
	      then
		  if [ $flag2 = '1' ]
		      then
		      count=`expr $count - 1`
		      i=`expr $i - 1`
		  fi
	      fi
	      # どちらにも該当しなかった場合
	      # ここで初めてシャッフルするファイルが決定される．
	      if [ $flag1 != '1' ]
	      then
		  if [ $flag2 != '1' ]
		      then
		      shuData[$rand]=${shuData[`expr $count - 1 `]}
		      shuData[`expr $count - 1 `]=$hoge
#		      echo dbg new shuData[`expr $count - 1`] = ${shuData[`expr $count - 1`]}
		      flag1='0'
		      flag2='0'
		      fi
		  
	      fi
	      
	      #重複したまま計算上詰んでしまい，これ以上ファイルを更新できない場合のエラー処理. 
	      #必要変数をすべて初期化してやり直し
	      if [ $error -gt 10 ]
	      then
		  count=`expr $toData + 1 `
		  i=$toData
		  error=`expr $error - $error`
		  flag1='0'
		  flag2='0'
		  
		  unset shuData
		  unset hoge
		  for i in `seq 1 $toData`
		  do
		      shuData[`expr $i - 1 `]=${repData[`expr $i - 1 `]}
		  done
		  
	      fi
	      # 最後の項が過去のファイルと一致した場合，一度乱数の降り直しを行う
	      # プログラムにどこから間違っているのか探索させるより，一度乱数を振り直した方が速く動作した．
	      if [ $i = '1' ]
	      then
#		  echo dbg check i = $i
#		  echo dbg prshuData[`expr $count - 2`] is ${prshuData[`expr $count - 2`]}
#		  echo dbg hoge is $hoge
		  
		  if [ "${prshuData[`expr $i - 1 `]}" = "${shuData[`expr $i - 1`]}" ]
		  then
		      
		      count=`expr $toData + 1 `
		      i=$toData
		      error=`expr $error - $error`
		      flag1='0'
		      flag2='0'
		      
		      unset shuData
		      unset hoge
		      for i in `seq 1 $toData`
		      do
			  shuData[`expr $i - 1 `]=${repData[`expr $i - 1 `]}
		      done
		      
		  elif [ "${prprshuData[`expr $i - 1 `]}" = "${shuData[`expr $i - 1`]}" ]
		  then
		      count=`expr $toData + 1 `
		      i=$toData
		      error=`expr $error - $error`
		      flag1='0'
		      flag2='0'
		      
		      unset shuData
		      unset hoge
		      for i in `seq 1 $toData`
		      do
			  shuData[`expr $i - 1 `]=${repData[`expr $i - 1 `]}
		      done
		      
		  elif [ "${repData[`expr $i - 1 `]}" = "${shuData[`expr $i - 1`]}" ]
		  then
		      
		      count=`expr $toData + 1 `
		      i=$toData
		      error=`expr $error - $error`
		      flag1='0'
		      flag2='0'
		      
		      unset shuData
		      unset hoge
		      for i in `seq 1 $toData`
		      do
			  shuData[`expr $i - 1 `]=${repData[`expr $i - 1 `]}
		      done
		      
		  fi
		  
	      fi
	      count=`expr $count - 1`
	  fi
	  i=`expr $i - 1`
      done
      
#      echo ${repData[@]}
#      echo ${shuData[@]}
#      echo ""
      
      

      # 格納先フォルダを表示
      if [ $j = "1" ]
      then
	  echo srcfile to "[$dstDir1]"	      
      elif [ $j = "2" ]
      then
	  echo srcfile to "[$dstDir2]"
      elif [ $j = "3" ]
      then 
	  echo srcfile to "[$dstDir3]"
      fi
      
      
      #該当ファイルをコピー
      toData=${#shuData[@]}
      for i in `seq 1 $toData`
      do
	  cd $srcDir
	  
	  fName=`find . -name "${repData[$i - 1 ]}"`
#	  echo dbg shuData[`expr $i - 1`] is ${shuData[$i -1]}
#	  echo dbg fName    is [$fName]
	  
	  if [ $j = "1" ]
	  then	      
	      cp -f $fName $dstDir1
	  elif [ $j = "2" ]
	  then
	      cp -f $fName $dstDir2
	  elif [ $j = "3" ]
	  then 
	      cp -f $fName $dstDir3
	  fi


      done
      
      #該当ファイルをリネーム
      for i in `seq 1 $toData`
      do

	  cd $srcDir
	  fName=`find . -name "${repData[$i-1]}"`
	  rName=`find . -name "${shuData[$i-1]}"`
	  
	  fName=`echo ${fName:2:6}`
	  fName=`echo $fName | sed -e "s/$/.c/"`
	  
	  if [ $j = "1" ]
	  then
	  cd $dstDir1
	  rName=`echo ${rName:2:6}`
	  rName=`echo $rName | sed -e "s/^/s1/"`
	  rName=`echo $rName | sed -e "s/$/.c/"`
	  mv $fName $rName     
	  echo "$fName to $rName "

	  elif [ $j = "2" ]
	  then
	  cd $dstDir2
	  rName=`echo ${rName:2:6}`
	  rName=`echo $rName | sed -e "s/^/s2/"`
	  rName=`echo $rName | sed -e "s/$/.c/"`
	  mv $fName $rName     
	  echo "$fName to $rName "

	  elif [ $j = "3" ]
	  then 
	  cd $dstDir3	  
	  rName=`echo ${rName:2:6}`
	  rName=`echo $rName | sed -e "s/^/s3/"`
	  rName=`echo $rName | sed -e "s/$/.c/"`
	  mv $fName $rName     
	  echo "$fName to $rName "

	  fi

	  
	  #renameしたいけどこれではできないみたい
	  #      fName=`echo ${rName:2:8}"`
	  #      mv $rName $fName
      done

      if [ $j != 3 ]
	  then 
	  unset prprshuData
	  for i in `seq 1 $toData`
	  do
	      prprshuData[`expr $i - 1 `]=${prshuData[`expr $i - 1 `]}
	  done
	  
	  unset prshuData
	  for i in `seq 1 $toData`
	  do
	      prshuData[`expr $i - 1 `]=${shuData[`expr $i - 1 `]}
	  done
	  
	  unset shuData
	  for i in `seq 1 $toData`
	  do
	      shuData[`expr $i - 1 `]=${repData[`expr $i - 1 `]}
	  done
      fi

      echo ""
  done

  echo dbg REPORT ${repData[@]} 
  echo dbg SOUGO1 ${prprshuData[@]}
  echo dbg SOUGO2   ${prshuData[@]}
  echo dbg SOUGO2  ${shuData[@]}
  
  
}


echo "###############################################" 
echo "##                   START                   ##" 
echo "###############################################" 
echo "" 

# start function
# sougo srcDir destDir

sougo_file /home/owner/shell-master/sougo/admin  /home/owner/shell-master/sougo/shdbg/home/class/j2/prog/j13/j2pro1007/sougo1  /home/owner/shell-master/sougo/shdbg/home/class/j2/prog/j13/j2pro1007/sougo2  /home/owner/shell-master/sougo/shdbg/home/class/j2/prog/j13/j2pro1007/sougo3


echo "" 
echo "###############################################" 
echo "##                    END                    ##" 
echo "###############################################" 

exit
