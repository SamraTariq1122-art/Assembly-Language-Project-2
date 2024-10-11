include 'emu8086.inc'
 .stack 100h
 .model small
 .data 
  password db "1234" 
  arr DB ? 
  key db 3 
 .code       
        
        
main PROC 
    
  mov ax,@data 
  mov ds,ax 
  mov si , offset password
    
  back: 
    
  mov cx,4
    print 'Enter your password : '
   
    passcheck:
    mov ah,01
    int 21h
    
    cmp al,[si]
    jne incorect
    inc si
   
    loop passcheck 
    
    print ' Signing in '
    call newline 
    print 'Please select any option from any of above  ' 
    call newline
    print '1)  Open Calculator '
    call newline
    print '2)  multiplication with shift command '
    call newline
    print '3)  Division by shift command '
    call newline
    print '4)  Sort data in Array '         
    call newline
    print '5)  Search data in an Array ' 
    call newline
    print '6) Logical instructions ALL Three Execution'  
    call newline
    print '7)  Operations on stack ' 
    call newline
  
    
    
    ; THIS IS MENU OPTIONS
    
    call newline
    print 'Enter your choice : '
    mov ah,01
    int 21h
      
    cmp al , '1'
    je one
    jne notone
    
    one:    

    call calculate
    jmp outside
    notone:
    
    cmp al,'2'
    je two
    jne nottwo
    two:
    call shiftmultiply 
    
    
    jmp outside
    nottwo: 
    
    cmp al,'3'
    je three
    jne notthree
    three:
    call shiftdivide
    
    jmp outside
    notthree: 
    
    cmp al,'4'
    je four
    jne notfour
    four:       
    call sort
    jmp outside
    notfour:
    
    cmp al,'5'
    je five
    jne notfive
    five:
    call search
    jmp outside
    notfive:
    
    cmp al,'6'
    je six
    jne notsix
    six: 
    call logicalinstruction
    ;     CODE HERE FOR IF
    jmp outside
    notsix: 
    
    cmp al,'7'
    je seven
    jne notseven
    seven:
    ;    CODE HERE FOR IF
    jmp outside
    notseven:
  
   
     
    
   outside:
   
   incorect: 
   call newline
   print 'please enter password again '
   call newline
   jmp back 
     
main endp

sort proc
     
print 'Enter Any Array Number = ' 
        mov cx,5
        mov bx,offset arr
        
inputs: 
        mov ah,1
        int 21h
        mov [bx],al
        inc bx
        loop inputs
 
       mov cx,5
       dec cx
OuterLoop:
       mov bx,cx
       mov si,0
 
Comploop:
      mov al,arr[si]
     mov dl,arr[si+1]
     cmp al,dl
 
     jc noSwap
 
    mov arr[si],dl
    mov arr[si+1],al
noSwap:
     inc si
     dec bx
     jnz comploop
 
    loop OuterLoop
    mov ah,2
    call newline
 print 'Ascending Sorted Array = '
    mov cx,5
    mov bx,offset arr
Outputs: 
    mov dl,[bx]
    mov ah,2
    int 21h
 
    inc bx
 loop Outputs
    jmp outside
  
     
     
sort endp

 



shiftmultiply proc
             
    call newline
print 'the number is:'

mov ax,2 
mov bx,ax
mov dx,bx
add dx,48
mov ah,02
int 21h
call newline
print 'its square by SHL is:'
mov ax,2
shl ax,1 
mov dl,al 
add dl,48
mov ah,02
int 21h
ret 
    
shiftmultiply endp  


shiftdivide proc
             
    call newline
call newline
print 'the number is:'
  
mov ax,6
mov bx,ax
mov dx,bx
add dx,48 
mov ah,02 
int 21h
call newline
print 'its half by division SHR is:'
mov ax,6
shr ax,1 
mov dl,al 
add dl,48
mov ah,02
int 21h

ret 
    
shiftdivide endp

    
search proc
    
    MOV AX, @DATA
    MOV DS, AX 
    call newline
      print 'Enter Any Array elements 5 min = ' 
        mov cx,5
        mov bx,offset arr
        
inputs1: 
        mov ah,1
        int 21h
        mov [bx],al
        inc bx
        loop inputs1
    
    
    lea si,arr
    mov cx,5
     
  mov al,key
    l1:
    
    mov bl,[si] 
    cmp al,bl
    jz found 
     inc si
    loop l1
     print 'number 3 not found'
      jmp out
    found:
    print 'number 3 found'
    out:  
    
    ret
    
    
search endp

     

newline proc
             
 mov dl,10 
 mov ah,02h
 int 21h
 mov dl,13
 mov ah,02h
 int 21h 
ret 
    
newline endp

 
 
logicalinstruction proc
   call newline 
    print 'LOGICAL INSTRUCTIONS CODE'

 call newline
print 'Value To Operate On : 10001010b '
   call newline
mov ax,10001010b
print 'Mask Value : 10000111b '

mov bx,10000111b ;mask

mov dx,ax  ;copy of ax
mov cx,dx  ;copy of ax
  call newline
 
and ax,bx
print 'Result of AND Operation : 10000010b  '  
call newline
or  dx,bx
print 'Result of OR Operation : 10001111b '

mov dl,13
  call newline

print 'LOGICAL OPERATIONS EXECUTED'
mov dl,13
    
    logicalinstruction endp 



calculate proc
       
 
 print 'Enter fIRST Number ' 
 
 mov ah,01h ;input 1 input from character
 Int 21h 
 mov bl,al 
 mov cl,al
 call newline
 
 print ' Enter second Number '
 mov ah,01h ;input 2 input from character
 Int 21h 
 add bl,al
 sub bl,48
 
 call newline
 
 print 'Addition Result is ' 
 mov dl,bl ;ah register input le ke opposite main store karay ga 
 mov ah,02h ;output display
 Int 21h 
 call newline
 
 
 print 'Subtraction Result is '
 sub bl,cl
 add bl,48 
 mov al,cl
 sub al,bl
 add al,48 
 mov dl,al ;ah register input le ke opposite main store karay ga 
 mov ah,02h ;output display
 Int 21h 
 call newline
 
 print 'multiplication Result is '
 mov al,cl
 sub al,48
 sub bl,48 
 mul bl 
 add al,48
 mov dl,al ;ah register input le ke opposite main store karay ga 
 mov ah,02h ;output display
 Int 21h 
call newline 
 
 
 print 'division Result is '
 mov al,cl
 sub al,48
 sub bl,48
 div bl 
 add al,48
 mov dl,al ;ah register input le ke opposite main store karay ga 
 mov ah,02h ;output display
 Int 21h   
         
calculate endp
