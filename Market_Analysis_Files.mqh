//-------------------------------------------------------------------+
//|                                              Market_Analysis.mq5 |
//|                                            Copyright 2014 - 2016 |
//|                                               by Fabrício Amaral |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014 - 2016, Fabrício Amaral"
#property link      "http://executive.com.br/"

//############################################################################################################# 
//######################################## ARQUIVOS DE SAIDA ################################################## 
//########################################      SIGMA        ################################################## 
//#############################################################################################################   
//+------------------------------------------------------------------+
//| SIGMA MAX MIN                                                    |
//+------------------------------------------------------------------+
void Sigma_Max(string texto)
  { 
   Global.filehandle_Sigma_Max = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Max.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Sigma_Max != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Sigma_Max,0,SEEK_END);
//      FileWrite(Global.filehandle_Sigma_Max,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Sigma_Max,texto);
      FileFlush(Global.filehandle_Sigma_Max);
      FileClose(Global.filehandle_Sigma_Max);
     }
   else Alert("Operation FileOpen filehandle_Sigma_Max failed, error: ",GetLastError() );
        ResetLastError();
   
  }
  
void Sigma_Max_HV(string texto)
  { 
   Global.filehandle_Sigma_Max_HV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Max_HV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Sigma_Max_HV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Sigma_Max_HV,0,SEEK_END);
//      FileWrite(Global.filehandle_Sigma_Max_HV,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Sigma_Max_HV,texto);
      FileFlush(Global.filehandle_Sigma_Max_HV);
      FileClose(Global.filehandle_Sigma_Max_HV);
     }
   else Alert("Operation FileOpen filehandle_Sigma_Max_HV failed, error: ",GetLastError() );
        ResetLastError();
   
  }  
  
void Sigma_Max_LV(string texto)
  { 
   Global.filehandle_Sigma_Max_LV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Max_LV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Sigma_Max_LV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Sigma_Max_LV,0,SEEK_END);
//      FileWrite(Global.filehandle_Sigma_Max_LV,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Sigma_Max_LV,texto);
      FileFlush(Global.filehandle_Sigma_Max_LV);
      FileClose(Global.filehandle_Sigma_Max_LV);
     }
   else Alert("Operation FileOpen filehandle_Sigma_Max_LV failed, error: ",GetLastError() );
        ResetLastError();
   
  }    
  
//+------------------------------------------------------------------+
//| SIGMA HORARIO                                                    |
//+------------------------------------------------------------------+
void Sigma_Horario(string texto)
  { 
   Global.filehandle_Sigma_Horario = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Horario.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Sigma_Horario != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Sigma_Horario,0,SEEK_END);
//      FileWrite(Global.filehandle_Sigma_Horario,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Sigma_Horario,texto);
      FileFlush(Global.filehandle_Sigma_Horario);
      FileClose(Global.filehandle_Sigma_Horario);
     }
   else Alert("Operation FileOpen filehandle_Sigma_Horario failed, error: ",GetLastError() );
        ResetLastError();
   
  }  
  
void Sigma_Horario_HV(string texto)
  { 
   Global.filehandle_Sigma_Horario_HV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Horario_HV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Sigma_Horario_HV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Sigma_Horario_HV,0,SEEK_END);
//      FileWrite(Global.filehandle_Sigma_Horario_HV,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Sigma_Horario_HV,texto);
      FileFlush(Global.filehandle_Sigma_Horario_HV);
      FileClose(Global.filehandle_Sigma_Horario_HV);
     }
   else Alert("Operation FileOpen filehandle_Sigma_Horario_HV failed, error: ",GetLastError() );
        ResetLastError();
   
  }    
  
void Sigma_Horario_LV(string texto)
  { 
   Global.filehandle_Sigma_Horario_LV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Horario_LV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Sigma_Horario_LV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Sigma_Horario_LV,0,SEEK_END);
