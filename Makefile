.PHONY: test check clean build dist all

default: cgoBuildDarwinAmd64

clean:
	-@rm *.a *.o

cgoBuildDarwinAmd64: clean
	CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 \
	go build -ldflags "-w" -x -v -buildmode=c-archive \
	-o test.a
	@echo ""
	file test.a

cgoCC: cgoBuildDarwinAmd64
	cc -c -o testc.o test.c
	ar rs test.a testc.o