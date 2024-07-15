//***************************************************************************************************************************
*                                       -*- Mode: system Verilog -*-
*    Author          : SK ABDUL FAHEMID
*    File Name       : Data_O_Burst.sv
*      Version       :  1.0
*        Model       :  Read Burst 
*    Created On      : Mon July  15 12:57:49 2024
*				 
* Description:  Receives 8 bits per clock edge from the memory.
*				 After one clock cycle, concatenates the 8 bits to for a 16 bit output.
*
* Rev   Author   Date        Changes
* ---------------------------------------------------------------------------------------
* 0.1    SAF      07/12/24    FSM design
* 0.42   SAF      07/13/24    Created internal clock using ck and ck_n.

//*****************************************************************************************************************************//

  module read_burst #(parameter BW = 8)(input logic clock, //Read brust from memory to memory controller
                                        input logic [BW-1:0]data_in,
                                        output logic[BW*2-1:0]out);

    //************************************************ LOCAL Variable ***********************************************************//

    logic[BW-1:0] temp1;                  //Temprory variable to storeoutput data
    logic[BW-1:0] temp2;                  //Data Assigned to CPU only if valid out is set
    logic valid_out;

    //************************************************* *************************************************************************//
    //DRAM buffer ,at every posedge and negedge of clk we capture 8 bit of data and send it to 16 bit of data in every clock cycleto memory controller
    always@(posedge clk) begin   // in the posdge of the clockwe store 8 bit of data in temp2
      temp <= data_in;
    end
    always@(negedge clk)begin   //in the negedge of the clock we store 8 bit of data in temp2
      temp <=data_in;
    end
    always_ff @(negedge clk)begin //In the posedge of the clock we send the 16 bit of data
      out <= {temp2, temp1};
    end
  endmodule //read burst
    
