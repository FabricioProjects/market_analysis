//-------------------------------------------------------------------+
//|                                              Market_Analysis.mq5 |
//|                                            Copyright 2014 - 2016 |
//|                                               by Fabrício Amaral |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014 - 2016, Fabrício Amaral"
#property link      "http://executive.com.br/"

//+------------------------------------------------------------------+
//| Parametros de entrada                                            |
//+------------------------------------------------------------------+
// Numero do robo
input int      Robo = 3;              // 0 = Genesis  1 = Impetus  2 = Nature  3 = Market_Analysis

// ##########################################################################################################

//+------------------------------------------------------------------+
//| Pre Defined Structs                                              |
//+------------------------------------------------------------------+
// Information about the prices, volumes and spread of each candle. 
MqlRates            mrate[]; 
// The date type structure contains eight fields of the int type. 
MqlDateTime         str1;
MqlDateTime         str2;

//+------------------------------------------------------------------+
//| MARKET ANALYSIS MANAGMENT                                        |
//+------------------------------------------------------------------+
void Market_Analysis_Manager()
  {
   Market.Habilitar_Sigma_Analysis       = true;     // habilitacao da analise de desvios padroes
   Market.Habilitar_Volatility_Analysis  = false;    // habilitacao da analise de volatilidade
   Market.Regimes                        = true;     // habilitacao dos regimes high volat e low volat
   Market.Sigma_sl_Factor_HV             = false;    // habilitacao da analise da transformação sigma preço
   Market.Sigma_sl_Factor_LV             = false;     // habilitacao da analise da transformação sigma preço
   
   Market.Debug                          = true;     // habilitacao do debug
    
  }

// Desabilita as analises de mercado
void Market_Analysis_Manager_False()   
  {
   Market.Habilitar_Sigma_Analysis       = false;
   Market.Habilitar_Volatility_Analysis  = false; 
  }  
  
//+------------------------------------------------------------------+
//| Signals                                                          |
//+------------------------------------------------------------------+
// Booleanos utilizados na analise de mercado
void Flag_Init()
  {
   Flag.first_tick   = false;     // bandeira dos resets apos o primeiro tick                     
   Flag.sigma_alloc  = false;     // bandeira da alocação do sigma
   Flag.volat_alloc  = false;     // bandeira da alocação da volatilidade
   Flag.sl           = false;     // bandeira de analise da transformação sigma preço
   Flag.delta        = false;     // bandeira de analise da transformação sigma preço
  }
      
//+------------------------------------------------------------------+
//| Definição de Variáveis Globais                                   |
//+------------------------------------------------------------------+
// definição das variaveis globais de inicialização
void Global_Var_Init()
   {
    // identificadores
    Global.identificador = MQLInfoString(MQL_PROGRAM_NAME);   // nome do robo e ativo
    Global.folder_symbol = _Symbol+"_M"+(string)Period();        
    Global.subfolder = Global.identificador+"_"+Global.folder_symbol;
    // analise sigma
    Global.sigma_i = 1;         // passo da alocação
    // analise volatilidade
    Global.volat_i = 1;         // passo da alocação
    
    Global.count_mean_HV_open  = 1;
    Global.count_mean_HV_NY    = 1;
    Global.count_mean_HV_tarde = 1;
    Global.count_mean_LV_open  = 1;
    Global.count_mean_LV_NY    = 1;
    Global.count_mean_LV_tarde = 1;
    
    Symbol_Definitions();       // definições q dependem do ativo e timeframe  ##Market_Analysis_Misc## 
    
   }

//+------------------------------------------------------------------+
//| MARKET ANALYSIS MANAGMENT                                        |
//+------------------------------------------------------------------+
struct Args_Market_Analysis
  {
   bool Habilitar_Sigma_Analysis;
   bool Habilitar_Volatility_Analysis;
   bool Regimes;
   bool Sigma_sl_Factor_HV;
   bool Sigma_sl_Factor_LV;
   bool Debug;
    
  } Market;
  
//+------------------------------------------------------------------+
//| FLAGS                                                            |
//+------------------------------------------------------------------+
struct Flag_Market_Analysis
  {
   bool first_tick;      // bandeira dos resets apos o primeiro tick                     
   bool sigma_alloc;     // bandeira da alocação do sigma
   bool volat_alloc;     // bandeira da alocação da volatilidade
   bool sl;              // bandeira de analise da transformação sigma preço
   bool delta;           // bandeira de analise da transformação sigma preço
   bool first_sigma_HV;     // bandeira do sigma de abertura
   bool first_sigma_LV;
   
  } Flag;  