//      FileWrite(Global.filehandle_Sigma_Horario_LV,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Sigma_Horario_LV,texto);
      FileFlush(Global.filehandle_Sigma_Horario_LV);
      FileClose(Global.filehandle_Sigma_Horario_LV);
     }
   else Alert("Operation FileOpen filehandle_Sigma_Horario_LV failed, error: ",GetLastError() );
        ResetLastError();
   
  }  
  
//+------------------------------------------------------------------+
//| SIGMA MEAN                                                       |
//+------------------------------------------------------------------+  
void Sigma_Mean(string texto)
  { 
   Global.filehandle_Sigma_Mean = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Mean.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Sigma_Mean != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Sigma_Mean,0,SEEK_END);
      FileWrite(Global.filehandle_Sigma_Mean,(string)TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
//      FileWrite(Global.filehandle_Sigma_Mean,texto);
      FileFlush(Global.filehandle_Sigma_Mean);
      FileClose(Global.filehandle_Sigma_Mean);
     }
   else Alert("Operation FileOpen filehandle_Sigma_Mean failed, error: ",GetLastError() );
        ResetLastError();
   
  }        
  
//+------------------------------------------------------------------+
//| FIRST SIGMA                                                      |
//+------------------------------------------------------------------+  
void First_Sigma_HV(string texto)
  { 
   Global.filehandle_First_Sigma_HV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_First_Sigma_HV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_First_Sigma_HV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_First_Sigma_HV,0,SEEK_END);
//      FileWrite(Global.filehandle_First_Sigma_HV,(string)TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_First_Sigma_HV,texto);
      FileFlush(Global.filehandle_First_Sigma_HV);
      FileClose(Global.filehandle_First_Sigma_HV);
     }
   else Alert("Operation FileOpen filehandle_First_Sigma_HV failed, error: ",GetLastError() );
        ResetLastError();
   
  }     

void Horario_First_Sigma_HV(string texto)
  { 
   Global.filehandle_Horario_First_Sigma_HV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Horario_First_Sigma_HV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Horario_First_Sigma_HV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Horario_First_Sigma_HV,0,SEEK_END);
//      FileWrite(Global.filehandle_Horario_First_Sigma_HV,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Horario_First_Sigma_HV,texto);
      FileFlush(Global.filehandle_Horario_First_Sigma_HV);
      FileClose(Global.filehandle_Horario_First_Sigma_HV);
     }
   else Alert("Operation FileOpen filehandle_Horario_First_Sigma_HV failed, error: ",GetLastError() );
        ResetLastError();
   
  }       
  
void First_Sigma_LV(string texto)
  { 
   Global.filehandle_First_Sigma_LV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_First_Sigma_LV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_First_Sigma_LV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_First_Sigma_LV,0,SEEK_END);
//      FileWrite(Global.filehandle_First_Sigma_LV,(string)TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_First_Sigma_LV,texto);
      FileFlush(Global.filehandle_First_Sigma_LV);
      FileClose(Global.filehandle_First_Sigma_LV);
     }
   else Alert("Operation FileOpen filehandle_First_Sigma_LV failed, error: ",GetLastError() );
        ResetLastError();
   
  }     
  
void Horario_First_Sigma_LV(string texto)
  { 
   Global.filehandle_Horario_First_Sigma_LV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Horario_First_Sigma_LV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Horario_First_Sigma_LV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Horario_First_Sigma_LV,0,SEEK_END);
//      FileWrite(Global.filehandle_Horario_First_Sigma_LV,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Horario_First_Sigma_LV,texto);
      FileFlush(Global.filehandle_Horario_First_Sigma_LV);
      FileClose(Global.filehandle_Horario_First_Sigma_LV);
     }
   else Alert("Operation FileOpen filehandle_Horario_First_Sigma_LV failed, error: ",GetLastError() );
        ResetLastError();
   
  }              
  
    
