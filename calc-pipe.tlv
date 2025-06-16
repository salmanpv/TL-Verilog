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
         $counter[31:0] = $reset ? 0 : (>>1$counter + 1);
            // ALU Operations
         $sum[31:0]  = $val1 + $val2;
         $diff[31:0] = $val1 - $val2;
         $prod[31:0] = $val1 * $val2;
         $quot[31:0] = $val1 / $val2;

         // 4:1 Mux based on operation select
         $out[31:0] = ($op == 2'b00) ? $sum :
                   ($op == 2'b01) ? $diff :
                   ($op == 2'b10) ? $prod :
                                    $quot; // default: division
         $val1[31:0] = $rand1[3:0];
         $val2[31:0] = $rand2[3:0];
         $op[1:0]    = $rand3[1:0]; // Random operation selection
   
   // Assert these to end simulation (before the cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
