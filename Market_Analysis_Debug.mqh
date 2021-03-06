//+------------------------------------------------------------------+
//|                                                                  |
//|                                            Copyright 2014-2016   |
//|                                             by Fabrício Amaral   |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014-2016, Fabrício Amaral"
#property link      "http://executive.com.br/"

//+------------------------------------------------------------------+
//| Debug                                                            |
//+------------------------------------------------------------------+
void Debug(string texto)
  { 
   Global.filehandle = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                +"_Debug.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle!= INVALID_HANDLE)
     {
      FileSeek(Global.filehandle,0,SEEK_END);
      FileWrite(Global.filehandle,(string)TimeCurrent()+texto);
      FileFlush(Global.filehandle);
      FileClose(Global.filehandle);
     }
   else Alert("Operation FileOpen debug failed, error ",GetLastError()); 
   ResetLastError();
   
  }
  
void Debug_Set_Init()
  {
   // abre o arquivo de debug e aloca o set de gerenciamento de estrategias
   if(Market.Debug)
    {
     // Market_Analysis
     if(Robo == 3)
       {      
        Debug(" Inicio do Debug - Robô: "+MQLInfoString(MQL_PROGRAM_NAME)+" - Ativo: "+Symbol()+"_M"+(string)Period()+"\n"
              +"##### ESTRATEGIAS #####"+"\n"
              +"Habilitar_Sigma_Analysis:            "  +(string)Market.Habilitar_Sigma_Analysis+"\n"
              +"Habilitar_Volatility_Analysis:       "  +(string)Market.Habilitar_Volatility_Analysis+"\n"
              +"Global.volat_mean:                   "  +(string)Global.volat_mean+"\n"
              +"Global.volat_min:                    "  +(string)Global.volat_min+"\n"
                                                                                                          );
       }          
           
    }     
    
   // abre o arquivo de alertas
   Debug_Alert(" Inicio do Alert - Robô: "+MQLInfoString(MQL_PROGRAM_NAME)+" - Ativo: "+Symbol() );
     
  }  // fim da Debug_Set_Init()
  
//+------------------------------------------------------------------+
//| Alerts                                                           |
//+------------------------------------------------------------------+
void Debug_Alert(string texto)
  {
   Global.filehandle_alert = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Alert.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_alert!= INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_alert,0,SEEK_END);
      FileWrite(Global.filehandle_alert,(string)TimeCurrent()+texto);
      FileFlush(Global.filehandle_alert);
      FileClose(Global.filehandle_alert);
     }
   else Alert("Operation FileOpen alert failed, error: ",GetLastError() );
        ResetLastError();
   
   }  // fim da Debug_Alert



//+------------------------------------------------------------------+