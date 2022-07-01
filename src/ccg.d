import generator.generate;

import std.stdio;

int main()
{
    string fName = "test";
    auto gen = new Generator(fName);

    /* +++++++++++++++++++++++++++++++++++++++ */
    gen.include("stdio");
    
    /* +++++++++++++++++++++++++++++++++++++++ */
    gen.declaration!int("sum");
    gen.definition!int("i", 0);

    /* ++++++++++++++++++++++++++++++++++++++ */    
    gen.functionDeclarationInit!int("sum");

    gen.functionParamsInit();
    gen.functionParam!int("f");
    gen.functionParam!int("s");
    gen.functionParamsEnd();

    gen.functionDeclarationEnd();
    /* +++++++++++++++++++++++++++++++++++++ */

    /* +++++++++++++++++++++++++++++++++++++ */
    gen.functionDefinitionInit!int("main");

    gen.functionParamsInit();
    gen.functionParam!int("argc");
    gen.functionParam!(char**)("argv");
    gen.functionParamsEnd();

    gen.blockInit();
    gen.functionReturn!int(0);
    gen.blockEnd();

    gen.functionDefinitionEnd();
    /* ++++++++++++++++++++++++++++++++++++++ */
    
    writeln(gen.output());
    
    return 0;
}