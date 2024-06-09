
if [ $# -ne 2 ]
then
  echo "인수 개수 오류"
  exit 1
fi

if [[ ! $2 =~ ^[0-9]{2,3}-[0-9]{4}-[0-9]{4}$ ]] 
then
  echo "입력 형식 오류"
  exit 1
fi

local_number=$(echo $2 | cut -d "-" -f1)

case $local_number in

  02) region="서울" ;;

  031) region="경기" ;;

  032) region="인천" ;;

  051) region="부산" ;;

  053) region="대전" ;;

  *) ;;

esac

full_number="$1 $2 $region"
echo "$full_number"

if [ ! -e number.txt ] ; then
  touch number.txt
fi


search=$(grep -w "$1" number.txt)


if [ -n "$search" ] 
then
  while read -r line ;
  do
    stored_number=$(echo "$line" | cut -d " " -f2)
    if [ "$2" = "$stored_number" ] ; then
      echo "전화번호가 기존에 존재합니다."
      exit 0
    fi
  done <<< "$search"
fi

echo "$full_number" >> number.txt
sort -k1 -o number.txt number.txt
echo "새 전화번호가 추가되었습니다."
exit 0
