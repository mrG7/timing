TEST_NAME=divi

graph: $(TEST_NAME)
	../run.py $(TEST_NAME) | ../plot.py

result: $(TEST_NAME)
	./$(TEST_NAME)

$(TEST_NAME): $(TEST_NAME).o
	ld -lc -o $(TEST_NAME) $(TEST_NAME).o /usr/lib/crt1.o

$(TEST_NAME).o: $(TEST_NAME).S
	nasm -O0 -f macho64 $(TEST_NAME).S

$(TEST_NAME).S: *.asm ../common.asm
	nasm -O0 -p ../common.asm -E *.asm > $(TEST_NAME).S

clean:
	rm *.o
	rm *.S
	rm $(TEST_NAME)

.PHONY: result
