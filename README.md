# utl-collapse-column-values-by-removing-missing-values
Collapse column values by removing missing values 
    Collapse column values by removing missing values                                                                                      
                                                                                                                                           
    Self update method does not work for this table                                                                                        
                                                                                                                                           
     Three solutions                                                                                                                       
                                                                                                                                           
       a. Macro utilities and merge                                                                                                        
                                                                                                                                           
       b. Datastep array                                                                                                                   
          Paul Dorfman                                                                                                                     
          sashole@bellsouth.net                                                                                                            
                                                                                                                                           
       c. Hash                                                                                                                             
          Paul Dorfman                                                                                                                     
          sashole@bellsouth.net                                                                                                            
                                                                                                                                           
                                                                                                                                           
    github                                                                                                                                 
    https://tinyurl.com/y9bo45ay                                                                                                           
    https://github.com/rogerjdeangelis/utl-collapse-column-values-by-removing-missing-values                                               
                                                                                                                                           
    related to                                                                                                                             
    https://tinyurl.com/y7w9wzp5                                                                                                           
    https://stackoverflow.com/questions/62095064/how-can-i-extract-a-position-of-values-that-match-a-logical-selection-in-a-matri          
                                                                                                                                           
    macros                                                                                                                                 
    https://tinyurl.com/y9nfugth                                                                                                           
    https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                                             
                                                                                                                                           
    *_                   _                                                                                                                 
    (_)_ __  _ __  _   _| |_                                                                                                               
    | | '_ \| '_ \| | | | __|                                                                                                              
    | | | | | |_) | |_| | |_                                                                                                               
    |_|_| |_| .__/ \__,_|\__|                                                                                                              
            |_|                                                                                                                            
    ;                                                                                                                                      
                                                                                                                                           
    options validvarname=upcase;                                                                                                           
    libname sd1 "d:/sd1";                                                                                                                  
    data sd1.have;                                                                                                                         
     input v1 v2 v3;                                                                                                                       
     if v1 ne 0 then v1=.; else v1=_n_;                                                                                                    
     if v2 ne 0 then v2=.; else v2=_n_;                                                                                                    
     if v3 ne 0 then v3=.; else v3=_n_;                                                                                                    
    cards4;                                                                                                                                
    0 1 1                                                                                                                                  
    1 0 0                                                                                                                                  
    0 1 0                                                                                                                                  
    1 1 0                                                                                                                                  
    1 1 0                                                                                                                                  
    ;;;;                                                                                                                                   
    run;quit;                                                                                                                              
                                                                                                                                           
                          | RULE                                                                                                           
     SD1.HAVE total obs=5 |                                                                                                                
                          | Remove missing and shit up                                                                                     
      V1    V2    V3      |                                                                                                                
                          |                                                                                                                
       1     .     .      |                                                                                                                
       .     2     2      |                                                                                                                
       3     .     3      |                                                                                                                
       .     .     4      |                                                                                                                
       .     .     5      |                                                                                                                
                                                                                                                                           
                                                                                                                                           
    *            _               _                                                                                                         
      ___  _   _| |_ _ __  _   _| |_                                                                                                       
     / _ \| | | | __| '_ \| | | | __|                                                                                                      
    | (_) | |_| | |_| |_) | |_| | |_                                                                                                       
     \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                      
                    |_|                                                                                                                    
    ;                                                                                                                                      
                                                                                                                                           
    work.WANT total obs=4                                                                                                                  
                                                                                                                                           
       V1    V2    V3                                                                                                                      
                                                                                                                                           
        1     2     2                                                                                                                      
        3     .     3                                                                                                                      
        .     .     4                                                                                                                      
        .     .     5                                                                                                                      
                                                                                                                                           
    *                                                                                                                                      
     _ __  _ __ ___   ___ ___  ___ ___                                                                                                     
    | '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                                    
    | |_) | | | (_) | (_|  __/\__ \__ \                                                                                                    
    | .__/|_|  \___/ \___\___||___/___/                                                                                                    
    |_|                                                                                                                                    
      __ _     _ __ ___   __ _  ___ _ __ ___    _ __ ___   ___ _ __ __ _  ___                                                              
     / _` |   | '_ ` _ \ / _` |/ __| '__/ _ \  | '_ ` _ \ / _ \ '__/ _` |/ _ \                                                             
    | (_| |_  | | | | | | (_| | (__| | | (_) | | | | | | |  __/ | | (_| |  __/                                                             
     \__,_(_) |_| |_| |_|\__,_|\___|_|  \___/  |_| |_| |_|\___|_|  \__, |\___|                                                             
                                                                   |___/                                                                   
    ;                                                                                                                                      
    %array(vars,values=%utl_varlist(data=sd1.have));                                                                                       
                                                                                                                                           
    data want;                                                                                                                             
      merge %do_over(vars,phrase=%str(sd1.have(keep=? where=(? ne .)) ) ) ;                                                                
    run;quit;                                                                                                                              
                                                                                                                                           
    *_            _       _            _                                                                                                   
    | |__      __| | __ _| |_ __ _ ___| |_ ___ _ __     __ _ _ __ _ __ __ _ _   _                                                          
    | '_ \    / _` |/ _` | __/ _` / __| __/ _ \ '_ \   / _` | '__| '__/ _` | | | |                                                         
    | |_) |  | (_| | (_| | || (_| \__ \ ||  __/ |_) | | (_| | |  | | | (_| | |_| |                                                         
    |_.__(_)  \__,_|\__,_|\__\__,_|___/\__\___| .__/   \__,_|_|  |_|  \__,_|\__, |                                                         
                                              |_|                           |___/                                                          
    ;                                                                                                                                      
                                                                                                                                           
    Paul Dorfman                                                                                                                           
    sashole@bellsouth.net                                                                                                                  
                                                                                                                                           
    data have ;                                                                                                                            
      input v1-v3 ;                                                                                                                        
      cards ;                                                                                                                              
    11  . 13                                                                                                                               
     . 22  .                                                                                                                               
    31  . 33                                                                                                                               
    .   .  .                                                                                                                               
    51 52  .                                                                                                                               
    61  . 63                                                                                                                               
    ;                                                                                                                                      
                                                                                                                                           
    data _null_ ;                                                                                                                          
      set have (obs=1) nobs = n ;                                                                                                          
      call symputx ("n", n) ;                                                                                                              
    run ;                                                                                                                                  
                                                                                                                                           
    data want ;                                                                                                                            
      set have end = z ;                                                                                                                   
      array x [3, 0:&n] _temporary_ ;                                                                                                      
      array v v: ;                                                                                                                         
      do over v ;                                                                                                                          
        if nmiss (v) then continue ;                                                                                                       
        x[_i_,0] + 1 ;                                                                                                                     
        x[_i_, x[_i_,0]] = v ;                                                                                                             
      end ;                                                                                                                                
      if z then do _n_ = 1 to &n ;                                                                                                         
        do over v ;                                                                                                                        
          v = x[_i_,_n_] ;                                                                                                                 
        end ;                                                                                                                              
        output ;                                                                                                                           
      end ;                                                                                                                                
    run ;                                                                                                                                  
                                                                                                                                           
    ... we get:                                                                                                                            
                                                                                                                                           
    v1 v2 v3                                                                                                                               
    --------                                                                                                                               
    11 22 13                                                                                                                               
    31 52 33                                                                                                                               
    51  . 63                                                                                                                               
    61  .  .                                                                                                                               
    .   .  .                                                                                                                               
    .   .  .                                                                                                                               
                                                                                                                                           
                                                                                                                                           
    Best regards                                                                                                                           
    Paul Dorfman                                                                                                                           
                                                                                                                                           
    *         _               _                                                                                                            
      ___    | |__   __ _ ___| |__                                                                                                         
     / __|   | '_ \ / _` / __| '_ \                                                                                                        
    | (__ _  | | | | (_| \__ \ | | |                                                                                                       
     \___(_) |_| |_|\__,_|___/_| |_|                                                                                                       
                                                                                                                                           
    ;                                                                                                                                      
                                                                                                                                           
    With a tad more mental effort, the code can be made more dynamic                                                                       
    by replacing the hard-coded array with hashes whose size doesn't                                                                       
    have to be guessed or determined beforehand. Basically, the non-missing                                                                
    data are accumulated in 3 separate hashes for V1-V3 apiece and then their                                                              
    contents are merged for the output by scanning a HoH. Quite possibly,                                                                  
    a single hash with V1-V3 can be used,                                                                                                  
    too, at the expense of more vigorous index gymnastics and using REPLACE                                                                
    instead of ADD ... it's just that the HoH approach appeared                                                                            
     more logically straightforward to me from the outset.                                                                                 
                                                                                                                                           
    data have ;                                                                                                                            
      input v1-v3 ;                                                                                                                        
      cards ;                                                                                                                              
    11  . 13                                                                                                                               
     . 22  .                                                                                                                               
    31  . 33                                                                                                                               
    .   .  .                                                                                                                               
    51 52  .                                                                                                                               
    61  . 63                                                                                                                               
    ;                                                                                                                                      
                                                                                                                                           
    data want (keep = v:) ;                                                                                                                
      set have nobs = n end = z ;                                                                                                          
      if _n_ = 1 then do ;                                                                                                                 
        dcl hash hh () ;                                                                                                                   
        hh.definekey ("_i_") ;                                                                                                             
        hh.definedata ("h") ;                                                                                                              
        hh.definedone () ;                                                                                                                 
        array v v: ;                                                                                                                       
        array k k1-k3 ;                                                                                                                    
        do over v ;                                                                                                                        
          dcl hash h (ordered:"a") ;                                                                                                       
          h.definekey  (vname (k)) ;                                                                                                       
          h.definedata (vname (v)) ;                                                                                                       
          h.definedone () ;                                                                                                                
          hh.add() ;                                                                                                                       
        end ;                                                                                                                              
      end ;                                                                                                                                
      do over v ;                                                                                                                          
        if nmiss (v) then continue ;                                                                                                       
        hh.find() ;                                                                                                                        
        k + 1 ;                                                                                                                            
        h.add() ;                                                                                                                          
      end ;                                                                                                                                
      if z then do n = 1 to n ;                                                                                                            
        do over v ;                                                                                                                        
          hh.find() ;                                                                                                                      
          call missing (v) ;                                                                                                               
          _n_ = h.find (key:n) ;                                                                                                           
        end ;                                                                                                                              
        output ;                                                                                                                           
      end ;                                                                                                                                
    run ;                                                                                                                                  
                                                                                                                                           
                                                                                                                                           
