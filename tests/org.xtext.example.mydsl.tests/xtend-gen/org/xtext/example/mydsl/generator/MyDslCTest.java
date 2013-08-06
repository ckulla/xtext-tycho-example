package org.xtext.example.mydsl.generator;

import java.io.File;
import java.util.ArrayList;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TemporaryFolder;
import org.xtext.example.mydsl.generator.MyDslC;

@SuppressWarnings("all")
public class MyDslCTest {
  @Rule
  public TemporaryFolder temporaryFolder = new Function0<TemporaryFolder>() {
    public TemporaryFolder apply() {
      TemporaryFolder _temporaryFolder = new TemporaryFolder();
      return _temporaryFolder;
    }
  }.apply();
  
  @Test
  public void testOk() {
    File _root = this.temporaryFolder.getRoot();
    String _path = _root.getPath();
    ArrayList<String> _newArrayList = CollectionLiterals.<String>newArrayList("-outputDir", _path, "models/test.mydsl");
    int _run = MyDslC.run(((String[])Conversions.unwrapArray(_newArrayList, String.class)));
    Assert.assertEquals(0, _run);
    File _root_1 = this.temporaryFolder.getRoot();
    File _file = new File(_root_1, "test.txt");
    boolean _exists = _file.exists();
    Assert.assertTrue(_exists);
  }
  
  @Test
  public void testNoArgs() {
    ArrayList<String> _newArrayList = CollectionLiterals.<String>newArrayList();
    int _run = MyDslC.run(((String[])Conversions.unwrapArray(_newArrayList, String.class)));
    Assert.assertEquals(1, _run);
  }
  
  @Test
  public void testHelp() {
    ArrayList<String> _newArrayList = CollectionLiterals.<String>newArrayList("-help");
    int _run = MyDslC.run(((String[])Conversions.unwrapArray(_newArrayList, String.class)));
    Assert.assertEquals(0, _run);
  }
  
  @Test
  public void testNoInputFiles() {
    File _root = this.temporaryFolder.getRoot();
    String _path = _root.getPath();
    ArrayList<String> _newArrayList = CollectionLiterals.<String>newArrayList("-outputDir", _path);
    int _run = MyDslC.run(((String[])Conversions.unwrapArray(_newArrayList, String.class)));
    Assert.assertEquals(1, _run);
  }
  
  @Test
  public void testInvalidInputFile() {
    File _root = this.temporaryFolder.getRoot();
    String _path = _root.getPath();
    ArrayList<String> _newArrayList = CollectionLiterals.<String>newArrayList("-outputDir", _path, "models/_test.mydsl");
    int _run = MyDslC.run(((String[])Conversions.unwrapArray(_newArrayList, String.class)));
    Assert.assertEquals(1, _run);
  }
}
