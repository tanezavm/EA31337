//+------------------------------------------------------------------+
//|                 EA31337 - multi-strategy advanced trading robot. |
//|                       Copyright 2016-2020, 31337 Investments Ltd |
//|                                       https://github.com/EA31337 |
//|                                                     ea-input.mqh |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, kenorb" // ©
#property link      "https://github.com/EA31337"

//+------------------------------------------------------------------+
//| Includes.
//+------------------------------------------------------------------+
#include "..\ea-enums.mqh"
#include "..\..\EA31337-classes\Condition.mqh"

//+------------------------------------------------------------------+
//| User input variables.
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
extern string __Trade_Parameters__ = "-- Trade parameters --"; // >>> TRADE <<<
extern uint   MaxOrders = 0; // Max orders (0 = auto)
extern uint   MaxOrdersPerType = 0; // Max orders per type (0 = auto)
uint   MaxOrdersPerDay = 0; // Max orders per day (0 = unlimited)
extern double LotSize = 0; // Lot size (0 = auto)
extern bool   TradeMicroLots = 1; // Trade micro lots?
int           TrendMethod = 0; // Main trend method (0-255)
extern int    MinVolumeToTrade = 2; // Min volume to trade
extern int    MaxOrderPriceSlippage = 50; // Max price slippage (in pts)
extern int    MaxTries = 5; // Max retries for opening orders
extern double MinPipChangeToTrade = 0.0; // Min pip change to trade
extern int    MinPipGap = 10; // Min gap between trades per type (in pips)
//extern uint   TickProcessMethod = 0; // Tick process method (0-8, 0 - all)

//+------------------------------------------------------------------+
extern string   __EA_Order_Parameters__ = "-- Profit and loss parameters --"; // >>> PROFIT/LOSS <<<
extern uint     TakeProfitMax = 0; // Max Take profit (in pips, 0 = auto)
extern uint     StopLossMax = 40; // Max Stop loss (in pips, 0 = auto)

//+------------------------------------------------------------------+
extern string __EA_Trailing_Parameters__ = "-- Profit and loss trailing parameters --"; // >>> TRAILINGS <<<
ENUM_TRAIL_TYPE DefaultTrailingStopMethod = 0; // Default trail stop method (0 = none)
ENUM_TRAIL_TYPE DefaultTrailingProfitMethod = 0; // Default trail profit method
extern int TrailingStop = 50; // Extra trailing stop (in pips)
extern int TrailingProfit = 0; // Extra trailing profit (in pips)
extern double TrailingStopAddPerMinute = 0.3; // Decrease trail stop per minute (pip/min)

//+------------------------------------------------------------------+
extern string __EA_Risk_Parameters__ = "-- Risk management parameters --"; // >>> RISK <<
extern double RiskMarginPerOrder = 1; // Risk margin per order (in %, 0-100, 0 - auto, -1 - off)
extern double RiskMarginTotal = 5; // Risk margin in total (in %, 0-100, 0 - auto, -1 - off)
extern double RiskRatio = 0; // Risk ratio (0 = auto, 1.0 = normal)
extern int RiskRatioIncreaseMethod = 0; // Risk ratio increase method (0-255)
extern int RiskRatioDecreaseMethod = 0; // Risk ratio decrease method (0-255)
extern int InitNoOfDaysToWarmUp = 14; // Initial warm-up period (in days)
extern double CloseOrderAfterXHours = 96; // Close order after X hours (>0 - all, <0 - only profitable 0 - off)

//+------------------------------------------------------------------+
extern string __Strategy_Profit__ = "-- Per strategy parameters (0 to disable) --"; // >>> STRATEGY PARAMS <<<
extern double ProfitFactorMinToTrade = 0.9; // Min. profit factor per strategy to trade
extern double ProfitFactorMaxToTrade = 0.0; // Max. profit factor per strategy to trade
extern int InitNoOfOrdersToCalcPF = 20; // Initial number of orders to calculate profit factor

//+------------------------------------------------------------------+
extern string __Strategy_Boosting_Parameters__ = "-- Strategy boosting parameters (set 1.0 for default) --"; // >>> BOOSTING <<<
extern bool Boosting_Enabled = 0; // Enable boosting
extern double BoostTrendFactor = 0.9; // Boost by trend factor
extern bool StrategyBoostByPF = 1.1; // Boost strategy by its profit factor
extern bool StrategyHandicapByPF = true; // Handicap by its low profit factor
extern double BestDailyStrategyMultiplierFactor = 1.0; // Multiplier for the best daily strategy
extern double BestWeeklyStrategyMultiplierFactor = 1.0; // Multiplier for the best weekly strategy
extern double BestMonthlyStrategyMultiplierFactor = 1.0; // Multiplier for the best monthly strategy
extern double WorseDailyStrategyMultiplierFactor = 1.0; // Multiplier for the worse daily strategy
extern double WorseWeeklyStrategyMultiplierFactor = 1.0; // Multiplier for the worse weekly strategy
extern double WorseMonthlyStrategyMultiplierFactor = 1.0; // Multiplier for the worse monthly strategy
extern double ConWinsIncreaseFactor = 0.4; // Increase lot factor on consequent wins (in %, 0 - off)
extern double ConLossesIncreaseFactor = 0.7; // Increase lot factor on consequent loses (in %, 0 - off)
extern uint ConFactorOrdersLimit = 600; // No of orders to check on consequent wins/loses

