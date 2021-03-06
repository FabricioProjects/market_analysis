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
void Sigma_NY()
  {
   // controle de horarios
   if(   (str1.hour == 9 && str1.min  > 30)
      || (str1.hour >  9 && str1.hour < 14) )    
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
               && Global.sigma_dinamico > Global.sigma_buffer_HV_NY[Global.sigma_i])  
              {
               Global.sigma_buffer_HV_NY[Global.sigma_i] = Global.sigma_dinamico; // alocação dinamica da maxima
               Global.unixtime_dinamico_sigma_HV_NY = TimeCurrent();              // alocação dinamica do unixtime
               Debug(" Global.sigma_buffer_HV_NY["+(string)Global.sigma_i+"]: "
                     +(string)NormalizeDouble(Global.sigma_buffer_HV_NY[Global.sigma_i],2) );
              }
            if(   Ind.BBandwidth_Buffer[1] < Global.volat_mean                       // referencia da separação dos regimes
               && Ind.BBandwidth_Buffer[1] > Global.volat_min                        // volat minima media
               && Global.sigma_dinamico > Global.sigma_buffer_LV_NY[Global.sigma_i]) 
              {  
               Global.sigma_buffer_LV_NY[Global.sigma_i] = Global.sigma_dinamico; // alocação dinamica da maxima
               Global.unixtime_dinamico_sigma_LV_NY = TimeCurrent();              // alocação dinamica do unixtime
               Debug(" Global.sigma_buffer_LV_NY["+(string)Global.sigma_i+"]: "
                     +(string)NormalizeDouble(Global.sigma_buffer_LV_NY[Global.sigma_i],2));    
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
      
   }  // fim da Sigma_NY()
     
       
           