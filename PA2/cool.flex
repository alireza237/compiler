/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */



int n=0;

int n1=0;


%}

/*
 * Define names for regular expressions here.
 */

DARROW           =>
CLASS            (?i:class)
ELSE             (?i:else)
FI               (?i:fi)
IF               (?i:if)
IN               (?i:in)
INHERITS         (?i:inherits)
LET              (?i:let)
LOOP             (?i:loop)
POOL             (?i:pool)
THEN             (?i:then)
WHILE            (?i:while)
CASE             (?i:case)
ESAC             (?i:esac)
OF               (?i:of)
NEW              (?i:new)
ISVOID           (?i:isvoid)
ASSIGN           <-
NOT              (?i:not)
LE               <=
TYPEID           [A-Z][a-zA-Z0-9_]*
INT_CONST        [0-9]+
OBJECTID         [a-z][a-zA-Z0-9_]*

TRUE             (t)(?i:rue)
FALSE            (f)(?i:alse)

WHITE   [ \f\r\t\v]

START_COMMENT   "(*"
END_COMMENT     "*)"
LINE_COMMENT    "--"
QUOTES      "\""




%x comment
%x ESC
%x string

%%

 /*
  *  Nested comments
  */


 /*
  *  The multiple-character operators.
  */
{DARROW}	 	         { return (DARROW); }
{CLASS}                  { return (CLASS); }
{ELSE}                   { return (ELSE); }
{FI}                     { return (FI); }
{IF}                     { return (IF); }
{IN}                     { return (IN); }
{INHERITS}               { return (INHERITS); }
{LET}                    { return (LET); }
{LOOP}                   { return (LOOP); }
{POOL}                   { return (POOL); }
{THEN}                   { return (THEN); }
{WHILE}                  { return (WHILE); }
{CASE}                   { return (CASE); }
{ESAC}                   { return (ESAC); }
{OF}                     { return (OF); }
{NEW}                    { return (NEW); }
{ISVOID}                 { return (ISVOID); }
{ASSIGN}                 { return (ASSIGN); }
{NOT}                    { return (NOT); }
{LE}                     { return (LE); }
{TRUE}                   {
                            cool_yylval.boolean = true;
                            return BOOL_CONST;
}
{FALSE}                  {
                            cool_yylval.boolean = false;
                            return BOOL_CONST;
}

{INT_CONST}              {
                            cool_yylval.symbol = inttable.add_string(yytext);
                            return INT_CONST;
}
{TYPEID}                 {
                            cool_yylval.symbol = idtable.add_string(yytext);
                            return TYPEID;
}
{OBJECTID}|(self)        {
                            cool_yylval.symbol = idtable.add_string(yytext);
                            return OBJECTID;
}
";"                      { return int(';'); }
","                      { return int(','); }
":"                      { return int(':'); }
"{"                      { return int('{'); }
"}"                      { return int('}'); }
"+"                      { return int('+'); }
"-"                      { return int('-'); }
"*"                      { return int('*'); }
"/"                      { return int('/'); }
"<"                      { return int('<'); }
"="                      { return int('='); }
"~"                      { return int('~'); }
"."                      { return int('.'); }
"@"                      { return int('@'); }
"("                      { return int('('); }
")"                      { return int(')'); }





{LINE_COMMENT}(.*)
{END_COMMENT}                   {
                            cool_yylval.error_msg = " Unmatched *)";
                            return ERROR;
}


{START_COMMENT}                {
                        n++;
                        BEGIN(comment);
}

<comment>{START_COMMENT}        {
                        n++;
}
<comment>{END_COMMENT}        {
                        n--;
                        if(n==0)
                            BEGIN(INITIAL);

}

<comment>"\n"            ++curr_lineno;
<comment>.
<comment>(WHITE)+
<comment><<EOF>>      {

                        BEGIN(INITIAL);
                        if(n>0){
                            cool_yylval.error_msg = "EOF in comment";
                            n=0;
                            return ERROR;
                       }

}


\n        curr_lineno++;



{QUOTES}      {

                string_buf_ptr = string_buf;
n1=0;
                BEGIN(string);

}

<string>{QUOTES}           {



                            *string_buf_ptr='\0';
                            cool_yylval.symbol = stringtable.add_string(string_buf);
                            BEGIN(INITIAL);
                            return STR_CONST;
}


<string><<EOF>>        {

                        cool_yylval.error_msg = "EOF in string constant";
                        BEGIN(INITIAL);
                        return ERROR;
}

<string>\0        {
                    *string_buf = '\0';
                    cool_yylval.error_msg = "String contains null character";
                    BEGIN(ESC);
                    return ERROR;
}

<string>\n        {

                    *string_buf = '\0';
                    ++curr_lineno;
                    cool_yylval.error_msg = "Unterminated string constant";
                    BEGIN(INITIAL);
                    return ERROR;
}





<string>"\\n"        {
                        if(n1 > MAX_STR_CONST-1){
                                *string_buf = '\0';
                                cool_yylval.error_msg = "String constant too long";
                                BEGIN(ESC);
                                return ERROR;
                                }
                        *string_buf_ptr++ = '\n';n1++;

}



<string>"\\t"        {
                        if(n1 > MAX_STR_CONST-1){
                                *string_buf = '\0';
                                cool_yylval.error_msg = "String constant too long";
                                BEGIN(ESC);
                                return ERROR;
                                }
                        *string_buf_ptr++ = '\t';n1++;

}





<string>"\\b"        {
                        if(n1 > MAX_STR_CONST-1){
                                *string_buf = '\0';
                                cool_yylval.error_msg = "String constant too long";
                                BEGIN(ESC);
                                return ERROR;
                        }
                        *string_buf_ptr++ = '\b';n1++;

}





<string>"\\f"        {
                        if(n1 > MAX_STR_CONST-1){
                                *string_buf = '\0';
                                cool_yylval.error_msg = "String constant too long";
                                BEGIN(ESC);
                                return ERROR;
                        }
                        *string_buf_ptr++ = '\f';n1++;

}



<string>"\\"[^\0]      {
                if(n1 > MAX_STR_CONST-1){
                        *string_buf = '\0';
                        cool_yylval.error_msg = "String constant too long";
                        BEGIN(ESC);
                        return ERROR;
                }
                *string_buf_ptr++ = yytext[1];n1++;
                }



<string>.            {
                        if(n1 > MAX_STR_CONST-1){
                            *string_buf = '\0';
                            cool_yylval.error_msg = "String constant too long";
                            BEGIN(ESC);
                            return ERROR;
                            }
                            *string_buf_ptr++ = *yytext;
                            n1++;}

<ESC>[\n|"]        BEGIN(INITIAL);
<ESC>[^\n|"]

\n        curr_lineno++;
{WHITE}+



.        {
cool_yylval.error_msg = yytext;
return ERROR;
}


%%
