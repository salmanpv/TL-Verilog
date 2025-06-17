\m5_TLV_version 1d: tl-x.org
\m5

\SV
   m5_makerchip_module
\TLV

|calc
   $reset = *reset;

   // 1-bit Counter to track every other cycle
   @1
      $cnt = $reset ? 1'b0 : $cnt + 1'b1;

   // Valid signal: high every other cycle
   @1
      $valid = $cnt;

   // Arithmetic Operations
   @1
      $sum = $val1 + $val2;
      $diff = $val1 - $val2;
      $prod = $val1 * $val2;
      $quot = ($val2 != 0) ? $val1 / $val2 : 32'b0;

   // Retimed MUX (as per step 4)
   @2
      case ($op)
         2'b00: $calc_result = $sum;
         2'b01: $calc_result = $diff;
         2'b10: $calc_result = $prod;
         2'b11: $calc_result = $quot;
      endcase

   // Final output every other cycle
   @2
      $out = $valid ? $calc_result : 32'b0;

\SV
   endmodule
