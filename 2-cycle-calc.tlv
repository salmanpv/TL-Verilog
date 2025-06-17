\m5_TLV_version 1d: tl-x.org
\m5
   
   // ============================================
   // Welcome, new visitors! Try the "Learn" menu.
   // ============================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
   
   |calc
      @1  
         //$val2[31:0] = 32'b0001;
         $val2[31:0] = $rand1[3:0];
         //$val2[31:0] = 32'b0001;
         $val1[31:0] = >>2$outf;
         //$op[1:0]    = $rand2[1:0]; // Random operation selection
         $op[1:0]    = 2'b00;
         $counter[31:0] = $reset ? 0 : (>>1$counter + 1);
         //$cnt = $reset ? 1'b0 : ~$cnt;
         // ALU Operations
         $sum[31:0]  = $val1 + $val2;
         $diff[31:0] = $val1 - $val2;
         $prod[31:0] = $val1 * $val2;
         $quot[31:0] = $val1 / $val2;
      @2
         // 4:1 Mux based on operation select
         $out[31:0] = ($op == 2'b00) ? $sum :
                      ($op == 2'b01) ? $diff :
                      ($op == 2'b10) ? $prod :
                                       $quot; // default: division
         $valid = $counter;
         $or = $reset || ~$valid;
         //$outf = $or ? 32'b0 : $out;
         $outf = $or ? 32'b0 : $out;
   
   // Assert these to end simulation (before the cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
