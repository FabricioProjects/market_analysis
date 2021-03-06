//-------------------------------------------------------------------+
//|                                              Market_Analysis.mq5 |
//|                                            Copyright 2014 - 2016 |
//|                                               by Fabrício Amaral |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014 - 2016, Fabrício Amaral"
#property link      "http://executive.com.br/"
 
//+------------------------------------------------------------------+
//| ANALISE DOS DESVIOS PADROES                                      |
//+------------------------------------------------------------------+   
void Sigma_Open()
  {
   // controle de horarios
   if(str1.hour == 9 && str1.min < 30)    
     {
      Buffers_Market_Analysis();
      double price = SymbolInfoDouble(_Symbol,SYMBOL_LAST);
      Global.sigma_1 = Ind.mid_band[0] - Ind.lower_band[0];     // 1 desvio padrao
      Global.delta = MathAbs((price - Ind.mid_band[0])) - 2*Global.sigma_1;
      Global.sigma_dinamico = (Global.delta / Global.sigma_1) + 2;
      // condiçoes de alocação das maximas
      if(   
            price > Ind.mid_band[0] + 2*Global.sigma_1          // sigma superior
         || price < Ind.mid_band[0] - 2*Global.sigma_1          // sigma inferior
                                                       )
        {
         // separação entre os regimes high_volat e o low_volat
         if(Market.Regimes == true)
           {
            if(   Ind.BBandwidth_Buffer[1] >= Global.volat_mean                      // referencia da separação dos regimes
               && Global.sigma_dinamico > Global.sigma_buffer_HV[Global.sigma_i])  
              {
               Global.sigma_buffer_HV[Global.sigma_i] = Global.sigma_dinamico;       // alocação dinamica da maxima
               Global.unixtime_dinamico_sigma_HV = TimeCurrent();                    // alocação dinamica do unixtime
               Debug(" Global.sigma_buffer_HV["+(string)Global.sigma_i+"]: "
                     +(string)NormalizeDouble(Global.sigma_buffer_HV[Global.sigma_i],2) );
               // alocação do first_sigma_HV
               if(Flag.first_sigma_HV == false)
                 {
                  First_Sigma_HV((string)Global.sigma_dinamico);
                  Horario_First_Sigma_HV((string)((TimeCurrent() - Global.first_tick_unixtime)/60)); 
                  Flag.first_sigma_HV = true;
                 } 
               // calculo da transformação entre sigma e price para estimar o stop loss
               if(   Market.Sigma_sl_Factor_HV == true
                  && (str1.hour == 9 && str1.min < 30) )   //  somente o primeiro candle (analise da abertura)
                 { 
                  Sigma_sl_Factor_HV();                          // ##Market_Analysis_Misc##
                 } 
              }
            if(   Ind.BBandwidth_Buffer[1] < Global.volat_mean                       // referencia da separação dos regimes
               && Ind.BBandwidth_Buffer[1] > Global.volat_min                        // volat minima media
               && Global.sigma_dinamico > Global.sigma_buffer_LV[Global.sigma_i]) 
              {  
               Global.sigma_buffer_LV[Global.sigma_i] = Global.sigma_dinamico;       // alocação dinamica da maxima
               Global.unixtime_dinamico_sigma_LV = TimeCurrent();                    // alocação dinamica do unixtime
               Debug(" Global.sigma_buffer_LV["+(string)Global.sigma_i+"]: "
                     +(string)NormalizeDouble(Global.sigma_buffer_LV[Global.sigma_i],2));     
               // alocação do first_sigma_LV
               if(Flag.first_sigma_LV == false)
                 {
                  First_Sigma_LV((string)Global.sigma_dinamico);
                  Horario_First_Sigma_LV((string)((TimeCurrent() - Global.first_tick_unixtime)/60));
                  Flag.first_sigma_LV = true;
                 }       
               // calculo da transformação entre sigma e price para estimar o stop loss
               if(Market.Sigma_sl_Factor_LV == true)
                 {
                  if(str1.hour == 9 && str1.min < 30){Sigma_sl_Factor_LV();}              // somente abertura
//                  if((str1.hour == 9 && str1.min > 30) || str1.hour > 9){Sigma_sl_Factor_LV();}   // analise apos abertura
                 } 
              }
           }
         //  sem separação de regimes  
         if(   Market.Regimes == false
            && Global.sigma_dinamico > Global.sigma_buffer[Global.sigma_i])
           {
            Global.sigma_buffer[Global.sigma_i] = Global.sigma_dinamico;             // alocação dinamica da maxima
            Global.unixtime_dinamico_sigma = TimeCurrent();                          // alocação dinamica do unixtime
            Debug(" Global.sigma_buffer["+(string)Global.sigma_i+"]: "
                  +(string)NormalizeDouble(Global.sigma_buffer[Global.sigma_i],2) );
           }    
        }  
     }
      
   }  // fim da Sigma_Open()
     
       
