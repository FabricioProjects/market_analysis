//+------------------------------------------------------------------+
//|                                                                  |
//|                                            Copyright 2014-2016   |
//|                                             by Fabrício Amaral   |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014-2016, Fabrício Amaral"
#property link      "http://executive.com.br/"

//+------------------------------------------------------------------+
//| Indicators                                                       |
//+------------------------------------------------------------------+
// struct de definição dos handles e buffers dos indicadores
struct Indicators      
  {    
   // --- BollingerBand handle 1 sigma
   int          BBHandle;
   //--- indicator buffers
   double       mid_band[];
   double       upper_band[];
   double       lower_band[];
   
// CUSTOM INDICATORS
   // BBANDWIDTH
   int          BBandwidth_Handle;
   double       BBandwidth_Buffer[];

  } Ind;
  
//+------------------------------------------------------------------+
//| INDICADORES EXCLUSIVOS PARA ANALISE GLOBAL DO ATIVO              |
//+------------------------------------------------------------------+   
void Indicators_Market_Analysis()
  {
   // Get handle of the indicators
   Ind.BBHandle           = iBands (_Symbol,PERIOD_CURRENT,20,0,1,PRICE_CLOSE);   // 1 SIGMA
   Ind.BBandwidth_Handle  = iCustom(_Symbol,PERIOD_CURRENT,"Log_BBandwidth",20,0,2,PRICE_CLOSE); 
   // Check for Invalid Handle
   if(  
         Ind.BBHandle           < 0
      || Ind.BBandwidth_Handle  < 0 
                                      )
     {
      Alert(" Error in creation of Indicators_Market_Analysis - error: ",GetLastError()); 
     } 
  
   // --- Turn the arrays into dynamic series arrays  
   ArraySetAsSeries(mrate,true);
   ArraySetAsSeries(Ind.mid_band,true); 
   ArraySetAsSeries(Ind.lower_band,true);
   ArraySetAsSeries(Ind.upper_band,true);
   ArraySetAsSeries(Ind.BBandwidth_Buffer,true);
 
  }
  
void Indicators_Market_Analysis_Release()
  {  
   IndicatorRelease(Ind.BBHandle);
   IndicatorRelease(Ind.BBandwidth_Handle);
  }    
  
//+------------------------------------------------------------------+
//| Buffers Call                                                     |
//+------------------------------------------------------------------+  
void Buffers_Market_Analysis()
  {
   // Rates Buffers 
   if(CopyRates(_Symbol,PERIOD_CURRENT,0,4,mrate) < 0)
     {
      Alert(" Error copying rates - error: ",GetLastError()); 
      ResetLastError(); return;
     } 
   // BBands Buffers    
   if(CopyBuffer(Ind.BBHandle,0,0,2,Ind.mid_band) <=0)
     {
      Alert("Getting mid_band Buffer is failed! Error",GetLastError());
      ResetLastError(); return;
     }
   if(CopyBuffer(Ind.BBHandle,1,0,2,Ind.upper_band) <=0)
     {
      Alert("Getting upper_band Buffer is failed! Error",GetLastError());
      ResetLastError(); return;
     }
   if(CopyBuffer(Ind.BBHandle,2,0,2,Ind.lower_band) <=0)
     {
      Alert("Getting lower_band Buffer is failed! Error",GetLastError());
      ResetLastError(); return;
     }
   // BBandwidth Buffers
   if( CopyBuffer(Ind.BBandwidth_Handle,0,0,5,Ind.BBandwidth_Buffer) < 0 )
     {
      Alert(" Error copying BBandwidth indicator Buffers - error: ",GetLastError() ); 
      ResetLastError(); return;
     }       
  
  }  // fim da Buffers_Market_Analysis 
   
//+------------------------------------------------------------------+  