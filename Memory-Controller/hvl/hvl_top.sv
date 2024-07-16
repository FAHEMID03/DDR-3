//***************************************************************************************************************************//
*                                       -*- Mode: system Verilog -*-
*    Author          : SK ABDUL FAHEMID
*    File Name       :  HVL_TOP.sv
*      Version       :  1.0
*        Model       : HVL_TOP
*    Created On      : Tue July  16 12:10:39 2024
*				 
**Dependencies:  HVL.sv
*				 DDR3MemPkg.sv
*				 
*
*  Description:  Hvl_top.sv for memory interface

//*****************************************************************************************************************************//

  //`timescale 1ps/1ps
  class top;
    virtual mem_intf intf;
    task set_vif(virtual mem_intf intf);
      this.intf = intf;
    endtask
  endclass
  module hvltop
/* clock and reset signal declaration 
bit clock;
bit reset;
//clock generation 
always #5 clk=~ clk;
// reset generation
initial begin
reset=1;
#5 reset=0;
#1000 $stop;

end
*/
    //create instances  of interface ,  in order to connect DUT and testcase 
    //hdltop.cpu_contr intf/*(hdltop.i_cpu_ck)*/;

    top inst;
    initial begin
      inst = new;
      inst.set_vif(hdltop.cpu_contr);
    end

    //Testcase instance, interface hendel is passed to test as an argument

    test t1(hdltop.cpu_contr);
  endmodule
    

    









    
