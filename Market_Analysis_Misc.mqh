//-------------------------------------------------------------------+
//|                                              Market_Analysis.mq5 |
//|                                            Copyright 2014 - 2016 |
//|                                               by Fabrício Amaral |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014 - 2016, Fabrício Amaral"
#property link      "http://executive.com.br/"

//+------------------------------------------------------------------+
//| SINCRONIZAÇÃO DOS DADOS                                          |
//+------------------------------------------------------------------+
void Data_Synchro()
  {
   // Verificação de disponibilidade de barras.
   int bars = Bars(_Symbol,PERIOD_CURRENT);
   if(bars > 0)
     { 
      if(Market.Debug){
      Debug(" Number of bars for the symbol-period 15/5 at the moment = "+(string)bars); }       
     }
   else  // Sem barras disponíveis
     {
      // Dados sobre o ativo podem não estar sincronizados com os dados no servidor
      bool synchronized = false;
      // Contador de loop
      int attempts = 0;
      // Faz 5 tentativas de espera por sincronização
      while(attempts < 5)
        {
         if(SeriesInfoInteger(_Symbol,0,SERIES_SYNCHRONIZED))
           {
            // Sincronização feita, sair
            synchronized = true;
            break;
           }
         // Aumentar o contador
         attempts++;
         // Espera 10 milissegundos até a próxima iteração
         Sleep(10);
        }
      // Sair do loop após sincronização
      if(synchronized)
        {
         if(Market.Debug)
           {
            Debug(" Number of bars for the symbol-period 15/5 at the moment = "+(string)bars); 
            Debug("The first date in the terminal history for the symbol-period at the moment = "+
                  (string)(datetime)SeriesInfoInteger(_Symbol,0,SERIES_FIRSTDATE));     
            Debug("The first date in the history for the symbol on the server = "+
                  (string)(datetime)SeriesInfoInteger(_Symbol,0,SERIES_SERVER_FIRSTDATE));  
           }   
        }
      // Sincronização dos dados não aconteceu
      else
        {
         Debug_Alert(" Failed to get number of bars for "+_Symbol);   
        }
     }
   
   // Do we have sufficient bars to work?
   if(bars < 61) // total number of bars is less than 61?
     {
      Debug_Alert(" We have less than 61 bars on the chart, an Expert Advisor terminated!! ");   
     }
  }
  
//+------------------------------------------------------------------+
//| UNIXTIME FIRST TICK                                              |
//+------------------------------------------------------------------+   
// resets, alocaçao de referencias e controle de datas
void Market_Analysis_First_Tick()
  {
   // janela de espera do primeiro tick do dia
   if( 
         str1.hour >= 9 
      && str1.hour <= 15             
      && Flag.first_tick == false
                                     )     
     {
      Buffers_Market_Analysis();
      // aloca o unixtime do primeiro tick do dia para todas as analises
      Global.first_tick_unixtime = (long)TimeCurrent() - (long)str1.min*60;   // corrige para 9:00
      // reset da referencia 
      Global.sigma_buffer[Global.sigma_i]          = 0;
      Global.sigma_buffer_HV[Global.sigma_i]       = 0;
      Global.sigma_buffer_LV[Global.sigma_i]       = 0;
      Global.sigma_buffer_HV_Tarde[Global.sigma_i] = 0;
      Global.sigma_buffer_LV_Tarde[Global.sigma_i] = 0;
      Global.sigma_buffer_HV_NY[Global.sigma_i]    = 0;
      Global.sigma_buffer_LV_NY[Global.sigma_i]    = 0;
      // primeiro tick do indicador BBandwith para referencia de max/min
      Global.volat_referencia = Ind.BBandwidth_Buffer[0];     
      // reset das referencias do indicador BBandwidth
      Global.volat_buffer_max[Global.volat_i] = Global.volat_referencia;
      if(Market.Habilitar_Volatility_Analysis)
        {
         Debug(" Global.volat_buffer_max["+(string)Global.volat_i+"]: "+(string)Global.volat_buffer_max[Global.volat_i] );
        }
      Global.unixtime_dinamico_max_volat = TimeCurrent();
      Global.volat_buffer_min[Global.volat_i] = Global.volat_referencia;
      if(Market.Habilitar_Volatility_Analysis)
        {
         Debug(" Global.volat_buffer_min["+(string)Global.volat_i+"]: "+(string)Global.volat_buffer_min[Global.volat_i] );
        }
      Global.unixtime_dinamico_min_volat = TimeCurrent(); 
      // controle de datas nao consideradas
      Market_Analysis_Manager();                // reset do date control
      Date_Control_Open();                      // controle de dias nao considerados por começarem acima de 10:00
      // reset das bandeiras
      Flag.sigma_alloc =  false;         
      Flag.volat_alloc =  false;                           
      Flag.first_tick  =  true; 
      Debug(" Flag.first_tick: "+(string)Flag.first_tick);
      Flag.first_sigma_HV =  false;    
      Flag.first_sigma_LV =  false;    

      Flag.sl          = false;
      Flag.delta       = false;  
      // reset da transformação entre sigma e price para estimar o stop loss  
      Global.delta_sigma_sl_HV[Global.sigma_i] = 0;
      Global.delta_sigma_sl_LV[Global.sigma_i] = 0;
     }
     
  }  // fim da Market_Analysis_First_Tick()  
  
