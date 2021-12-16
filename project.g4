grammar project;

prog: (decl | expr) + EOF
	;
	
//variable declare TODO: add list
decl: ID '=' (NUM | STRING)
	;
	
//arithmetic operators
expr: expr '+' expr
	| expr '-' expr
	| expr '*' expr
	| expr '/' expr
	| expr '%' expr
	| expr '^' expr
	| ID
	| NUM
	;

assignExpr: ID ASSIGNMENTOPS expr;

conditionals: expr CONDITIONALS expr; 

codeblock: codeblockline*;

codeblockline: INDENT IF |
	INDENT decl | 
	INDENT expr | 
	INDENT assignExpr;
	
if_else: IF (conditionals|NUM) codeblock (ELSE IF (conditionals|NUM) codeblock)* (ELSE codeblock)?;

//variable identifier can be any comb of chars/nums
ID: [a-zA-Z_][a-zA-Z0-9_]*;
NUM: '0' | '-'?[1-9][0-9]*;
STRING: ['][a-z]*[']|["][a-z]*["];

ASSIGNMENTOPS: '='|'+='|'-='|'*='|'/='|'^='|'%=';

CONDITIONALS: '<'|'<='|'>'|'>='|'=='|'!=';

IF: 'IF';
ELSE: 'else';
INDENT: '\t';

//even though """ or string literals are used as comments they do not classify as one
COMMENT: '#' ~[\r\n]* -> skip;
WS : [ \r\t\n]+ -> skip;