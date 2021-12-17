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
	| '(' expr ')'
	| ID
	| NUM
	;

assignExpr: ID ASSIGNMENTOPS expr;

conditionals: expr CONDITIONALS expr; 

codeblock: codeblockline*;

codeblockline: INDENT if_else |
	INDENT decl | 
	INDENT expr | 
	INDENT assignExpr |
	INDENT while_stat |
	INDENT for_stat;
	
if_else: IF (conditionals|NUM) ':' codeblock (ELSE IF (conditionals|NUM) ':' codeblock)* (ELSE ':' codeblock)?;
while_stat: WHILE (conditionals|NUM) codeblock; 
for_stat: FOR ID IN (ID|STRING) ':' codeblock; 

//variable identifier can be any comb of chars/nums
ID: [a-zA-Z_][a-zA-Z0-9_]*;
NUM: '0' | '-'?[1-9][0-9]*;
STRING: ['][a-z]*[']|["][a-z]*["];

ASSIGNMENTOPS: '='|'+='|'-='|'*='|'/='|'^='|'%=';

CONDITIONALS: '<'|'<='|'>'|'>='|'=='|'!=';

IF: 'if';
ELSE: 'else';
FOR: 'for';
IN: 'in';
WHILE: 'while'; 
INDENT: '\t';

//even though """ or string literals are used as comments they do not classify as one
COMMENT: '#' ~[\r\n]* -> skip;
WS : [ \r\t\n]+ -> skip;