//+------------------------------------------------------------------+
//| RESET                                                            |
//+------------------------------------------------------------------+   
void Market_Analysis_Reset()
  {
   if(str1.hour == 17 && str1.min >= 15)  
     {
      Flag.first_tick = false;                  // para atualizar o Global.first_tick_unixtime no dia seguinte
     } 
     
  } // fim da Market_Analysis_Reset()

//+------------------------------------------------------------------+
//| DEFINIÇÕES QUE DEPENDEM DO ATIVO                                 |
//+------------------------------------------------------------------+   
void Symbol_Definitions()                        // chamada em ##Market_Analysis_Args## 
  {
   //  ############################## mini indice ########################################
   // M5
   if(   _Symbol == "WIN$D" 
      && Period() == 5     )
     {
      Global.volat_mean  = -0.4;       // volatilidade de separação dos regimes
      Global.volat_min   = -1.2;       // volatilidade minima media
      Global.pip         = 5;          // variação de 1 pip do ativo
     } 
   // M2  
   if(   _Symbol == "WIN$D" 
      && Period() == 2     )
     {
      Global.volat_mean  = -0.84;      // volatilidade de separação dos regimes
      Global.volat_min   = -1.9;       // volatilidade minima media
      Global.pip         = 5;          // variação de 1 pip do ativo
     } 
   // M10  
   if(   _Symbol == "WIN$D" 
      && Period() == 10    )
     {
      Global.volat_mean  = 0.16;       // volatilidade de separação dos regimes
      Global.volat_min   = -0.4;       // volatilidade minima media
      Global.pip         = 5;          // variação de 1 pip do ativo
     }   
   // M15  
   if(   _Symbol == "WIN$D" 
      && Period() == 15    )
     {
      Global.volat_mean  = 0.16;       // volatilidade de separação dos regimes
      Global.volat_min   = -0.4;       // volatilidade minima media
      Global.pip         = 5;          // variação de 1 pip do ativo
     }       

   //  ############################## mini dolar ########################################  
   // M5
   if(   _Symbol == "WDO$D"
      && Period() == 5     )
     {
      Global.volat_mean  = -0.68;       // volatilidade de separação dos regimes
      Global.volat_min   = -1.57;       // volatilidade minima media
      Global.pip         = 0.5;         // variação de 1 pip do ativo
     } 
   // M2  
   if(   _Symbol == "WDO$D" 
      && Period() == 2     )
     {
      Global.volat_mean  = -1.1;       // volatilidade de separação dos regimes
      Global.volat_min   = -2.25;       // volatilidade minima media
      Global.pip         = 0.5;         // variação de 1 pip do ativo
     } 
   // M10  
   if(   _Symbol == "WDO$D" 
      && Period() == 10    )
     {
      Global.volat_mean  = -0.15;       // volatilidade de separação dos regimes
      Global.volat_min   = -0.73;       // volatilidade minima media
      Global.pip         = 0.5;         // variação de 1 pip do ativo
     }   
   // M15  
   if(   _Symbol == "WDO$D" 
      && Period() == 15    )
     {
      Global.volat_mean  = -0.15;       // volatilidade de separação dos regimes
      Global.volat_min   = -0.73;       // volatilidade minima media
      Global.pip         = 0.5;         // variação de 1 pip do ativo
     }       
                           
  }  // fim da Symbol_Definitions()        
  
