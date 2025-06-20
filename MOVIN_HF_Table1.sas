options nofmterr yearcutoff=1920 pagesize=60 linesize=120 pageno=1 nodate compress=yes;

data mcom;
 length level $ 150
 pvalue $ 17
 ci c1 c2 ctotal $ 40;
 nvar=1; _line=0.5;  level="Age"; pvalue=''; output;
 nvar=2; _line=0.5;  level='Gender'; pvalue=''; output;
 nvar=3; _line=0.5; level="Asian"; pvalue=''; output;
 nvar=4; _line=0.5; level='Black'; pvalue=''; output;
 nvar=5; _line=0.5; level='White'; pvalue=''; output;
 nvar=6; _line=0.5; level="NYHAClass"; pvalue=''; output;
 nvar=7; _line=0.5; level="Heart failure with improved ejection fraction"; pvalue=''; output;
 nvar=8; _line=0.5; level="Heart failure with mildly reduced ejection fraction"; pvalue=''; output;
 nvar=9; _line=0.5; level="Heart failure with preserved ejection fraction"; pvalue=''; output;
 nvar=10; _line=0.5; level="Heart failure with reduced ejection fraction"; pvalue=''; output;
 run;

%Include '<path>\Table.sas';
%Table(dsn=<data>,
var =
Age_years_int
Gender 
IsRaceAsian
IsRaceBlackorAfricanAmerican
IsRaceWhite
NYHAClass
IsHFTypeHFimpEF
IsHFTypeHFmrEF
IsHFTypeHFpEF
IsHFTypeHFrEF,
type=c d d d d d d d d d d,
labelwrap=y,
dvar= 1 1 1 1 1 2 3 3 4 4 5 5 6 7 7 8 8 9 9 10 10,
dline=1 2 4 5 6 1 1 2 1 2 1 2 1 1 2 1 2 1 2 1 2,
comments=mcom,
outdoc=<path>\Table1.rtf,
meandec=2,
ttitle1=Demographic characteristics of MOVIN-HF study); 

