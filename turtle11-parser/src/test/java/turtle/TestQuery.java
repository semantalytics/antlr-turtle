package com.semantaltyics.antlr.sparql.sparql10;

import com.google.common.io.Resources;
import com.semantalytics.antlr.turtle.turtle11.Turtle11Lexer;
import com.semantalytics.antlr.turtle.turtle11.Turtle11Parser;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.stream.Collectors;

import static junit.framework.TestCase.assertTrue;
import static org.junit.runners.Parameterized.*;

@RunWith(Parameterized.class)
public class TestQuery {

    private final String fileName;

    public TestQuery(final String fileName) {
        this.fileName = fileName;
    }

    @Parameters
    public static Collection<Object[]> data() throws IOException {
        String fixturesRoot = Resources.getResource("TurtleTests").getPath();
        final Path fixturesRootPath = Paths.get(fixturesRoot);

        return Files.walk(fixturesRootPath)
                .filter(Files::isRegularFile)
                .map(path -> fixturesRootPath.relativize(path).toString())
                .filter(f -> f.endsWith(".ttl"))
                .map(f -> new Object[] {f})
                .collect(Collectors.toList());
    }

    @Test
    public void CanParse() throws IOException {
        System.out.println("Attempting to parse " + fileName);
        System.out.println("");
        Files.copy(Paths.get("./src/test/resources/TurtleTests/" + fileName), System.out);
        CharStream input = CharStreams.fromStream(new FileInputStream("./src/test/resources/TurtleTests/" +fileName));
        Turtle11Lexer lexer = new Turtle11Lexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        Turtle11Parser parser = new Turtle11Parser(tokens);
        ParseTree tree = parser.turtleDoc(); // begin parsing at query rule
        System.out.println(tree.toStringTree(parser)); // print LISP-style tree
        assertTrue(parser.getNumberOfSyntaxErrors() == 0);
    }


}
