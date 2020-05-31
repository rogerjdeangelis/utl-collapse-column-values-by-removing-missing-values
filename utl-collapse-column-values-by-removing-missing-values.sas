Collapse column values by removing missing values                                                                                 
                                                                                                                                  
Self update method does not work for this table                                                                                   
                                                                                                                                  
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
;                                                                                                                                 
                                                                                                                                  
%array(vars,values=%utl_varlist(data=sd1.have));                                                                                  
                                                                                                                                  
data want;                                                                                                                        
  merge %do_over(vars,phrase=%str(sd1.have(keep=? where=(? ne .)) ) ) ;                                                           
run;quit;                                                                                                                         
                                                                                                                                  