//+------------------------------------------------------------------+
//| DELTA SIGMA                                                      |
//+------------------------------------------------------------------+    
void Delta_Sigma_HV(string texto)
  { 
   Global.filehandle_Delta_Sigma_HV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Delta_Sigma_HV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Delta_Sigma_HV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Delta_Sigma_HV,0,SEEK_END);
      FileWrite(Global.filehandle_Delta_Sigma_HV,(string)TimeCurrent()+"   "+texto);    // TimeCurrent() em datetime para validação
//      FileWrite(Global.filehandle_Delta_Sigma_HV,texto);
      FileFlush(Global.filehandle_Delta_Sigma_HV);
      FileClose(Global.filehandle_Delta_Sigma_HV);
     }
   else Alert("Operation FileOpen filehandle_Delta_Sigma_HV failed, error: ",GetLastError() );
        ResetLastError();
   
  }        
  
void Delta_Sigma_LV(string texto)
  { 
   Global.filehandle_Delta_Sigma_LV = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Delta_Sigma_LV.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Delta_Sigma_LV != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Delta_Sigma_LV,0,SEEK_END);
      FileWrite(Global.filehandle_Delta_Sigma_LV,(string)TimeCurrent()+"   "+texto);    // TimeCurrent() em datetime para validação
//      FileWrite(Global.filehandle_Delta_Sigma_LV,texto);
      FileFlush(Global.filehandle_Delta_Sigma_LV);
      FileClose(Global.filehandle_Delta_Sigma_LV);
     }
   else Alert("Operation FileOpen filehandle_Delta_Sigma_LV failed, error: ",GetLastError() );
        ResetLastError();
   
  }          
  
  
//############################################################################################################# 
//######################################## ARQUIVOS DE SAIDA ################################################## 
//########################################   VOLATILIDADE    ################################################## 
//#############################################################################################################   
//+------------------------------------------------------------------+
//| VOLATILIDADE MAX e MIN                                           |
//+------------------------------------------------------------------+
void Volat_Max_Min(string texto)
  { 
   Global.filehandle_Volat_Max_Min = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Volat_Max_Min.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Volat_Max_Min != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Volat_Max_Min,0,SEEK_END);
//      FileWrite(Global.filehandle_Volat_Max_Min,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Volat_Max_Min,texto);
      FileFlush(Global.filehandle_Volat_Max_Min);
      FileClose(Global.filehandle_Volat_Max_Min);
     }
   else Alert("Operation FileOpen filehandle_Volat_Max_Min failed, error: ",GetLastError() );
        ResetLastError();
   
  }
  
//+------------------------------------------------------------------+
//| VOLATILIDADE MAX                                                 |
//+------------------------------------------------------------------+
void Volat_Max(string texto)
  { 
   Global.filehandle_Volat_Max = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Volat_Max.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Volat_Max != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Volat_Max,0,SEEK_END);
//      FileWrite(Global.filehandle_Volat_Max,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Volat_Max,texto);
      FileFlush(Global.filehandle_Volat_Max);
      FileClose(Global.filehandle_Volat_Max);
     }
   else Alert("Operation FileOpen filehandle_Volat_Max failed, error: ",GetLastError() );
        ResetLastError();
   
  }  
  
//+------------------------------------------------------------------+
//| VOLATILIDADE MIN                                                 |
//+------------------------------------------------------------------+
void Volat_Min(string texto)
  { 
   Global.filehandle_Volat_Min = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Volat_Min.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Volat_Min != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Volat_Min,0,SEEK_END);
//      FileWrite(Global.filehandle_Volat_Min,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Volat_Min,texto);
      FileFlush(Global.filehandle_Volat_Min);
      FileClose(Global.filehandle_Volat_Min);
     }
   else Alert("Operation FileOpen filehandle_Volat_Min failed, error: ",GetLastError() );
        ResetLastError();
   
  }  
  
