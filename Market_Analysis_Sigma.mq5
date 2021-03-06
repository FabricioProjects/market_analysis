//-------------------------------------------------------------------+
//|                                              Market_Analysis.mq5 |
//|                                            Copyright 2014 - 2016 |
//|                                               by Fabrício Amaral |
//+------------------------------------------------------------------+
//#property copyright "Copyright 2014 - 2016, Fabrício Amaral"
#property link      "http://executive.com.br/"
#property version   "2.1"

// Market_Analysis Libraries
#include "Market_Analysis_Args.mqh"
#include "Market_Analysis_Misc.mqh"
// Análises
#include "Market_Analysis_Sigma_Open.mqh"
#include "Market_Analysis_Sigma_NY.mqh"
#include "Market_Analysis_Sigma_Tarde.mqh"
#include "Market_Analysis_Volatility.mqh"
// Arquivos de saida
#include "Market_Analysis_Files.mqh"
// Indicadores
#include "Market_Analysis_Indicators.mqh"
// Controle dos dados
#include "Market_Analysis_Date_Control.mqh"
#include "Market_Analysis_Debug.mqh"

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
// definições globais, feitas somente uma vez
int OnInit()
  { 
   // Disponibilidade de barras e sincronização.             ##Market_Analysis_Misc##
   Data_Synchro();                                   
   // Gerenciamento de estrategias e sub-estrategias.        ##Market_Analysis_Args##            
   Market_Analysis_Manager();   
   // definição das bandeiras Booleanas                      ##Market_Analysis_Args##
   Flag_Init();  
   // definição das variaveis globais de inicialização       ##Market_Analysis_Args##
   Global_Var_Init();
   // Call, Indexação, Séries - indicadores.                 ##Market_Analysis_Indicators##     
   Indicators_Market_Analysis();
   // Inicialização do set de arquivos que compôe o Debug.   ##Market_Analysis_Debug##    
   Debug_Set_Init();   
       
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Indicators_Market_Analysis_Release();
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
 { 
  // verificação dos dados tick a tick
  Tick_Control();                                      // ##Market_Analysis_Date_Control##
  // tempo do tick para toda a rotina Ontick  
  TimeToStruct(Global.date1 = TimeCurrent(),str1);     // em datetime
  Global.tick_unixtime = TimeCurrent();                // em string unixtime
  // Faz o Reset diário do Market_Analysis_First_Tick                                
  Market_Analysis_Reset();                             // ##Market_Analysis_Misc##
  // controle de dias incompletos: str1.hour < 17
  Date_Control_Close();                                // ##Market_Analysis_Misc##
  // resets, referencias e controle de datas  
  Market_Analysis_First_Tick();                        // ##Market_Analysis_Misc##
  
  //+------------------------------------------------------------------+
  //| ANALISE DOS DESVIOS PADROES                                      |
  //+------------------------------------------------------------------+  
  if( Market.Habilitar_Sigma_Analysis == true )
    {  
     Sigma_Open();                                       // ##Market_Analysis_Sigma_Open##
     Sigma_NY();                                         // ##Market_Analysis_Sigma_NY##
     Sigma_Tarde();                                      // ##Market_Analysis_Sigma_Tarde##
     Files_Alloc_Sigma();                                // ##Market_Analysis_Files##
    } 
  
  //+------------------------------------------------------------------+
  //| ANALISE DA VOLATILIDADE                                          |
  //+------------------------------------------------------------------+   
  if( Market.Habilitar_Volatility_Analysis == true )
    { 
     Volatilidade();                                     // ##Market_Analysis_Volatility##  
    }
  
 }   // fim da OnTick()




  