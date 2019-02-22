parser grammar turtle11Parser;

options { tokenVocab=turtle11Lexer; }

/* [1] */
turtleDoc
   : statement*
   ;

/* [2] */
statement
   : directive
   | triples DOT
   ;

/* [3] */
directive
   : prefixID
   | base
   | sparqlPrefix
   | sparqlBase
   ;

/* [4] */
prefixID
   : AT PREFIX PNAME_NS IRIREF DOT
   ;

/* [5] */
base
   : AT BASE IRIREF DOT
   ;

/* [5s] */
sparqlBase
   : BASE IRIREF
   ;

/* [6s] */
sparqlPrefix
   : PREFIX PNAME_NS IRIREF
   ;

/* [6] */
triples
   : subject predicateObjectList
   | blankNodePropertyList predicateObjectList?
   ;

/* [7] */
predicateObjectList
   : verb objectList ( SEMICOLON ( verb objectList )? )*
   ;

/* [8] */
objectList
   : object ( COMMA object )*
   ;

/* [9] */
verb
   : predicate
   | A
   ;

/* [10] */
subject
   : iri
   | blankNode
   | collection
   ;

/* [11] */
predicate
   : iri
   ;

/* [12] */
object
   : iri
   | blankNode
   | collection
   | blankNodePropertyList
   | literal
   ;

/* [13] */
literal
   : rdfLiteral
   | numericLiteral
   | booleanLiteral
   ;

/* [14] */
blankNodePropertyList
   : OPEN_SQUARE_BRACE predicateObjectList CLOSE_SQUARE_BRACE
   ;

/* [15] */
collection
   : OPEN_BRACE object* CLOSE_BRACE
   ;

/* [16] */
numericLiteral
   : INTEGER
   | DECIMAL
   | DOUBLE
   ;

/* [128s] */
rdfLiteral
   : String ( LANGTAG | REFERENCE iri )?
   ;

/* [133s] */
booleanLiteral
   : TRUE
   | FALSE
   ;

/* [17] */
string
   : STRING_LITERAL_QUOTE
   | STRING_LITERAL_SINGLE_QUOTE
   | STRING_LITERAL_LONG_SINGLE_QUOTE
   | STRING_LITERAL_LONG_QUOTE
   ;

/* [135s] */
iri
   : IRIREF
   | prefixedName
   ;

/* [136s] */
prefixedName
   : PNAME_LN
   | PNAME_NS
   ;

/* [137s] */
blankNode
   : BLANK_NODE_LABEL
   | ANON
   ;