//+------------------------------------------------------------------+
//| TRANSFORMAÇÕES ENTRE SIGMA E PRICE                               |
//+------------------------------------------------------------------+  
// calculo da transformação entre sigma e price no regime HV para estimar o stop loss   
void Sigma_sl_Factor_HV()
  {
   double price = SymbolInfoDouble(_Symbol,SYMBOL_LAST);
   long   timer = (long)TimeCurrent() - (long)mrate[0].time;  // evolução do tempo de 1 candle em segundos
   
   if(   Global.sigma_buffer_HV[Global.sigma_i] >= 2.3  
      && Flag.sl == false                              )
     {
      if(price > Ind.mid_band[0])
        {
         Global.price_sl_HV[Global.sigma_i] = price + Global.sigma_1;
         Global.sigma_start = Global.sigma_buffer_HV[Global.sigma_i];
         Global.price_start = price;
        }
      else
        {
         Global.price_sl_HV[Global.sigma_i] = price - Global.sigma_1;
         Global.sigma_start = Global.sigma_buffer_HV[Global.sigma_i];
         Global.price_start = price;
        }  
        
      Delta_Sigma_HV(" Global.sigma_buffer_HV["+(string)Global.sigma_i+"]:    "
                       +(string)NormalizeDouble(Global.sigma_buffer_HV[Global.sigma_i],2) );  
                     
      // controle do tempo
      Global.timer_inicial_unixtime = (long)TimeCurrent();
      Global.timer = timer;               
      Flag.sl = true;   
     }
   if(   Flag.sl    == true
      && Flag.delta == false )
     {
      // controle da validade do candle
      if((long)TimeCurrent() - Global.timer_inicial_unixtime >= (60*Period() - Global.timer))
        {
         Flag.delta = true;
         Delta_Sigma_HV(" sl em candle posterior ");
         return;
        }
      // analise no mesmo candle  
      if(   price > Global.price_start
         && price >= Global.price_sl_HV[Global.sigma_i])
        {
         Global.delta_sigma_sl_HV[Global.sigma_i] = Global.sigma_buffer_HV[Global.sigma_i] - Global.sigma_start ;
         Delta_Sigma_HV(" Global.delta_sigma_sl_HV[["+(string)Global.sigma_i+"]: "
                          +(string)NormalizeDouble(Global.delta_sigma_sl_HV[Global.sigma_i],2) );
               
         Global.delta_price = NormalizeDouble(((price - Global.price_sl_HV[Global.sigma_i])/Global.pip),1);     
         Delta_Sigma_HV(" delta_price_pips: "+(string)Global.delta_price);
         Delta_Sigma_HV(" ");
         Flag.delta = true;
        } 
      if(   price < Global.price_start
         && price <= Global.price_sl_HV[Global.sigma_i])
        {
         Global.delta_sigma_sl_HV[Global.sigma_i] = Global.sigma_buffer_HV[Global.sigma_i] - Global.sigma_start ;
         Delta_Sigma_HV(" Global.delta_sigma_sl_HV[["+(string)Global.sigma_i+"]: "
                          +(string)NormalizeDouble(Global.delta_sigma_sl_HV[Global.sigma_i],2) );
               
         Global.delta_price = NormalizeDouble(((price - Global.price_sl_HV[Global.sigma_i])/Global.pip),1);      
         Delta_Sigma_HV(" delta_price_pips: "+(string)Global.delta_price);
         Delta_Sigma_HV(" ");
         Flag.delta = true;
        }    
     } 

  }     //  fim da Sigma_sl_Factor_HV()   
  