//+------------------------------------------------------------------+
//| Struct de Variáveis Globais                                      |
//+------------------------------------------------------------------+
struct Global_Variables   
  {
   // datetime
   datetime date1;                                // variaveis globais para uso e manipulação do datetime a cada tick
   datetime date2;                                // variaveis globais para uso e manipulação do datetime a cada tick
   // string
   string   identificador;                        // nome da pasta de saida q contem os arquivos gerados no codigo em simulação
   string   folder_symbol;                        // ativo da pasta de saida q contem os arquivos gerados pelo market analysis
   string   subfolder;
   // int
   int      filehandle_Date_Control;              // handle do arquivo de controle de datas
   int      filehandle_Tick_Control;              // handle da saida do delay entre ticks
   int      filehandle;                           // handle da saida de debug
   int      filehandle_alert;                     // handle da saida de alertas
   int      sigma_i;                              // elemento do vetor de alocação
   int      filehandle_Sigma_Max;                 // handle da saida Sigma_Max_Min
   int      filehandle_Sigma_Horario;             // handle da saida Sigma_Horario
   int      filehandle_Sigma_Max_HV;              // handle da saida Sigma_Max_Min
   int      filehandle_Sigma_Horario_HV;          // handle da saida Sigma_Horario
   int      filehandle_Sigma_Max_LV;              // handle da saida Sigma_Max_Min
   int      filehandle_Sigma_Horario_LV;          // handle da saida Sigma_Horario
   int      filehandle_Delta_Sigma_HV;            // handle da saida Delta_Sigma_HV    
   int      filehandle_Delta_Sigma_LV;            // handle da saida Delta_Sigma_LV
   int      volat_i;                              // elemento do vetor de alocação
   int      filehandle_Volat_Max_Min;             // handle da saida Volat_Max_Min
   int      filehandle_Volat_Max;                 // handle da saida Volat_Max
   int      filehandle_Volat_Min;                 // handle da saida Volat_Min
   int      filehandle_Volat_Horario_Max;         // handle da saida Volat_Horario
   int      filehandle_Volat_Horario_Min;         // handle da saida Volat_Horario
   // long
   long     first_tick_unixtime;                  // unixtime do inicio do mercado futuro
   long     tick_unixtime;                        // unixtime da função on_tick
   long     prev_unixtime;                        // unixtime do tick anterior
   long     actual_unixtime;                      // unixtime do tick atual
   long     unixtime_dinamico_sigma;              // unixtime dinamico > 2 sigma 
   long     unixtime_dinamico_sigma_HV;           // unixtime dinamico regime high_volat
   long     unixtime_dinamico_sigma_LV;           // unixtime dinamico regime low_volat
   long     unixtime_dinamico_sigma_HV_Tarde;     // unixtime dinamico regime high_volat
   long     unixtime_dinamico_sigma_LV_Tarde;     // unixtime dinamico regime low_volat
   long     unixtime_dinamico_sigma_HV_NY;        // unixtime dinamico regime high_volat
   long     unixtime_dinamico_sigma_LV_NY;        // unixtime dinamico regime low_volat
   long     horario_sigma;                        // unixtime da alocação sigma 
   long     timer_inicial_unixtime;
   long     timer;
   long     unixtime_dinamico_max_volat;          // unixtime dinamico > 0
   long     unixtime_dinamico_min_volat;          // unixtime dinamico < 0
   long     horario_volat;                        // unixtime dinamico do track da volatilidade
   // double
   double   pip;
   double   sigma_buffer[1600];                   // alocaçao das maximas dinamicas do sigma
   double   sigma_buffer_HV[1600];                // alocaçao das maximas no regime high_volat
   double   sigma_buffer_LV[1600];                // alocaçao das maximas no regime low_volat
   double   sigma_buffer_HV_Tarde[1600];          // alocaçao das maximas no regime high_volat
   double   sigma_buffer_LV_Tarde[1600];          // alocaçao das maximas no regime low_volat
   double   sigma_buffer_HV_NY[1600];             // alocaçao das maximas no regime high_volat
   double   sigma_buffer_LV_NY[1600];             // alocaçao das maximas no regime low_volat
   
   int      filehandle_First_Sigma_HV;
   int      filehandle_First_Sigma_LV;
   int      filehandle_Horario_First_Sigma_HV;
   int      filehandle_Horario_First_Sigma_LV;
   
   // calculo da media do sigma
   int      filehandle_Sigma_Mean;                // handle da saida Sigma_Mean
   int      count_mean_HV_open;
   double   mean_buffer_HV_open[1600]; 
   double   mean_HV_open;
   int      count_mean_HV_NY;
   double   mean_buffer_HV_NY[1600];
   double   mean_HV_NY;
   int      count_mean_HV_tarde; 
   double   mean_buffer_HV_tarde[1600]; 
   double   mean_HV_tarde;
   int      count_mean_LV_open;
   double   mean_buffer_LV_open[1600]; 
   double   mean_LV_open;
   int      count_mean_LV_NY;
   double   mean_buffer_LV_NY[1600]; 
   double   mean_LV_NY;
   int      count_mean_LV_tarde;
   double   mean_buffer_LV_tarde[1600]; 
   double   mean_LV_tarde;             
   
   double   sigma_1;                              // 1 desvio padrao
   double   delta;                                // sobra alem de 2 sigma
   double   sigma_dinamico;                       // desvio padrao q o preço se encontra
   double   volat_referencia;                     // primeiro tick do dia do BBandwith
   double   volat_buffer_max[1600];               // alocaçao das maximas dinamicas do sigma
   double   volat_buffer_min[1600];               // alocaçao das minimas dinamicas do sigma
   double   volat_mean;                           // volatilidade media dependente do ativo e timeframe
   double   volat_min;                            // volatilidade minima dependente do ativo e timeframe
   // analise da transformação sigma preço
   double   delta_price;
   double   price_start;
   double   sigma_start;
   double   price_sl_HV[1600];
   double   delta_sigma_sl_HV[1600];
   double   price_sl_LV[1600];
   double   delta_sigma_sl_LV[1600]; 
   
  } Global;


//+------------------------------------------------------------------+