//+------------------------------------------------------------------+
extern string __SmartQueue_Parameters__ = "-- Smart queue parameters --"; // >>> SMART QUEUE <<<
extern bool SmartQueueActive = 1; // Activate QueueAI
extern int SmartQueueMethod = 11; // QueueAI: Method for selecting the best order (0-15)
extern int SmartQueueFilter = 72; // QueueAI: Method for filtering the orders (0-255)

//+------------------------------------------------------------------+
extern string __EA_Account_Conditions__ = "-- Account conditions --"; // >>> CONDITIONS & ACTIONS <<<
extern bool Account_Conditions_Active = 0; // Enable account conditions (don't enable for multibot trading)
// Condition 5 - Equity 1% high
extern ENUM_ACC_CONDITION Account_Condition_1 = 5; // 1. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_1 = 5; // 1. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_1 = 10; // 1. Action to take
// Condition 6 - Equity 10% high
extern ENUM_ACC_CONDITION Account_Condition_2 = 0; // 2. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_2 = 8; // 2. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_2 = 7; // 2. Action to take
// Condition 10 - 50% Margin Used
extern ENUM_ACC_CONDITION Account_Condition_3 = 0; // 3. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_3 = 1; // 3. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_3 = 0; // 3. Action to take
// Condition 17 - Max. daily balance < max. weekly
extern ENUM_ACC_CONDITION Account_Condition_4 = 17; // 4. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_4 = 16; // 4. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_4 = 7; // 4. Action to take
//
extern ENUM_ACC_CONDITION Account_Condition_5 = 0; // 5. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_5 = 0; // 5. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_5 = 0; // 5. Action to take

extern int Account_Condition_MinProfitCloseOrder = 20; // Min pip profit on action to close

//+------------------------------------------------------------------+
extern string __EA_Account_Conditions_Params__ = "-- Account conditions parameters --"; // >>> CONDITIONS & ACTIONS PARAMS <<<
extern int MarketSpecificHour = 10; // Specific hour used for conditions (0-23)
extern bool CloseConditionOnlyProfitable = 1; // Apply close condition only for profitable orders

//+------------------------------------------------------------------+
extern string __Experimental_Parameters__ = "-- Experimental parameters (not safe) --"; // >>> EXPERIMENTAL <<<
// Set stop loss to zero, once the order is profitable.
extern bool MinimalizeLosses = 0; // Minimalize losses?
int HourAfterPeak = 18; // Hour after peak
int ManualGMToffset = 0; // Manual GMT Offset
// How often trailing stop should be updated (in seconds). FIXME: Fix relative delay in backtesting.
int TrailingStopDelay = 0; // Trail stop delay (in secs)
// How often job list should be processed (in seconds).
int JobProcessDelay = 1; // Job process delay (in secs)

// Cache some calculated variables for better performance. FIXME: Needs some work.
#ifdef __experimental__
  extern bool Cache = false; // Cache
#else
  const bool Cache = false; // Cache
#endif

//+------------------------------------------------------------------+
extern string __Logging_Parameters__ = "-- Settings for logging & messages --"; // >>> LOGS & MESSAGES <<<
extern bool WriteReport = 1; // Write summary report on finish
extern bool PrintLogOnChart = 1; // Display info on chart
extern bool VerboseErrors = 1; // Display errors
extern bool VerboseInfo = 1; // Display info messages
#ifdef __debug__
  extern bool VerboseDebug = 0; // Display debug messages
  extern bool VerboseTrace = 0; // Display trace messages
#else
  bool VerboseDebug = 0;
  bool VerboseTrace = 0;
#endif

//+------------------------------------------------------------------+
extern string __UI_UX_Parameters__ = "-- Settings for User Interface & Experience --"; // >>> UI & UX <<<
extern bool SendEmailEachOrder = 0; // Send e-mail per each order
extern color ColorBuy = 16711680; // Color: Buy
extern color ColorSell = 255; // Color: Sell
extern bool SoundAlert = 0; // Enable sound alerts
extern string SoundFileAtOpen = "alert.wav"; // Sound: on order open
extern string SoundFileAtClose = "alert.wav"; // Sound: on order close
// extern bool SendLogs = false; // Send logs to remote host for diagnostic purposes
//+------------------------------------------------------------------+

extern string __Optimization_Parameters__ = "-- Optimization parameters --"; // >>> OPTIMIZATION <<<
#ifdef __optimize__ extern #endif ENUM_TIMEFRAMES TrendPeriod = 30; // Period for trend calculation

extern string __Backtest_Parameters__ = "-- Testing & troubleshooting parameters --"; // >>> TESTING <<<
#ifndef __backtest__
  extern bool ValidateSettings = 0; // Validate startup settings
#else
  extern bool ValidateSettings = 1; // Validate startup settings
#endif
extern bool RecordTicksToCSV = 0; // Record ticks into CSV files
extern int AccountConditionToDisable = 0; // Override: Disable specific n action
extern bool DisableCloseConditions = 0; // Override: Disable all close conditions
// extern int DemoMarketStopLevel = 10; // Demo market stop level

//+------------------------------------------------------------------+
extern string __EA_Constants__ = "-- Constants --"; // >>> CONSTANTS <<<
extern int MagicNumber = 31337; // Unique EA magic number (+40)

//+------------------------------------------------------------------+
extern string __Other_Parameters__ = "-- Other parameters --"; // >>> OTHER <<<
