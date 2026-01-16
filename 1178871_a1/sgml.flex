/*
  File Name: sgml.flex
  JFlex specification for the SGML language
*/

import java.util.Stack;

%%
   
%class Lexer
%type Token
%line
%column

%eofval{
  return null;
%eofval};

%{
    private static Stack<String> tagStack = new Stack<String>();

    //method to retrieve the name of the tag at the top of the stacked
    private String getTagName() {
        return tagStack.peep();
    };
%};

/*A regular expression for all letters that could be generated
to be used as a macro*/
letter = [a-zA-Z]

/*A regular expression for all digits that could be generated
to be used as a macro*/
digit = [0-9]

/*The regular expression to detect an opening tag*/
OpenTag = "<"{letter}+("="({letter}|{digit})+)?">"

/*The regular expression to detect a closing tag*/
CloseTag = "</"{letter}+">"

%%

/*
   This section contains regular expressions and actions that will be executed when the scanner matches the associated regular expression. */

   {OpenTag}    { return new Token(Token.OPEN_TAG, yytext(), yyline, yycolumn); }