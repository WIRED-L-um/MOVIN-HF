options nofmterr yearcutoff=1920 pagesize=60 linesize=120 pageno=1 nodate compress=yes;

/** ========================================================================================== **/
/**    To evaluate evaluate the association between EMAs of psychosocial states and 
                    short-term step count (12-hours after EMA [primary] 
                          and 4-hours after EMA [exploratory]). 
/** ========================================================================================== **/


%macro outcome(x=);
ods pdf file="<path>\Mixed_&x..pdf";

/** outcome stepcounts 12 hours after EMA **/
PROC MIXED DATA=<Data>;
CLASS GENDER PID timeofday;
model  LogSteps_12hrAfter=&x Gender Age_years_int EMATimeID time_of_day/s ;
 random int/subject=PID type=un; 
run;

/** outcome stepcounts 4 hours after EMA **/
PROC MIXED DATA=<Data>;
CLASS GENDER PID timeofday;
model  LogSteps_04hrAfter=&x Gender Age_years_int EMATimeID timeofday/s;
 random int/subject=PID type=un;
ods output CovParms=CovEstimates_&x;  
run;

data _null_;
   set CovEstimates_&x;
   if CovParm = "Intercept" then between_group_var = Estimate;       * Between-group variance;
   if CovParm = "Residual" then within_group_var = Estimate;         * Within-group variance;
   call symputx('ICC', between_group_var / (between_group_var + within_group_var));
run;

%put The ICC is: &ICC;

proc print;
run;
ods pdf close;
%mend;
%outcome(x=EMA_Comp_Score);
%outcome(x=EMA_EV_Score);
%outcome(x=EMA_Fear_Score);
%outcome(x=EMA_HF_Score_Binary);
%outcome(x=EMA_MAN_Score);
%outcome(x=EMA_MAP_Score);

/** sensitivity analysis using The average of the 5 individual 
Heart Failure question scores, 
where each question is scored on a descending linear scale. **/
%outcome(x=EMA_HF_Score_Linear); 



/** sensitivity analysis within 27 days **/
%macro outcome(x=);
ods pdf file="<path>\Mixed_sensitive_&x..pdf";

PROC MIXED DATA=<Data>;
CLASS GENDER PID timeofday;
where newtime le 54;
model  LogSteps_12hrAfter=&x Gender Age_years_int EMATimeID timeofday/s;
 random int/subject=PID type=un;
run;

ods pdf close;
%mend;
%outcome(x=EMA_Comp_Score);
%outcome(x=EMA_EV_Score);
%outcome(x=EMA_Fear_Score);
%outcome(x=EMA_HF_Score_Binary);
%outcome(x=EMA_MAN_Score);
%outcome(x=EMA_MAP_Score);



/** Uing all EMAs into the model **/
ods pdf file="<path>\Mixed_model.pdf";

PROC MIXED DATA=<Data>;
CLASS GENDER PID Timeofday;
model  LogSteps_12hrAfter=EMA_Comp_Score
EMA_EV_Score
EMA_Fear_Score
EMA_HF_Score_Binary
EMA_MAN_Score
EMA_MAP_Score
 Gender Age_years_int EMATimeID Timeofday/s;
 random int/subject=PID type=un;
run;

ods pdf close;
