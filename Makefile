SRC=lib
INC=include
LIB=.
CLIENT=client

CC=gcc
CCFLAGS=-I$(INC) -Wall -O
LDFLAGS=-L$(LIB) -lmqtt
AR=ar


c: $(CLIENT)/pub  $(CLIENT)/sub

$(CLIENT)/pub: libmqtt.a  pub.o
	$(CC) pub.o -o $(CLIENT)/pub $(LDFLAGS)

pub.o: $(CLIENT)/pub.c $(INC)/libemqtt.h
	$(CC) $(CCFLAGS) -c $(CLIENT)/pub.c  -o pub.o

$(CLIENT)/sub: libmqtt.a  sub.o
	$(CC) sub.o -o $(CLIENT)/sub $(LDFLAGS)
sub.o: $(CLIENT)/sub.c $(INC)/libemqtt.h
	$(CC) $(CCFLAGS) -c $(CLIENT)/sub.c  -o sub.o


libmqtt.a: libmqtt.o
	$(AR) rcs libmqtt.a libmqtt.o

libmqtt.o: $(SRC)/libemqtt.c $(INC)/libemqtt.h
	$(CC) $(CCFLAGS) -c $(SRC)/libemqtt.c -o libmqtt.o





all: c





clean:
	rm -f *.o libmqtt.a

dist-clean: clean
	rm -f $(CLIENT)/pub $(CLIENT)/sub $(CLIENT)/libmqtt.so
