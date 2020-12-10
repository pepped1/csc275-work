file=apache_logs.asc
locations='Netherlands'

# runs the script with the decrypted file
final3.sh: decrypted.txt
	./final.sh decrypted.txt $(locations)

# decrypts the file
decrypted.txt: $(file)
	# not sure if this will work for you but if it asks for a password its "password"
	gpg --decrypt --passphrase password $(file) > decrypted.txt

.PHONY: clean
clean:
	rm *.txt
	rm *.csv
