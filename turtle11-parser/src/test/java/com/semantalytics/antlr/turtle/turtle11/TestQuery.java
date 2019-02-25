package com.semantalytics.antlr.turtle.turtle11;

import com.google.common.io.Resources;
import com.semantalytics.antlr.turtle.turtle11.Turtle11Lexer;
import com.semantalytics.antlr.turtle.turtle11.Turtle11Parser;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.query.QuerySolution;
import org.apache.jena.query.ResultSet;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.riot.Lang;
import org.apache.jena.riot.RDFDataMgr;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.Spliterator;
import java.util.Spliterators;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

import static junit.framework.TestCase.assertTrue;
import static org.junit.runners.Parameterized.*;

@RunWith(Parameterized.class)
public class TestQuery {

    private final String fileName;
    public TestQuery(final String fileName) {
        this.fileName = fileName;
    }
    private static Model model = ModelFactory.createDefaultModel();

    static {
        try {
            model.read(Resources.getResource("TurtleTests/manifest.ttl").openStream(),Resources.getResource("TurtleTests/manifest.ttl").toExternalForm(), "TURTLE");
        } catch(IOException e) {
        }
    }

    @Parameters
    public static Collection<Object[]> data() throws IOException {

        final String query =
                "prefix mf: <http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#> " +
                "prefix rdft:   <http://www.w3.org/ns/rdftest#>" +
                "select ?action where { [ ] a rdft:TestTurtlePositiveSyntax; mf:action ?action . }";
        try(QueryExecution queryExecution = QueryExecutionFactory.create(query, model)) {
            final ResultSet resultSet  = queryExecution.execSelect();
            return StreamSupport.stream(Spliterators.spliteratorUnknownSize(resultSet, Spliterator.ORDERED), false).map(qs->qs.getResource("action")).map(f -> new Object[]{f.getURI()}).collect(Collectors.toList());

        }
    }

    @Test
    public void CanParse() throws IOException, URISyntaxException {
        System.out.println("Attempting to parse " + fileName);
        System.out.println("");
        CharStream input = CharStreams.fromFileName(new URL(fileName).toURI().getPath());
        Turtle11Lexer lexer = new Turtle11Lexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        Turtle11Parser parser = new Turtle11Parser(tokens);
        ParseTree tree = parser.turtleDoc(); // begin parsing at query rule
        System.out.println(tree.toStringTree(parser)); // print LISP-style tree
        assertTrue(parser.getNumberOfSyntaxErrors() == 0);
    }


}
