options nofmterr yearcutoff=1920 pagesize=60 linesize=120 pageno=1 nodate compress=yes;

/** ========================================================================================== **/
/** To evaluate the association between baseline psychosocial traits and mean daily step count **/
/** ========================================================================================== **/



%macro out(x=);
ods pdf file="C:\Users\tanima\OneDrive - Michigan Medicine\Desktop\Office\kgrant\Association_&x..pdf";

PROC MIXED DATA=<DATA>;
CLASS  PID Gender;
model  value= &x Gender Age_years_int/s;
 random int/subject=PID type=un; 
run;

ods pdf close;
%mend;
%out(x=BREQ_Amot_Score);
%out(x=AVGIntReg);
%out(x=BREQ_IdReg_Score);
%out(x=BREQ_IntReg_Score);
%out(x=Exp_Physical_Score);
%out(x=Exp_SelfEval_Score);
%out(x=Exp_Social_Score);
%out(x=PAB_Score_SomewhatVery);
%out(x=PHQ_Score);
%out(x=Rel_Score);




/** All survey scores were used in one model **/
ods pdf file="<path>\Association_survey.pdf";

PROC MIXED DATA=<DATA>;
CLASS  PID Gender;
model  value= BREQ_Amot_Score
BREQ_ContMot_Score
BREQ_IdReg_Score
BREQ_IntReg_Score
Exp_Physical_Score
Exp_SelfEval_Score
Exp_Social_Score
PAB_Score_SomewhatVery
PHQ_Score
Rel_Score
Gender Age_years_int/s;
 random int/subject=PID type=un; 
run;
ods pdf close;
