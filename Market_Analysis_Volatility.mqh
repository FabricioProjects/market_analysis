//-------------------------------------------------------------------+
//|                                              Market_Analysis.mq5 |
//|                                            Copyright 2014 - 2016 |
//|                                               by Fabrício Amaral |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014 - 2016, Fabrício Amaral"
#property link      "http://executive.com.br/"

//+------------------------------------------------------------------+
//| ANALISE DA VOLATILIDADE                                          |
//+------------------------------------------------------------------+   
void Volatilidade()
  {
   // janela inteira
   if(   
         str1.hour >= 9                           
      && str1.hour <  17 
                         )    
     {
      Buffers_Market_Analysis();
      // condiçoes de alocação das maximas
      if(   
            Ind.BBandwidth_Buffer[0] > Global.volat_referencia
         && Ind.BBandwidth_Buffer[0] > Global.volat_buffer_max[Global.volat_i]
                                                                                )
        {
         Global.volat_buffer_max[Global.volat_i] = Ind.BBandwidth_Buffer[0];    // alocação dinamica da maxima
         Global.unixtime_dinamico_max_volat = TimeCurrent();                    // alocação dinamica do unixtime
         Debug(" Global.volat_buffer_max["+(string)Global.volat_i+"]: "+(string)Global.volat_buffer_max[Global.volat_i] );
        }
      // condiçoes de alocação das minimas  
      if(   
            Ind.BBandwidth_Buffer[0] < Global.volat_referencia
         && Ind.BBandwidth_Buffer[0] < Global.volat_buffer_min[Global.volat_i]
                                                                                )
        {
         Global.volat_buffer_min[Global.volat_i] = Ind.BBandwidth_Buffer[0];    // alocação dinamica da minima
         Global.unixtime_dinamico_min_volat = TimeCurrent();                    // alocação dinamica do unixtime
         Debug(" Global.volat_buffer_min["+(string)Global.volat_i+"]: "+(string)Global.volat_buffer_min[Global.volat_i] );
        }    
     }
     
   // alocação final da volatilidade do dia
   if(  
         str1.hour == 17 && str1.min >= 0
      && str1.hour == 17 && str1.min <= 8     
      && Flag.volat_alloc == false   
                                           ) 
     {
      // alocaçao da volat max 
      Volat_Max((string)Global.volat_buffer_max[Global.volat_i]);      // alocação somente da maxima no arquivo de saida
      // calculo e alocação dos horarios das max
      Global.horario_volat = (Global.unixtime_dinamico_max_volat - Global.first_tick_unixtime)/60;  
      Volat_Horario_Max((string)Global.horario_volat);                 // alocação do horario de max volat no arquivo de saida
        
      // alocaçao da volat min  
      Volat_Min((string)Global.volat_buffer_min[Global.volat_i]);      // alocação somente da minima no arquivo de saida
      // calculo dos horarios e alocação dos horarios das min
      Global.horario_volat = (Global.unixtime_dinamico_min_volat - Global.first_tick_unixtime)/60;  
      Volat_Horario_Min((string)Global.horario_volat);                     // alocação do horario de max volat no arquivo de saida
      
      // atualização
      Flag.volat_alloc = true;  
      Global.volat_i++;                                        // incremento no passo para o dia seguinte
      return; 
  
     }  // fim da alocação final da volatilidade do dia
      
   }  // fim da Volatilidade()
  
                              