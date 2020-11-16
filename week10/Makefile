#type make BACKUPNAME=[NAME FOR BACKUP FILE HERE] to change the backup file's name

BACKUPNAME = backup
URL = http://www.dt.fee.unicamp.br/~tiago/smsspamcollection/smsspamcollection.zip

${BACKUPNAME}.csv: ${BACKUPNAME}.txt
	sed 's/\+/,/g' ${BACKUPNAME}.txt > ${BACKUPNAME}.csv	

${BACKUPNAME}.txt: SMSSpamCollection.txt
	touch ${BACKUPNAME}.txt
	cat SMSSpamCollection.txt > ${BACKUPNAME}.txt

SMSSpamCollection.txt:
	./download.sh ${URL}

clean:
	rm -f SMSSpamCollection.txt
	rm -f ${BACKUPNAME}.txt
	rm -f ${BACKUPNAME}.csv
