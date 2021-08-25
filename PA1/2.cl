{\rtf1\ansi\ansicpg1252\cocoartf1561\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
\
class List \{\
  \
\
   isNil() : Bool \{ true \};\
\
\
\
   head()  : Int \{ \{ abort(); 0; \} \};\
\
\
   tail()  : List \{ \{ abort(); self; \} \};\
\
   cons(i : Int) : List \{\
      (new Cons).init(i, self)\
   \};\
\
\};\
\
\
class Cons inherits List \{\
\
   car : Int;\
\
   cdr : List;	\
\
   isNil() : Bool \{ false \};\
\
   head()  : Int \{ car \};\
\
   tail()  : List \{ cdr \};\
\
   init(i : Int, rest : List) : List \{\
      \{\
	 car <- i;\
	 cdr <- rest;\
	 self;\
      \}\
   \};\
\
\};\
\
\
\
\
class Main inherits IO \{\
\
   mylist : List;\
    copy_mylist : List;\
    n:Int;\
    m:Int;\
    index:Int;\
    count:Int ;\
    flag:Int;\
    j2:Int;\
\
\
   print_list(l : List) : Object \{\
      if l.isNil() then out_string("\\n")\
                   else \{\
			   out_int(l.head());\
			   out_string(" ");\
			   print_list(l.tail());\
		        \}\
      fi\
   \};\
\
\
\
   main() : Object \{\
      \{\
     out_string("How many numbers  to sort? ");\
     n <- in_int();\
     out_string("input your number in n Row");\
     \
	 mylist <- new List.cons(in_int());\
\
	 \
		flag<-1;\
		(let j : Int <- 0 in\
             while j < n-1 \
                 loop \
                     \{\
                     m <-in_int();\
             \
                     copy_mylist<-mylist;\
                     (let j1 : Int <- 0 in\
                        while not copy_mylist.isNil() \
                             loop \
                              \{\
                                  if m < copy_mylist.head()  then \{\
                                  \
                                  index<-j1+1;\
                                  flag<-0 ;\
                                  \}\
                                  else \
                                  \{\
                                  flag<-flag;\
                                  \
                                  \}\
              					  fi;\
                               	 copy_mylist<-copy_mylist.tail();\
								 j1 <- j1 + 1;\
                              \}\
                            pool\
                     );\
                     if flag=1 then\{\
                         mylist <- mylist.cons(m);\
                        \
                         \
                         \}\
\
                         else\{ \
                         flag<-1;\
                         j2  <- 0 ;\
                            \
                        while not mylist.isNil() \
                             loop \
                              \{\
                                  if index=j2  then\{\
                                      copy_mylist<- copy_mylist.cons(m);\
                                      \
                                      \
                                  \}\
                                  \
                                  else \
                                  \{\
                                      copy_mylist<- copy_mylist.cons(mylist.head());\
                                       mylist<-mylist.tail();\
                                      \
                                      \
                                  \}\
              					  fi;\
                               	\
								 j2 <- j2 + 1;\
                              \}\
                            pool;\
									if index=j2  then\{\
                            \
                                    copy_mylist<- copy_mylist.cons(m);\
                                  \}\
                            else index<-index\
                                  fi;\
\
                             \
\
                             while not copy_mylist.isNil()   \
                             loop\{\
                                 mylist<-mylist.cons(copy_mylist.head());  \
                             copy_mylist  <-copy_mylist.tail()  ;\
                                   \
                            \
                         \}\
                        pool;\
                         \}\
             		 fi;\
                     \
                     j <- j + 1;\
                     \} \
                 pool\
		);\
	 \
         \
\
	       print_list(mylist);\
\
          \
           \
	   	   out_string("\\n\\n\\n");\
	    \}\
		\
      \
   \};\
\
\};}