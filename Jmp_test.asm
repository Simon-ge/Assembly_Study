;若要使程序中的jmp指令执行后，CS:IP指向程序中的第一条指令
;在data段中应该定义哪些数据？

assume cs:code
data segment
    dd 12345678h
data ends

code segment

start:
    mov ax,data 
    mov ds,ax
    mov bx,0
    mov [bx],bx       ;将bx寄存器中的值放入到内存中          
    mov [bx+2],cs     ;将cs代码段的段地址放入到内存中     
    jmp dword ptr ds:[0]
    
code ends
end start 

;分析
;1) jmp 指令为无条件转移指令
;2) jmp dword 内存单元地址(段间转移) 
;功能从内存单元地址处开始存放两个字
;高地址处的字是转移的目的段地址，低地址处是转移的目的偏移地址
;(cs) = (内存单元地址+2)
;(ip) = (内存单元地址)

;根据指令的含义，再结合程序可以看出jmp指令需要取 ds:[0]~ds[3]内存地址之间的数据
; ds:[0] ~ ds:[3]的数据组成形式为：00 00 00 00
;则[0]需要存放转移的目的偏移地址
;[2]需要存放转移的目的段地址
;OK 我们需要解决问题的思路清晰了

;如题：jmp执行后，CS:IP指向第一条指令
;则
;偏移地址=0
;段地址  =(CS)
;因此 mov [bx],bx即可
;mov [bx+2],cs 将cs的段地址放入到内存中

;经Win-Masm v2.2程序检测通过，正确

















































