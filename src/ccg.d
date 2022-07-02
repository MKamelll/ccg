import generator.generate;

import std.stdio;

int main()
{
    string fName = "test";
    auto gen = new Generator(fName);

    /* +++++++++++++++++++++++++++++++++++++++ */
    gen.include("stdio");

    /* +++++++++++++++++++++++++++++++++++++ */

    gen.structDefinitionInit("Node");

        gen.blockInit();

            gen.declaration!int("data");
            gen.declaration!("struct Node*")("next");

        gen.blockEnd();

    gen.structDefinitionEnd();

    /* +++++++++++++++++++++++++++++++++++++ */
    
    gen.functionDefinitionInit!int("main");

    gen.functionParamsInit();
    
        gen.functionParam!int("argc");
        gen.functionParam!(char**)("argv");
    
    gen.functionParamsEnd();

        gen.blockInit();

            gen.functionCallInit("printf");
                gen.functionArgInit();
                    gen.functionArg!string("%s\\n");
                    gen.functionArg!string("Hello World!");
                gen.functionArgEnd();
            gen.functionCallEnd();
            
            gen.functionReturn!int(0);
    
        gen.blockEnd();

    gen.functionDefinitionEnd();
    
    /* ++++++++++++++++++++++++++++++++++++++ */
    
    writeln(gen.output());
    
    return 0;
}