// calculo da transformação entre sigma e price no regime LV para estimar o stop loss     
void Sigma_sl_Factor_LV()
  {
   Buffers_Market_Analysis();
   double price = SymbolInfoDouble(_Symbol,SYMBOL_LAST);
   long   timer = (long)TimeCurrent() - (long)mrate[0].time;  // evolução do tempo de 1 candle em segundos
   
   // aloca uma vez o sigma q passar do nivel escolhido
   if(   Global.sigma_buffer_LV[Global.sigma_i] >= 2.4  
      && Flag.sl == false                              )
     {
      if(price > Ind.mid_band[0])
        {
         Global.price_sl_LV[Global.sigma_i] = price + Global.sigma_1;
         Global.sigma_start = Global.sigma_buffer_LV[Global.sigma_i];
         Global.price_start = price;
        }
      else
        {
         Global.price_sl_LV[Global.sigma_i] = price - Global.sigma_1;
         Global.sigma_start = Global.sigma_buffer_LV[Global.sigma_i];
         Global.price_start = price;
        }  
      Delta_Sigma_LV(" Global.sigma_buffer_LV["+(string)Global.sigma_i+"]:    "
                       +(string)NormalizeDouble(Global.sigma_buffer_LV[Global.sigma_i],2));  
      Flag.sl = true;
      
      Global.timer_inicial_unixtime = (long)TimeCurrent();
      Global.timer = timer;
//      Debug_Alert(" timer_M"+(string)Period()+": "+(string)timer);
         
     }
   // verifica se o preço bate no sl no mesmo candle  
   if(   Flag.sl    == true
      && Flag.delta == false )
     {
      // controle da validade do candle
      if((long)TimeCurrent() - Global.timer_inicial_unixtime >= (60*Period() - Global.timer))
        {
         Flag.delta = true;
         Delta_Sigma_LV(" sl em candle posterior ");
         return;
        }
      // analise no mesmo candle
      if(   price > Global.price_start
         && price >= Global.price_sl_LV[Global.sigma_i])
        {
         Global.delta_sigma_sl_LV[Global.sigma_i] = Global.sigma_buffer_LV[Global.sigma_i] - Global.sigma_start ;
         Delta_Sigma_LV(" Global.delta_sigma_sl_LV[["+(string)Global.sigma_i+"]: "
                          +(string)NormalizeDouble(Global.delta_sigma_sl_LV[Global.sigma_i],2) );
               
         Global.delta_price = NormalizeDouble(((price - Global.price_sl_LV[Global.sigma_i])/Global.pip),1);     
         Delta_Sigma_LV(" delta_price_pips: "+(string)Global.delta_price);
         Delta_Sigma_LV(" ");
               
         Flag.delta = true;
        } 
      if(   price < Global.price_start
         && price <= Global.price_sl_LV[Global.sigma_i])
        {
         Global.delta_sigma_sl_LV[Global.sigma_i] = Global.sigma_buffer_LV[Global.sigma_i] - Global.sigma_start ;
         Delta_Sigma_LV(" Global.delta_sigma_sl_LV[["+(string)Global.sigma_i+"]: "
                          +(string)NormalizeDouble(Global.delta_sigma_sl_LV[Global.sigma_i],2) );
         
         Global.delta_price = NormalizeDouble(((price - Global.price_sl_LV[Global.sigma_i])/Global.pip),1);     
         Delta_Sigma_LV(" delta_price_pips: "+(string)Global.delta_price);
         Delta_Sigma_LV(" ");
               
         Flag.delta = true;
        }    
     } 

  }     //  fim da Sigma_sl_Factor_LV()       
  
//+------------------------------------------------------------------+