//+------------------------------------------------------------------+
//| VOLATILIDADE HORARIO                                             |
//+------------------------------------------------------------------+
void Volat_Horario_Max(string texto)
  { 
   Global.filehandle_Volat_Horario_Max = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Volat_Horario_Max.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Volat_Horario_Max != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Volat_Horario_Max,0,SEEK_END);
//      FileWrite(Global.filehandle_Volat_Horario_Max,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Volat_Horario_Max,texto);
      FileFlush(Global.filehandle_Volat_Horario_Max);
      FileClose(Global.filehandle_Volat_Horario_Max);
     }
   else Alert("Operation FileOpen filehandle_Volat_Horario_Max failed, error: ",GetLastError() );
        ResetLastError();
   
  }  
  
void Volat_Horario_Min(string texto)
  { 
   Global.filehandle_Volat_Horario_Min = FileOpen(Global.subfolder+"\\"+MQLInfoString(MQL_PROGRAM_NAME)
                                                      +"_Volat_Horario_Min.txt",FILE_READ|FILE_WRITE|FILE_CSV);
   if(Global.filehandle_Volat_Horario_Min != INVALID_HANDLE)
     {
      FileSeek(Global.filehandle_Volat_Horario_Min,0,SEEK_END);
//      FileWrite(Global.filehandle_Volat_Horario_Min,TimeCurrent()+"   "+texto);    // TimeCurrent() para validação
      FileWrite(Global.filehandle_Volat_Horario_Min,texto);
      FileFlush(Global.filehandle_Volat_Horario_Min);
      FileClose(Global.filehandle_Volat_Horario_Min);
     }
   else Alert("Operation FileOpen filehandle_Volat_Horario_Min failed, error: ",GetLastError() );
        ResetLastError();
   
  }    
  
