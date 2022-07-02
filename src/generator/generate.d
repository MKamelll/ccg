module generator.generate;

import std.conv;
import std.array;
import std.stdio;

class Generator
{
    private string mFileName;
    private string mProgram;

    this (string fileName) {
        mFileName = fileName ~ ".c";
    }

    private void endOfLine() {
        mProgram ~= "\n";
    }

    private void semiColon() {
        mProgram ~= ";";
    }

    private void space(int num = 1) {
        for (int i = 0; i < num; i++) {
            mProgram ~= " ";
        }
    }

    private void type(T)() {
        append(to!string(typeid(T)));
    }

    private void append(string apppendee) {
        mProgram ~= apppendee;
    }

    private void append(T)(T appendee) {
        try {
            mProgram ~= to!string(appendee);
        } catch (Exception ex) {
            writeln("Type '" ~ to!string(typeid(T)) ~ "' cannot be converted to type 'string'");
        }
    }

    private void pop(int num) {
        for (int i = 0; i < num; i++) mProgram.popBack();
    }

    void declaration(T)(string varName) {
        append(to!string(typeid(T)));
        space();
        append(varName);
        semiColon();
        endOfLine();
    }

    void declaration(string T)(string varName) {
        append(T);
        space();
        append(varName);
        semiColon();
        endOfLine();
    }

    void definition(T)(string varName, T value) {
        type!T;
        space();
        append(varName);
        space();
        append("=");
        space();
        append(to!string(value));
        semiColon();
        endOfLine();
    }

    void include(string fileName) {
        append("#include<");
        append(fileName);
        append(".h>");
        endOfLine();
    }

    void includeLocal(string fileName) {
        append("#include \"");
        append(fileName);
        append("\".h");
        endOfLine();
    }

    string param(T)(T value) {
        string result = "";
        result ~= to!string(typeid(T));
        result ~= " ";
        result ~= to!string(value);

        return result;
    }

    void functionDeclarationInit(T)(string funName) {
        type!T;
        space();
        append(funName);
    }

    void functionParamsInit() {
        append("(");
    }

    void functionParam(T)(string name) {
        type!T;
        space();
        append(name);
        append(", ");
    }

    void functionParamsEnd() {
        // remove last ", "
        pop(2);
        append(")");
    }

    void functionDeclarationEnd() {
        semiColon();
        endOfLine();
    }

    void functionDefinitionInit(T)(string name) {
        type!T;
        space();
        append(name);
    }

    void blockInit() {
        endOfLine();
        append("{");
        endOfLine();
    }

    void blockEnd() {
        endOfLine();
        append("}");
    }

    void functionDefinitionEnd() {
        endOfLine();
    }

    void functionReturn(T)(T value) {
        append("return");
        space();
        append(value);
        semiColon();
    }

    void structDeclarationInit(string name) {
        append("struct");
        space();
        append(name);
    }

    void structDeclarationEnd() {
        semiColon();
        endOfLine();
    }

    void structDefinitionInit(string name) {
        append("struct");
        space();
        append(name);
    }

    void structDefinitionEnd() {
        semiColon();
        endOfLine();
    }

    void functionArgInit() {
        append("(");
    }

    void functionArg(T)(T value) {
        if (is(T == string)) {
            append("\"");
            append(value);
            append("\"");
            append(", ");
            return;
        }
        
        append(to!string(value));
        append(", ");
    }

    void functionArgEnd() {
        pop(2);
        append(")");
    }

    void functionCallInit(string name) {
        append(name);
    }

    void functionCallEnd() {
        semiColon();
        endOfLine();
    }

    string output() {
        return mProgram;
    }
}