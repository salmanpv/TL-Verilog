\m5_TLV_version 1d: tl-x.org
\m5

\SV
   m5_makerchip_module
\TLV
   $reset = *reset;

   // Free-running counter
   $counter[31:0] = $reset ? 0 : (>>1$counter + 1);

   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