//+------------------------------------------------------------------+
//| ALOCAÇÃO DIARIA SIGMA                                            |
//+------------------------------------------------------------------+     
void Files_Alloc_Sigma()
  {
   // alocação final dos sigma max 
   if(  
         str1.hour == 17 && str1.min >= 0
      && str1.hour == 17 && str1.min <= 8   
      && Flag.sigma_alloc == false   
                                          ) 
     {
      if(Market.Regimes == true)
        {
         // condição q nao houve preços acima ou abaixo de 2 sigma
         if(Global.sigma_buffer_HV[Global.sigma_i] == 0)
           {
            Flag.sigma_alloc = true;  
           }
         // condição q nao houve preços acima ou abaixo de 2 sigma
         if(Global.sigma_buffer_LV[Global.sigma_i] == 0)
           {
            Flag.sigma_alloc = true;  
           }  
         // ############# HV ##############################################  
         // condição q houve preços acima ou abaixo de 2 sigma na abertura
         if(Global.sigma_buffer_HV[Global.sigma_i] > 2)
           {
            // alocação da maxima no arquivo de saida
            Sigma_Max_HV((string)Global.sigma_buffer_HV[Global.sigma_i]);      
            Global.horario_sigma = (Global.unixtime_dinamico_sigma_HV - Global.first_tick_unixtime)/60; 
            // alocação do horario no arquivo de saida
            Sigma_Horario_HV((string)Global.horario_sigma);   
            
            // contagem da media do sigma
            Global.mean_buffer_HV_open[Global.count_mean_HV_open] = Global.sigma_buffer_HV[Global.sigma_i];
            Global.mean_HV_open = 0;
            for(int i=1;i<=Global.count_mean_HV_open;i++)
              {
               Global.mean_HV_open += Global.mean_buffer_HV_open[i];  // soma aritimetica 
              } 
//            Sigma_Mean(" Count:        "+(string)Global.count_mean_HV_open);  
            Sigma_Mean(" Mean_HV_open : "+(string)(Global.mean_HV_open / Global.count_mean_HV_open));  
            Global.count_mean_HV_open++;      
                              
            Flag.sigma_alloc = true;  
           }  
         // condição q houve preços acima ou abaixo de 2 sigma NY
         if(Global.sigma_buffer_HV_NY[Global.sigma_i] > 2)
           {
            // alocação da maxima no arquivo de saida
            Sigma_Max_HV((string)Global.sigma_buffer_HV_NY[Global.sigma_i]);           
            Global.horario_sigma = (Global.unixtime_dinamico_sigma_HV_NY - Global.first_tick_unixtime)/60; 
            // alocação do horario no arquivo de saida
            Sigma_Horario_HV((string)Global.horario_sigma);    
            
            // contagem da media do sigma
            Global.mean_buffer_HV_NY[Global.count_mean_HV_NY] = Global.sigma_buffer_HV_NY[Global.sigma_i];
            Global.mean_HV_NY = 0;
            for(int i=1;i<=Global.count_mean_HV_NY;i++)
              {
               Global.mean_HV_NY += Global.mean_buffer_HV_NY[i];  // soma aritimetica 
              } 
//            Sigma_Mean(" Count:      "+(string)Global.count_mean_HV_NY);  
            Sigma_Mean(" Mean_HV_NY   : "+(string)(Global.mean_HV_NY / Global.count_mean_HV_NY));  
            Global.count_mean_HV_NY++; 
                             
            Flag.sigma_alloc = true;  
           }    
         // condição q houve preços acima ou abaixo de 2 sigma na tarde
         if(Global.sigma_buffer_HV_Tarde[Global.sigma_i] > 2)
           {
            // alocação da maxima da tarde no arquivo de saida
            Sigma_Max_HV((string)Global.sigma_buffer_HV_Tarde[Global.sigma_i]);           
            Global.horario_sigma = (Global.unixtime_dinamico_sigma_HV_Tarde - Global.first_tick_unixtime)/60; 
            // alocação do horario no arquivo de saida
            Sigma_Horario_HV((string)Global.horario_sigma);   
            
            // contagem da media do sigma
            Global.mean_buffer_HV_tarde[Global.count_mean_HV_tarde] = Global.sigma_buffer_HV_Tarde[Global.sigma_i];
            Global.mean_HV_tarde = 0;
            for(int i=1;i<=Global.count_mean_HV_tarde;i++)
              {
               Global.mean_HV_tarde += Global.mean_buffer_HV_tarde[i];  // soma aritimetica 
              } 
//            Sigma_Mean(" Count:         "+(string)Global.count_mean_HV_tarde);  
            Sigma_Mean(" Mean_HV_tarde: "+(string)(Global.mean_HV_tarde / Global.count_mean_HV_tarde));  
            Global.count_mean_HV_tarde++; 
                              
            Flag.sigma_alloc = true;  
           } 
         // ############# LV ##############################################     
         // condição q houve preços acima ou abaixo de 2 sigma na abertura
         if(Global.sigma_buffer_LV[Global.sigma_i] > 2)
           {
            // alocação da maxima no arquivo de saida
            Sigma_Max_LV((string)Global.sigma_buffer_LV[Global.sigma_i]);           
            Global.horario_sigma = (Global.unixtime_dinamico_sigma_LV - Global.first_tick_unixtime)/60; 
            // alocação do horario no arquivo de saida
            Sigma_Horario_LV((string)Global.horario_sigma);   
            
            // contagem da media do sigma
            Global.mean_buffer_LV_open[Global.count_mean_LV_open] = Global.sigma_buffer_LV[Global.sigma_i];
            Global.mean_LV_open = 0;
            for(int i=1;i<=Global.count_mean_LV_open;i++)
              {
               Global.mean_LV_open += Global.mean_buffer_LV_open[i];  // soma aritimetica 
              } 
//            Sigma_Mean(" Count:        "+(string)Global.count_mean_LV_open);  
            Sigma_Mean(" Mean_LV_open : "+(string)(Global.mean_LV_open / Global.count_mean_LV_open));  
            Global.count_mean_LV_open++; 
                              
            Flag.sigma_alloc = true;  
           } 
         // condição q houve preços acima ou abaixo de 2 sigma NY
         if(Global.sigma_buffer_LV_NY[Global.sigma_i] > 2)
           {
            // alocação da maxima no arquivo de saida
            Sigma_Max_LV((string)Global.sigma_buffer_LV_NY[Global.sigma_i]);           
            Global.horario_sigma = (Global.unixtime_dinamico_sigma_LV_NY - Global.first_tick_unixtime)/60; 
            // alocação do horario no arquivo de saida
            Sigma_Horario_LV((string)Global.horario_sigma); 
            
            // contagem da media do sigma
            Global.mean_buffer_LV_NY[Global.count_mean_LV_NY] = Global.sigma_buffer_LV_NY[Global.sigma_i];
            Global.mean_LV_NY = 0;
            for(int i=1;i<=Global.count_mean_LV_NY;i++)
              {
               Global.mean_LV_NY += Global.mean_buffer_LV_NY[i];  // soma aritimetica  
              } 
//            Sigma_Mean(" Count:      "+(string)Global.count_mean_LV_NY);  
            Sigma_Mean(" Mean_LV_NY   : "+(string)(Global.mean_LV_NY / Global.count_mean_LV_NY));  
            Global.count_mean_LV_NY++; 
                                
            Flag.sigma_alloc = true;  
           }     
         // condição q houve preços acima ou abaixo de 2 sigma na tarde
         if(Global.sigma_buffer_LV_Tarde[Global.sigma_i] > 2)
           {
            // alocação da maxima no arquivo de saida
            Sigma_Max_LV((string)Global.sigma_buffer_LV_Tarde[Global.sigma_i]);           
            Global.horario_sigma = (Global.unixtime_dinamico_sigma_LV_Tarde - Global.first_tick_unixtime)/60; 
            // alocação do horario no arquivo de saida
            Sigma_Horario_LV((string)Global.horario_sigma);
            
            // contagem da media do sigma
            Global.mean_buffer_LV_tarde[Global.count_mean_LV_tarde] = Global.sigma_buffer_LV_Tarde[Global.sigma_i];
            Global.mean_LV_tarde = 0;
            for(int i=1;i<=Global.count_mean_LV_tarde;i++)
              {
               Global.mean_LV_tarde += Global.mean_buffer_LV_tarde[i];  // soma aritimetica
              } 
//            Sigma_Mean(" Count:         "+(string)Global.count_mean_LV_tarde);  
            Sigma_Mean(" Mean_LV_tarde: "+(string)(Global.mean_LV_tarde / Global.count_mean_LV_tarde));  
            Global.count_mean_LV_tarde++; 
                                 
            Flag.sigma_alloc = true;  
           }  
         
         // passo para os dois regimes   
         Global.sigma_i++;  
         return;   
          
        }  
        
      if(Market.Regimes == false)
        {
         // condição q nao houve preços acima ou abaixo de 2 sigma
         if(Global.sigma_buffer[Global.sigma_i] == 0)
           {
            Flag.sigma_alloc = true;  
            return; 
           }
         // condição q houve preços acima ou abaixo de 2 sigma
         if(Global.sigma_buffer[Global.sigma_i] > 2)
           {
            // alocação da maxima no arquivo de saida
            Sigma_Max((string)Global.sigma_buffer[Global.sigma_i]);  
            Global.horario_sigma = ((long)Global.unixtime_dinamico_sigma - (long)Global.first_tick_unixtime)/60; 
            // alocação do horario no arquivo de saida
            Sigma_Horario((string)Global.horario_sigma);                     
            Flag.sigma_alloc = true;  
            
            // passo
            Global.sigma_i++;
            return; 
           }  
        }  
      
     }  
  
  }  // fim da Files_Alloc_Sigma()