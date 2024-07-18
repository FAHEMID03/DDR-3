//***************************************************************************************************************************//
*                                       -*- Mode: system Verilog -*-
*    Author          : SK ABDUL FAHEMID
*    File Name       :  Tb_Generator.sv
*      Version       :  1.0
*        Model       : tb_generator.sv
*    Created On      : Thr July  18 09:20:39 2024
*				 
**Dependencies:  Tb_generator.sv
*				 DDR3MemPkg.sv
*				 
*
*  Description: create a class for  tb_generator.sv

//*****************************************************************************************************************************//
  /*
`include "tb_transaction.sv"
*/
                            //////////////////////////////// Generator class /////////////////////////
  package generator_p;
    import transection_p::*;
    class generator;
      //declaring a transection class
      rand transection trans;

      //declaring a mail box
      mailbox gen2driv

      //repet count,to specify number of item to generate
      int repeat_count;

      //event
      event ended;

      // constructor
      function new (mailbox gen2driv,event ended);
        //getting the mailboxhandle from the env

        this.gen2driv = gen2driv;
        this.ended = ended;
      endfunction

      //main task generate(create and randomize)the repeat count number of transection packetand put into the mailbox
      task main()
        repeat (repeat_count)begin
          trans = new();
          if(!trans.randomize())$fatal("Gen::transection randomize failed");
          gen2driv.put(trans);
        end
        -> ended;
      endtask
    endclass

    endpackage

  
