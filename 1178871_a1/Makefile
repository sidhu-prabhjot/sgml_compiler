JAVAC=javac

all: Token.class Lexer.class Scanner.class

%.class: %.java
	$(JAVAC) $^

Lexer.java: sgml.flex
	jflex sgml.flex

clean:
	rm -f Lexer.java *.class *~
