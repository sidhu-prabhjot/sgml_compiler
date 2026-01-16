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

    //method to extract and return just the name of the tag
    private String getTagName(String tag) {
        StringBuilder tagName = new StringBuilder();

        int i = 1;
        boolean addCharacters = false;

        while (i < tag.length() - 1) {

          if (addCharacters){
            tagName.append(tag.charAt(i));
          }
          
          if (tag.charAt(i) == ' ' && tag.charAt(i + 1) != ' '){
            addCharacters = true;
          } else if (tag.charAt(i) != ' ' && tag.charAt(i + 1) == ' '){
            break;
          }

          i++;

        }

        return tagName.toString();
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

   {OpenTag}    { 

      tagStack.push(getTagName(yytext()));
    
      return new Token(Token.OPEN_TAG, yytext(), yyline, yycolumn); 
    
    }

    {CloeTag}   {

           

    }