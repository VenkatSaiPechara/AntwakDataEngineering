file="$ /home/venkat/file"
cmd_arg=$#
if [ ! -d /home/venkat/source];
then
	echo "Source directory doesnt exits. We are creating it"
	mkdir /home/venkat/source
	echo "Source directory got created"
fi
if [! -d /home/venkat/destination ];
then
	echo "Destination directory doesnt exits. We are creating it"
	mkdir /home/venkat/destination
	echo "Destination directory got created"
fi
stringname='Antwak_Daily_data_'
datevar=$(date "+%Y%m%d") 
filename="$stringname""$datevar".csv
if [ ! -f source/$filename ];
then 
echo "Creating"$filename"in source  "
mv $file source/$filename
fi

if [ $cmd_args -eq 0 ];
then
if [ -f source/$filename ];
then
echo "Coping "filename" into destination folder"
cp source/$filename destination/$filename
status=$?
if [ $status ! = 0 ];
then
   echo "Copying "filename" into destination folder failed"
   mail -s "Copying failed" venkyuv259@gmail.com
else
   echo "Coping "filename" into destination folder Successful"
   mail -s "Copied successfully" venkyuv259@gmail.com
fi
else
echo " Currentday "$filename" doesnt exists in source folder"
fi

elif [ $cmd_arg -eq 1];
then
filearg="$stringname""$1".csv
if [ -f source/$filearg ];
then 
	echo "file "$filearg" with argument date exists"
	cat source/$filearg
else
	echo "File with argument date doesnt exits"
	mail -s "File "$filearg" with argument date doesnt exits" venkyuv259@gmail.com
fi
fi
fi