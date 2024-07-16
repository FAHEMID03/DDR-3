//***************************************************************************************************************************//
*                                       -*- Mode: system Verilog -*-
*    Author          : SK ABDUL FAHEMID
*    File Name       :  counter.sv
*      Version       :  1.0
*        Model       : Internal delay counter
*    Created On      : Tue July  16 10:30:49 2024
*				 
**  Description:  Acts as a down counter to generate the delay for obeying the timing specifications.
*
* Rev   Author   Date        Changes
* ---------------------------------------------------------------------------------------
* 0.1    SAF      07/16/24    FSM design
* 0.42  SAF      07/15/24    Created internal clock using ck and ck_n.

//*****************************************************************************************************************************//

  module counter(                                           //counter module
    input logic          clock ,                            //clock for the counter from Emulator
    input logic           reset,                            //reset
    input logic              en,                            //counter enable
    input logic[31:0]  max_count,                           //set the counter to the max value
    output bit              done,                           //if done, counter has reached it's maximum count value
    output logic[31:0]     count                            //counter is active when enable signal is on and counts till itreach max_count
  ); 
//****************************************************************************************************************************//
    // counter for DDR3 memory model depending on the max_count value set the counter get incremented  and when count==max_count-1 then the done signal is 
    //asserted
    always@(posedge clk)begin  // Activates at posedge of clock
      if((reset) | (count==max_count-1))  //if reset or reachs max_count value reset the counter value to  0
        count <= 0;    //assing the counter value to zero if above condition is true
      else if (en)    //if enable is high counter start contuning its value at every positive clock edge
        count <= count+1;  // count get incremented when  enable signal is high and reaches to max_count-1
    end
    assign done =(count==max_count-1); //assign the done =1 when counter reachs its max value
  endmodule     // end of counter value











    8
    
