lexer grammar turtle11Lexer;

DOT
   : '.'
   ;

fragment
AT
    : '@'
    ;

PREFIX
   : ('P'|'p')('R'|'r')('E'|'e')('F'|'f')('I'|'i')('X'|'x')
    ;

BASE
   : ('B'|'b')('A'|'a')('S'|'s')('E'|'e')
   ;

SEMICOLON
    : ';'
    ;

COMMA
    : ','
    ;

A
    : 'a'
    ;

OPEN_SQUARE_BRACE
    : '['
    ;

CLOSE_SQUARE_BRACE
    : ']'
    ;

OPEN_BRACE
    : '('
    ;

CLOSE_BRACE
    : ')'
    ;

REFERENCE
    : '^^'
    ;

TRUE
    : ('T'|'t')('R'|'r')('U'|'u')('E'|'e')
    ;

FALSE
    : ('F'|'f')('A'|'a')('L'|'l')('S'|'s')('E'|'e')
    ;

/* [18] */
IRIREF
   : '<' (PN_CHARS | '.' | ':' | '/' | '\\' | '#' | '@' | '%' | '&' | UCHAR)* '>'
   ;

/* [139s] */
PNAME_NS
   : PN_PREFIX? ':'
   ;

/* [140s] */
PNAME_LN
   : PNAME_NS PN_LOCAL
   ;

/* [141s] */
BLANK_NODE_LABEL
   : '_:' (PN_CHARS_U | ('0'..'9')) ((PN_CHARS | DOT)* PN_CHARS)?
   ;

/* [144s] */
LANGTAG
   : AT [a-zA-Z] + ('-' [a-zA-Z0-9] +)*
   ;

/* [19] */
INTEGER
   : [+-]? [0-9] +
   ;

/* [20] */
DECIMAL
   : [+-]? [0-9]* DOT [0-9] +
   ;

/* [21] */
DOUBLE
   : [+-]? ([0-9] + DOT [0-9]* EXPONENT | DOT [0-9] + EXPONENT | [0-9] + EXPONENT)
   ;

/* [154s] */
EXPONENT
   : [eE] [+-]? [0-9] +
   ;

/* [22] */
STRING_LITERAL_QUOTE
   : '"' (~ ["\\\r\n] | '\'' | '\\"')* '"'
   ;

/* [23] */
STRING_LITERAL_SINGLE_QUOTE
   : '\'' ( ~('\u0027' | '\u005C' | '\u000A' | '\u000D') | ECHAR | UCHAR | '"')* '\''
   ;

/* [24] */
STRING_LITERAL_LONG_SINGLE_QUOTE
   : '\'\'\'' (('\'' | '\'\'')? ([^'\\] | ECHAR | UCHAR | '"'))* '\'\'\''
   ;

/* [25] */
STRING_LITERAL_LONG_QUOTE
   : '"""' (('"' | '""')? (~ ["\\] | ECHAR | UCHAR | '\''))* '"""'
   ;

/* [26] */
UCHAR
   : '\\u' HEX HEX HEX HEX
   | '\\U' HEX HEX HEX HEX HEX HEX HEX HEX
   ;

/* [159s] */
ECHAR
   : '\\' [tbnrf"'\\]
   ;

/* [161s] */
WS
   : ' '
   | '\t'
   | '\r'
   | '\n'
   ;

/* [162] */
ANON
   : '[' WS* ']'
   ;

/* [163s] */
PN_CHARS_BASE
    : 'A' .. 'Z'
    | 'a' .. 'z'
    | '\u00C0' .. '\u00D6'
    | '\u00D8' .. '\u00F6'
    | '\u00F8' .. '\u02FF'
    | '\u0370' .. '\u037D'
    | '\u037F' .. '\u1FFF'
    | '\u200C' .. '\u200D'
    | '\u2070' .. '\u218F'
    | '\u2C00' .. '\u2FEF'
    | '\u3001' .. '\uD7FF'
    | '\uF900' .. '\uFDCF'
    | '\uFDF0' .. '\uFFFD'
    ;

/* [164s] */
PN_CHARS_U
   : PN_CHARS_BASE
   | '_'
   ;

/* [166s] */
PN_CHARS
   : PN_CHARS_U
   | '-'
   | ('0'..'9')
   | '\u00B7'
   | '\u0300'..'\u036F'
   | '\u203F'..'\u2040'
   ;

/* [167s] */
PN_PREFIX
    : PN_CHARS_BASE ((PN_CHARS | '.')* PN_CHARS)?
    ;

/* [168s] */
PN_LOCAL
   : (PN_CHARS_U | ':' | ('0'..'9') | PLX) ((PN_CHARS | DOT | ':' | PLX)* (PN_CHARS | ':' | PLX))?
   ;

/* [169s] */
PLX
   : PERCENT
   | PN_LOCAL_ESC
   ;

/* [170s] */
PERCENT
   : '%' HEX HEX
   ;

/* [171s] */
HEX
   : ('0'..'9')
   | ('A'..'F')
   | ('a'..'f')
   ;

/* [172s] */
PN_LOCAL_ESC
   : '\\' ('_' | '~' | '.' | '-' | '!' | '$' | '&' | '\'' | '(' | ')' | '*' | '+' | ',' | ';' | '=' | '/' | '?' | '#' | '@' | '%')
   ;
