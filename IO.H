;  header file for alp
.xlist   ; turn of listing
         extrn  itoa_proc:far, atoi_proc:far, out_proc:far
         extrn  ins_proc:far, inc_proc:far
m_error  macro  msg
         if2
	 %out msg
	 .lall
comment *
        msg
* end comment
         .err
	 ;.sall
	 endif
	 endm
itoa     macro  dest,source,xtra
         ifb   <source>
	 m_error <missing operand(s) in itoa>
	 exitm
	 endif
	 
	 ifnb  <xtra>
	 m_error <extra operand(s) in itoa>
	 exitm
	 endif
	 push ax
	 push di
	 mov ax,source
	 lea di,dest
	 call itoa_proc
	 pop di
	 pop ax
	 endm
atoi     macro   source,xtra
         ifb    <source>
	 m_error <missing operand in atoi>
	 exitm
	 endif
	 
	 
	 ifnb  <xtra>
	 m_error <extra operand(s) in atoi>
	 exitm
	 endif
	
	 
	 push si
	 lea si,source
	 call atoi_proc
	 pop si
	 endm
	
	 
output   macro  string,length,xtra

         ifb     <string>
	 m_error <missing operand(s) in output>
	 exitm
	 endif
	 
	 
	 ifnb    <xtra>
	 m_error <extra operand(s) in output>
	 exitm
	 endif
	 
	 
	 
	 
	 push  ax
	 push  si
	 lea   si,string
	 
	 	 
	 ifb  <length>
	 mov  ax,0
	 else
	 mov  ax,length
	 endif
	 
	 
	 call  out_proc
	 pop   si
	 pop   ax
	 endm 
	 
inputs   macro  dest,length,xtra

         ifb    <length>
	 m_error <missing operand(s) in inputs>
	 exitm
	 endif
	 
	 ifnb   <xtra>
	 m_error <extra operand(s) in inputs>
	 exitm
	 endif
	 
	 
	 push  di
	 lea   di,dest
	 mov   cx,length
	 call  ins_proc
	 pop   di
	 endm
	 

inputc   macro  xtra
         ifnb   <xtra>
	 m_error <extra operand(s) in inputc>
	 exitm
	 endif
	 call   inc_proc
	 endm

.sall
.LIST


	 	 