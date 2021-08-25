{\rtf1\ansi\ansicpg1252\cocoartf1561\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 class Main inherits IO \{\
    input : String;\
    b:Int;\
    n:Int;\
    \
    \
    main(): Object \{\
\{\
        out_string("Please enter ");\
        input <-in_string();\
        n <- input.length();\
   \
    \
	\
		(let j : Int <- 0 in\
		 while j < n \
		 loop \
		 \{\
             \
		 if input.substr(j,1)="(" then b<-b+1 else b<-b-1\
             fi;\
		 j <- j + 1;\
		 \} \
		 pool\
		);\
	 \
\
    		\
    	 if b=0 then out_string("Yes") else out_string("NO")\
             fi;\
    out_string("\\n");\
        \}\
    \};\
        \
\};\
\
}