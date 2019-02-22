/*
 [The "BSD licence"]
 Copyright (c) 2014, Alejandro Medrano (@ Universidad Politecnica de Madrid, http://www.upm.es/)
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. The name of the author may not be used to endorse or promote products
    derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
*/
/* Derived from http://www.w3.org/TR/turtle/#sec-grammar-grammar */

parser grammar turtle11Parser;

/* [1] */
turtleDoc
   : statement*
   ;

/* [2] */
statement
   : directive
   | triples DOT
   ;

directive
   : prefixID
   | base
   | sparqlPrefix
   | sparqlBase
   ;

prefixID
   : AT PREFIX PNAME_NS IRIREF DOT
   ;

base
   : AT BASE IRIREF DOT
   ;

sparqlBase
   : BASE IRIREF
   ;

sparqlPrefix
   : PREFIX PNAME_NS IRIREF
   ;

triples
   : subject predicateObjectList
   | blankNodePropertyList predicateObjectList?
   ;

predicateObjectList
   : verb objectList (SEMICOLON (verb objectList)?)*
   ;

objectList
   : object (COMMA object)*
   ;

verb
   : predicate
   | 'a'
   ;

subject
   : iri
   | blankNode
   | collection
   ;

predicate
   : iri
   ;

object
   : iri
   | blankNode
   | collection
   | blankNodePropertyList
   | literal
   ;

literal
   : rdfLiteral
   | numericLiteral
   | booleanLiteral
   ;

blankNodePropertyList
   : OPEN_SQUARE_BRACE predicateObjectList CLOSE_SQUARE_BRACE
   ;

collection
   : OPEN_BRACE object* CLOSE_BRACE
   ;

numericLiteral
   : INTEGER
   | DECIMAL
   | DOUBLE
   ;

rdfLiteral
   : String ( LANGTAG | REFERENCE iri )?
   ;

booleanLiteral
   : TRUE
   | FALSE
   ;

string
   : STRING_LITERAL_QUOTE
   | STRING_LITERAL_SINGLE_QUOTE
   | STRING_LITERAL_LONG_SINGLE_QUOTE
   | STRING_LITERAL_LONG_QUOTE
   ;

iri
   : IRIREF
   | prefixedName
   ;

blankNode
   : BLANK_NODE_LABEL
   | ANON
   ;

prefixedName
   : PNAME_LN | PNAME_NS
   ;
