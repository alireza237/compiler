


class C {
    a : Int;

    

    self : Bool;
    b: Int;
    

        init(x : Int, y : Int) : C {
               {
            a <- "d";
            self <- y;
            self;
               }
        };
    
    };

class D inherits C{
a:Bool;
i:Int <- 0;

    init(x : Int, y : Int) : D {
           {
               a <-  true=1;
        self <- y;
        if 1 then "" else
            (let next : Int <- i / 10 in
                i2a_aux(next).concat(i2c(i - next * 10))
            )
            fi;
        self;
           }
    };
    
    
};
Class Main {
    main():C {
     {
        
         (new C).iinit(1,true);
      (new C).init(1,1);
      (new C).init(1,true,3);
      
    
      
     }
    };
};
