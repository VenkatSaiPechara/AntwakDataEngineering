file="$ /home/venkat/file"
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

if [ -f source/$filename ];
then
echo "Coping "filename" into destination folder"
cp source/$filename destination/$filename
status=$?
if [ $status ! = 0 ];
then
echo "Coping "filename" into destination folder failed"
else
echo "Coping "filename" into destination folder Successful"
fi
else
echo " Currentday "$filename" doesnt exists in source folder"
fi
filearg="$stringname""$1".csv
if [ -f source/$filearg ];
then 
	echo "file "$filearg" with argument date exists"
	cat source/$filearg
else
	echo "File with argument date doesnt exits"
fi