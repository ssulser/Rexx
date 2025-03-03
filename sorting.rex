/**********************************************************/ 
/* REXX Comb Sort                                         */ 
/*                                                        */ 
/* written by S. Sulser                                   */ 
/* v 0.1 - basic implementation                           */ 
/* v 0.2 - show_array_small prints only first 20 and last */ 
/*         20 numbers of array                            */ 
/**********************************************************/ 
                                                             
/* definition of GLOBALS */                                  
max = 5000                                                   
                                                             
/* MAIN - start of program */                                
main:                                                        
--parse arg max           /* field size to sort 1 - max */   
--if max < 10                                                
--  then max = 10                                            
--  else if max > 9999 then max = 9999                       
  'CLS'                                                      
                                                             
  array.0 = max                                              
                                                             
  say "Filling array with randoms..."                        
  call fill_array                                            
  call show_array_small                                      
  say ; say "Start sorting..."                               
  t = time('R')                                              
  call comb_sort                                             
  t = time('E')                                              
  say "...finished! Sorting took" t "seconds."                          
  call show_array_small                                                 
                                                                        
  say "Filling array with randoms..."                                   
  call fill_array                                                       
  call show_array_small                                                 
  say ; say "Start sorting..."                                          
  t = time('R')                                                         
  call quick_sort 1,max                                                 
  t = time('E')                                                         
  say "...finished! Sorting took" t "seconds."                          
  call show_array_small                                                 
end_of_main:                                                            
  exit 0                                                                
                                                                        
/* subroutines / procedures */                                          
fill_array: procedure expose array. max                                 
  array.1 = random(1,max,time('M'))    /* seed */                       
  do i = 2 to max                      /* start from 2, 1 already set */
    array.i = random(1,max)                                             
  end                                                                   
  return                                                                
                                                                        
show_array: procedure expose array. max                                 
  do i = 1 to max                                                       
    call charout ,right(array.i,4,'0') || ' '                           
    if i // 15 = 0 then say                                             
  end                                                                   
  return
show_array_small: procedure expose array. max   
  do i = 1 to 20                                
    call charout ,right(array.i,4,'0') || ' '   
    if i // 15 = 0 then say                     
  end                                           
  say "..."                                     
  counter = 1                                   
  do i = max-20 to max                          
    call charout ,right(array.i,4,'0') || ' '   
    counter = counter + 1                       
    if counter // 15 = 0 then say               
  end                                           
  say                                           
  return                                        
                                                
comb_sort: procedure expose array. max          
  gap = max                                     
  switched = 1                                  
                                                
  do until (switched = 0) & (gap = 1)           
    switched = 0                                
    gap = trunc(gap / 13 * 10)                  
    if gap < 1 then gap = 1                     
    do i=1 to max - gap                         
      delta = i + gap                           
      if array.i > array.delta then do          
        temp = array.i                          
        array.i = array.delta                   
        array.delta = temp                      
        switched = 1
      end                                        
    end                                          
  end                                            
  return                                         
                                                 
                                                 
quick_sort: procedure expose array.              
  arg low,high                                   
  von = low; bis = high                          
  pivot = array.von                              
  do until (von > bis)                           
    do while (array.von < pivot); von=von+1; end 
    do while (array.bis > pivot); bis=bis-1; end 
    if von <= bis then do                        
      temp = array.von                           
      array.von = array.bis                      
      array.bis = temp                           
      von=von+1; bis=bis-1                       
    end                                          
  end                                            
  if low < bis then call quick_sort low,bis      
  if high > von then call quick_sort von,high    
return
