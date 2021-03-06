//-------------------------------------------------------------------+
//|                                              Market_Analysis.mq5 |
//|                                            Copyright 2014 - 2016 |
//|                                               by Fabrício Amaral |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014 - 2016, Fabrício Amaral"
#property link      "http://executive.com.br/"
   
//+------------------------------------------------------------------+
//| DATE CONTROL ARQUIVO DE SAIDA                                    |
//+------------------------------------------------------------------+
void Date_Control_File(string texto)
  { 
   Global.filehandle_Date_Control = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Date_Control.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Date_Control != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Date_Control,0,SEEK_END);
      FileWrite(Global.filehandle_Date_Control,(string)TimeCurrent()+"   "+texto);    // TimeCurrent() em datetime para validação
//      FileWrite(Global.filehandle_Date_Control,texto);
      FileFlush(Global.filehandle_Date_Control);
      FileClose(Global.filehandle_Date_Control);
     }
   else Alert("Operation FileOpen filehandle_Date_Control failed, error: ",GetLastError() );
        ResetLastError();
   
  }    
  
//+------------------------------------------------------------------+
//| TICK CONTROL ARQUIVO DE SAIDA                                    |
//+------------------------------------------------------------------+
void Tick_Control_File(string texto)
  { 
   Global.filehandle_Tick_Control = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Tick_Control.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Tick_Control != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Tick_Control,0,SEEK_END);
      FileWrite(Global.filehandle_Tick_Control,(string)TimeCurrent()+"   "+texto);    // TimeCurrent() em datetime para validação
//      FileWrite(Global.filehandle_Tick_Control,texto);
      FileFlush(Global.filehandle_Tick_Control);
      FileClose(Global.filehandle_Tick_Control);
     }
   else Alert("Operation FileOpen filehandle_Tick_Control failed, error: ",GetLastError() );
        ResetLastError();
   
  }      
  
//+------------------------------------------------------------------+
//| DATE CONTROL                                                     |
//+------------------------------------------------------------------+   
// controle de datas nao consideradas por dias incompletos: str1.hour < 17
void Date_Control_Close()
  {
   if(str1.hour == 9 && str1.min == 0 && str1.sec == 0)
     {
      ArraySetAsSeries(mrate,true);
      // Rates Buffers 
      if(CopyRates(_Symbol,PERIOD_M15,0,4,mrate) < 0)
        {
         Alert(" Error copying M15 rates - error: ",GetLastError()); 
         ResetLastError(); return;
        } 
      datetime pre_tick = mrate[1].time;
      TimeToStruct(pre_tick,str1);  
      if(str1.hour < 17)
        {
         // reset do Signals.first_tick
         Flag.first_tick = false;        
         Date_Control_File(" Dia anterior descartado: str1.hour < 17 "); 
        } 
      TimeToStruct(Global.date1 = TimeCurrent(),str1);
     } 
  
  }
  
// controle de dias nao considerados por dias incompletos: str1.hour > 9
void Date_Control_Open()
  {  
   if( str1.hour > 9 )  
     {
      Date_Control_File(" Dia descartado: str1.hour > 9 ");
      Tick_Control_File(" Dia descartado: str1.hour > 9 ");
      Market_Analysis_Manager_False();
     }
  
  }  // fim da Date_Control_Open()
  
void Tick_Control()
  {   
   if( 
         Flag.first_tick == true 
      && str1.hour < 17 
                                    ) 
     {
      // alocação do unixtime do tick anterior
      Global.prev_unixtime   = Global.tick_unixtime; 
      Global.actual_unixtime = TimeCurrent();
      // alocação do unixtime do tick atual
      TimeToStruct(Global.date2 = (datetime)TimeCurrent(),str2);
      if(Global.prev_unixtime + 900 <= Global.actual_unixtime) 
        {
         // controle do dia anterior   
         if(str2.hour == 9 && str2.min == 00 && str2.sec == 00)
           {
            Tick_Control_File(" Dia anterior descartado: str1.hour < 17 "); 
           }
         // controle de delay entre 2 ticks     
         else  Tick_Control_File(" Delay de mais de 900 (1 candle) segundos entre 2 ticks!! ");
        }
      // controle de sequenciamento entre 2 ticks   
      if(Global.prev_unixtime > Global.actual_unixtime) 
        {
         Tick_Control_File(" Unixtime do tick anterior maior q o atual ");
        }  
     }   
     
  }  // fim da Tick_Control()    
    

//+------------------------------------------------------------------+