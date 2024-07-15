//***************************************************************************************************************************
*                                       -*- Mode: system Verilog -*-
*    Author          : SK ABDUL FAHEMID
*    File Name       :  Burst.sv
*      Version       :  1.0
*        Model       :  Write burst
*    Created On      : Sat July  13 17:40:49 2024
*				 
* Description:  Performs the burst operation by writing by taking 16 bits per clock cycle as inputs
*				 Sends 8 bits of data at every clock edge to the memory.

*****************************************************************************************************************************//
module writeburst #(parameter BW=8)(             //write burst
         input logic       clock,                //input clock
         input logic        reset,               // input reset
        input logic [2*BW-1:0] data,             //input data memory controller
         input logic  valid_in,                  // input reset
         output logic [BW-1:0] out,              // data out in 8 bits
         output logic  valid_out );              // valid data out signal

         logic[BW-1:0]temp1;                     //Temperory  variable to store output data 
         logic[BW-1:0]temp2;                     // Temperory variable to store output data.
        logic valid_out1,valid_out2              //valid signal for temp1 and temp2 data is valid

//**************************************************************************************************************************//

assign out = (clock) ? temp2 : temp1;            //sending out data as it is center aligned for write 

assign  valid_out = (valid out1 & valid out2);   //valid is asserted high if both the temp1 and temp2 valid signal is high

//***************************************************************************************************************************//

//to be trackof the data to be sending to memory at every posedge and negdedge by setting a valid signal

always_ff @ (negedge clock) begin : proc_valid1
 if (reset)begin                                  // if negedge of clock reset is assigned to 0
valid_out1 <=0 ;
end
else begin
valid_out1 <= valid_in;                            // valid signal of the memory controller 
end
end
always_ff @(posedge clock) begin :proc_valid2      // valid signal for data
if(reset)begin                                     // in negedge of clock is reset valid is assigned to 0
valid_out2 <= 0;
end else begin
valid_out2 <= valid_in;                            // valid signal fromn memory controller 
end
end
//********************************************************************************************************************************//
//send the data to Memory in chunks of 8 bits in every posedge and negedge of Clock Cycle
	always @ (posedge clock) begin            //Capturing LSB of 8 bits in posedge of clock
		if(valid_in)
			temp1 <= data[BW-1:0];
	end
	always @ (negedge clock) begin            //Capturing MSB of 8 bits in negedge of clock
		if(valid_in)
			temp2 <= data[2*BW-1:BW];
	end

//==================================================================================================================================================
endmodule:WriteBurst










