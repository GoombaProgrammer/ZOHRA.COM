; This is my first disassembly ever - GoombaProgrammer

org 100h

entry:
  push cs
  pop ds
  mov ax,word 0xb800
  mov ds,ax
  mov bx,word 0x0800

start:
  mov cx,word 0x0fa0								; I have no idea what this is for, if you know, tell me please.

actualstart:
  dec cx
  mov si,cx
  add word [si-0x01],0x04
  loop actualstart
  dec bx
  jne start
  mov bx,word 0x0fa0								; Again, I don't know.
  xor si,si

setup:
  mov word [bx],word 0x0000
  mov word [bx-0x02],word 0x0000
  mov word [si],word 0x0000
  mov word [si+0x02],word 0x0000
  push ax
  push dx
  mov dx,word 0x03da

check:
  in al,dx
  test al,0x08
  jne check

payldr:
  in al,dx
  test al,0x08
  je payldr
  pop dx
  pop ax
  sub bx,0x04
  add si,0x04
  cmp bx,word 0x07d0
  jnb setup
  xor bx,bx
  xor di,di
  push cs
  pop ds
  mov si,message										; Show message.
  mov cx,word 0x0001

payldr2:
  mov ah,0x02
  mov dx,word 0x0c0e
  add dx,di
  int 0x10
  mov bl,0x02
  lodsb 
  cmp al,0x00
  je quit
  mov ah,0x09
  int 0x10
  inc di
  jmp short payldr2										; Loop.

quit:
  mov ah,0x00
  int 0x16
  cmp al,0x1b											; AL = 1B?
  jne entry												; No? restart.
  mov ah,0x4c											; Yes? Exit to DOS
  int 0x21												; Run the line above

message db "Zohra will live forever ! Necromancy with her..." ; Message
db 0x00													; Null
