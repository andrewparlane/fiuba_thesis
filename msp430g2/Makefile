test:
	echo "Building the Test project"
	make -C test/

reader:
	echo "Building the Reader project"
	make -C reader/

card_emulator:
	echo "Building the Card Emulator project"
	make -C card_emulator/

program_test: test
	make -C test/ program

program_reader: reader
	make -C reader/ program

program_card_emulator: card_emulator
	make -C card_emulator/ program

.PHONY: test reader card_emulator program_test program_reader program_card_emulator
