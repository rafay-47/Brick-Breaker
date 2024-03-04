.model small
.stack 100h
.data
	ball_x dw 60h
	ball_y dw 60h
	prev_x dw 0
	prev_y dw 0
	ball_size dw 03h
	time db 0
	move_x dw 0
	move_y dw 0
	ball_speed dw 07h
	screen_width dw 305
	screen_height dw 200
	starting_pos_x dw 60h
	paddle_starting_x dw 099h
	paddle_starting_y dw 0bdh
	starting_pos_y dw 60h
	paddle_x dw 099h
	paddle_y dw 0bdh
	paddle_width dw 8h
	paddle_height dw 03h
	paddle_speed dw 07h
	tile1_row dw 20h
	tile2_row dw 2ch
	tile3_row dw 38h
	tile4_row dw 45h
	tiles_width dw 20h
	tiles_height dw 0Ah
	tile1_col dw 10h
	tile2_col dw 35h
	tile3_col dw 5Ah
	tile4_col dw 7fh
	tile5_col dw 0A4h
	tile6_col dw 0C9h
	tile7_col dw 0EEh
	tile8_col dw 113h
	row1 dw 1
	row2 dw 2
	row3 dw 3
	row4 dw 4
	bool1 dw 0
	bool2 dw 0
	bool3 dw 0
	bool4 dw 0
	bool5 dw 0
	bool6 dw 0
	bool7 dw 0
	bool8 dw 0
	bool9 dw 0
	bool10 dw 0
	bool11 dw 0
	bool12 dw 0
	bool13 dw 0
	bool14 dw 0
	bool15 dw 0
	bool16 dw 0
	bool17 dw 0
	bool18 dw 0
	bool19 dw 0
	bool20 dw 0
	bool21 dw 0
	bool22 dw 0
	bool23 dw 0
	bool24 dw 0
	bool25 dw 0
	bool26 dw 0
	bool27 dw 0
	bool28 dw 0
	bool29 dw 0
	bool30 dw 0
	
	temp_row dw 0
	temp_col dw 0
	temp_bool dw 1
	
	score dw 0
	score_txt db "Score: 000$" 
	lives db 4
	lives_txt db 3,"$"
	name_count db 0
	starting_screen_txt db "WELCOME TO BRICK BREAKER GAME "
				db 0ah,0dh
			    db 0ah,0dh,"    "
				db "PLEASE ENTER YOUR NAME TO CONTINUE"
				 db 0ah,0dh,"                        "
				 db 0ah,0dh,"                   $"
	munu_screen_txt db " ---------MENU---------"
					db 0ah,0dh
					db 0ah,0dh,"                "
					db "NEW GAME "
					db 0ah,0dh
					db 0ah,0dh,"              "
					db "INSTRUCTIONS "
					db 0ah,0dh
					db 0ah,0dh,"               "
					db "EXIT GAME $"
	instructions_txt db "------------INSTRUCTIONS--------------"
					db 0ah,0dh
					db 0ah,0dh,"  "
					db "Use Arrow keys to move right and left"
					db 0ah,0dh
					db 0ah,0dh,"      "
					db "Use escape to pause"
					db 0ah,0dh
					db 0ah,0dh,"  "
					db "Difficulty will increase at each level"
					db 0ah,0dh
					db 0ah,0dh,"  "
					db "Press backspace to go back to menu $"
	display_name db "         $"
	temp db "                        $"
	name_length dw 0
	level dw 1
	tiles_count dw 7
	set_color dw 0
	level2_txt db "------CONGRATS!!!-----"
				db 0ah,0dh
				db 0ah,0dh,"        "
				db "YOU PASSED LEVEL 1"
				db 0ah,0dh
				db 0ah,0dh,"        "
				db "Press ENTER To play level 2$"
	level3_txt db "-----CONGRATS!!!------"
				db 0ah,0dh
				db 0ah,0dh,"        "
				db "YOU PASSED LEVEL 2"
				db 0ah,0dh
				db 0ah,0dh,"        "
				db "Press ENTER To play level 3$"
	died_txt db "-------YOU DIED!!!------"
				db 0ah,0dh
				db 0ah,0dh,"        "
				db "PRESS ENTER TO PLAY AGAIN"
				db 0ah,0dh
				db 0ah,0dh,"        "
				db "Press ESCAPE TO EXIT$"
				
	restart_game db 0
	level_txt db "level  $",0ah,0dh
	pause_txt db  "--------GAME PAUSED!!!--------"
				db 0ah,0dh
				db 0ah,0dh,"         "
				db "PRESS ENTER TO PLAY "
				db 0ah,0dh
				db 0ah,0dh,"         "
				db "Press ESCAPE TO EXIT$"
	win_txt db  "--------CONGRATS!!!--------"
				db 0ah,0dh
				db 0ah,0dh,"              "
				db "YOU WON "
				db 0ah,0dh
				db 0ah,0dh,"         "
				db "PRESS ENTER TO PLAY "
				db 0ah,0dh
				db 0ah,0dh,"         "
				db "Press ESCAPE TO EXIT$"
	file_name db "file",0
	file_address dw ?
	point db 0
	point_txt db "-->$"
	
	
.code
	
	
	mov ax,@data
	mov ds,ax
	mov ax,0
	
	jmp main
	
	
	creating_file macro
	
	mov ah,3ch
	mov dx,offset file_name
	mov cl,1                  
	int 21h
	mov file_address,ax
	
	mov ah,3eh
	mov dx,file_address
	int 21h
	
	endm
	
	writing_file macro

	mov ah,3dh
	mov dx,offset file_name
	mov al,1
	int 21h
	mov file_address,ax
	
	mov ah,42h
	mov bx,file_address
	xor dx,dx
	xor cx,cx
	mov al,2
	int 21h
	
	mov ah,40h
	mov bx,file_address
	mov dx,offset display_name
	mov cx,name_length
	int 21h
	
	mov ah,40h
	mov bx,file_address
	mov dx,offset score_txt
	int 21h
	
	mov ah,40h
	mov bx,file_address
	mov dx,offset level_txt
	int 21h
	
	
	mov ah,3eh
	mov dx,file_address
	int 21h
	
	
	endm
	
	draw_graphics macro
	

	mov cx,0h
	mov dx,11h
	
	.while cx < 280h
		
		inc cx
		MOV AL, 15h 
		MOV AH, 0cH 
		INT 10H
		
	.endw
	
	endm
	
	pause_screen macro
	
	pause1:
		clear_background
		
	    mov ah,02h
		mov bh,00h
		mov dh,08h
		mov dl,06h
		int 10h
		
		mov ah,9
		mov dx,offset pause_txt
		int 21h
	
	
	mov ah,01h
	int 21h
	cmp al,13
	je resume
	cmp al,27
	je exit_game
	
	jmp pause1
	
	resume:
	mov ax,0
	clear_background
	endm
	
	
	
	position_reset macro
	
			mov ax,starting_pos_x
			mov ball_x,ax
	
			mov ax,starting_pos_y
			mov ball_y,ax
	
	endm
	
	paddle_reset macro
	
		mov ax,paddle_starting_x
		mov paddle_x,ax
		
		mov ax,paddle_starting_y
		mov paddle_y,ax
	
	endm
	
	clear_background macro
			mov ah,00h
			mov al,13h
			int 10h
			
	endm
	
	
	starting_screen macro 
	
		clear_background
		
		mov ah,02h
		mov bh,00h
		mov dh,08h
		mov dl,06h
		int 10h
		
		mov ah,9
		mov dx,offset starting_screen_txt
		int 21h
		
		mov dx,offset display_name
		mov ah,3fh
		int 21h
		
		mov name_length,sizeof display_name 
		
	endm
	disp_name macro
	
		mov ah,02h
		mov bh,00h
		mov dh,02h
		mov dl,03fh
		int 10h
		
		mov ah,9
		mov dx,offset display_name
		int 21h
		
	endm
	
	instructions macro
	
	again2:
		clear_background
		
		mov ah,02h
		mov bh,00h
		mov dh,01h
		mov dl,01h
		int 10h
		
		mov ah,9
		mov dx,offset instructions_txt
		int 21h
		
		mov ah,01h
		int 21h
		
		cmp al,08
		je exit6
		jmp again2
		exit6:
		clear_background
	endm
	
	menu macro
		mov point,0ah
		clear_background
		again1:
		disp_name
		
		mov ah,02h
		mov bh,00h
		mov dh,08h
		mov dl,08h
		int 10h
		
		mov ah,9
		mov dx,offset munu_screen_txt
		int 21h
		
		mov ah,02h
		mov bh,00h
		mov dh,point
		mov dl,04h
		int 10h
		
		mov ah,9
		mov dx,offset point_txt
		int 21h
		
		mov ah,1
		int 16h
		jz again1
			
		mov ah,0
		int 16h
			
		.if ah == 48h
			.if point > 0ah
				sub point,2h
				clear_background
			.endif
		.elseif ah == 50h
			.if point < 0eh
				add point,2h
				clear_background
			.endif
		.endif
		
		.if al == 13
			.if point == 0Ah
				je start_game
			.elseif point == 0CH
				je jmp_ins
			.elseif point == 0EH
				je exit_game
			.endif	
		.endif
		jmp again1
		jmp_ins:
		instructions
		jmp again1
		
	endm
	
	display_lives macro
	
	mov ah,02h
	mov bh,00h
	mov dh,01h
	mov dl,49h
	int 10h
	
	mov cx,0
	mov cl,lives
	cmp lives,1
	je end_game
	dec cl
	
	loop1:
	
		mov ah,09h
		mov dx,offset lives_txt
		int 21h
			
	loop loop1
	endm
	
	update_score macro 
	
	mov ax,0
	mov bx,10
	mov dx,0
	mov ax,score 
	div bx
	add dx,30h
	mov [score_txt+9],dl
	mov dx,0
	div bx
	add ax,30h
	add dx,30h
	mov [score_txt+8],dl
	mov [score_txt+7],al
	endm
	
	
	display_score macro
	
	mov ah,02h
	mov bh,00h
	mov dh,01h
	mov dl,0fh
	int 10h
	
	update_score
	
	
	mov ax,0
	mov bx,0
	mov bl,0010b
	mov ah,09h
	mov dx,offset score_txt
	int 21h
	
	
	endm
	

	
	
	drawing proc 
	
	push bp
	mov bp,sp
	
			
		mov cx,[bp+10]
		mov dx,[bp+8]
		Draw3:
		
				mov ah,0ch
				mov al,byte ptr[bp+12]
				mov bh,00h
				int 10h
				inc cx
				mov ax,cx
				sub ax,[bp+10]
				cmp ax,[bp+6]
				
		jng Draw3
		
				mov cx,[bp+10]
				inc dx
				mov ax,dx
				sub ax,[bp+8]
				cmp ax,[bp+4]
				
		jng Draw3
		
		
		mov ax,50h
		add [bp+10],ax
		
	
	pop bp
	ret 10
	drawing endp
	
	moving_ball macro
			
			mov ax,ball_x
			mov prev_x,ax
			
			mov ax,ball_y
			mov prev_y,ax
			
			mov ax,move_x
			add ball_x,ax
			
			cmp ball_x,5h
			jl invert_x
			
			mov bx,screen_width
			cmp ball_x,bx
			jg invert_x
			
			mov ax,move_y
			add ball_y,ax
			
			cmp ball_y,12h
			jl invert_y
			
			mov bx,screen_height
			cmp ball_y,bx
			jg reset
			
			
			mov bx,ball_x
			add bx,ball_size
			cmp bx,paddle_x
			jng exit1
			
			mov bx,paddle_x
			add bx,paddle_width
			cmp ball_x,bx
			jnl exit1
			
			mov bx,ball_y
			add bx,ball_size
			cmp bx,paddle_y
			jng exit1
			
			mov bx,paddle_y
			add bx,paddle_height
			cmp ball_y,bx
			jnl exit1
			
			
			invert_y:
					neg move_y
					jmp exit1
			
			invert_x:
					neg move_x
					jmp exit1
					
			reset:
					position_reset
					paddle_reset
					clear_background
					dec lives
					cmp move_x,0
					jl invert_x2
					jmp exit1
					
			invert_x2:
					neg move_x
					
	exit1:			
	endm
	
	
	check_collision proc

			pop bp
			
			pop temp_row
	        pop temp_col
			
			
			mov bx,ball_x
			add bx,ball_size
			add bx,5
			cmp bx,temp_col
			jng exi1
			
			mov bx,temp_col
			add bx,tiles_width 
			cmp ball_x,bx
			jnl exi1
			
			
			mov bx,ball_y
			add bx,ball_size
			cmp bx,temp_row
			jng exi1
			
			mov bx,temp_row
			add bx,tiles_height
			cmp ball_y,bx
			jnl exi1
	
		invert_y1:
					clear_background
					mov ax,level
					add score,ax
					mov temp_bool,1
					neg move_y
					;neg move_x
					dec tiles_count
					jmp exi
	exi1:		
	mov temp_bool,0		
	exi:
	push bp
	ret 
	check_collision endp
	
	collision2 macro bool,row,col,row_no1
	
	mov ax,level
	.if bool != ax
		.if row_no1 == 2 || row_no1 == 4
		add col,12h
		.endif
			push col
			push row
			mov temp_bool,0
			call check_collision
			mov ax,temp_bool
			add bool,ax
		.if row_no1 == 2 || row_no1 == 4
		sub col,12h
		.endif
	.endif
	endm

	collision macro
	
	collision2 bool1,tile1_row,tile1_col,row1
	collision2 bool2,tile1_row,tile2_col,row1
	collision2 bool3,tile1_row,tile3_col,row1
	collision2 bool4,tile1_row,tile4_col,row1
	collision2 bool5,tile1_row,tile5_col,row1
	collision2 bool6,tile1_row,tile6_col,row1
	collision2 bool7,tile1_row,tile7_col,row1
	collision2 bool22,tile1_row,tile8_col,row1
	collision2 bool8,tile2_row,tile1_col,row2
	collision2 bool9,tile2_row,tile2_col,row2
	collision2 bool10,tile2_row,tile3_col,row2
	collision2 bool11,tile2_row,tile4_col,row2
	collision2 bool12,tile2_row,tile5_col,row2
	collision2 bool13,tile2_row,tile6_col,row2
	collision2 bool14,tile2_row,tile7_col,row2
	collision2 bool15,tile3_row,tile1_col,row3
	collision2 bool16,tile3_row,tile2_col,row3
	collision2 bool17,tile3_row,tile3_col,row3
	collision2 bool18,tile3_row,tile4_col,row3
	collision2 bool19,tile3_row,tile5_col,row3
	collision2 bool20,tile3_row,tile6_col,row3
	collision2 bool21,tile3_row,tile7_col,row3
	collision2 bool24,tile3_row,tile8_col,row3
	.if level != 1
	collision2 bool23,tile4_row,tile1_col,row4
	collision2 bool25,tile4_row,tile2_col,row4
	collision2 bool26,tile4_row,tile3_col,row4
	collision2 bool27,tile4_row,tile4_col,row4
	collision2 bool28,tile4_row,tile5_col,row4
	collision2 bool29,tile4_row,tile6_col,row4
	collision2 bool30,tile4_row,tile7_col,row4
	.endif
	endm
	
	removing_paddle macro 
	
			mov ax,00h
			push ax
			push paddle_x
			push paddle_y
			push paddle_width
			push paddle_height
			
			call drawing
	 endm
	
	
	
	moving_paddle macro
	
			mov ah,1
			int 16h
			jz exit3
			
			mov ah,0
			int 16h
			
			cmp ah,4dh
			je move_right
			cmp ah,4bh
			je move_left
			cmp al,27
			je pause2
			jmp exit3
	
	move_right:
			removing_paddle 
			mov bx,screen_width
			sub bx,paddle_width
			cmp paddle_x,bx
			jg exit3
			mov ax,paddle_speed
			add paddle_x,ax
			
		jmp exit3
		
	move_left:
			removing_paddle 
			cmp paddle_x,07h
			jl exit3
			mov ax,paddle_speed
			sub paddle_x,ax
			jmp exit3
	
	pause2:
	pause_screen
	exit3:
	endm
	
	
	
	drawing_paddle macro x1,y1,size2,size3
		mov ax,06h
		push ax
		push x1
		push y1
		push size2
		push size3
		
		call drawing
	endm
	
	
	
	
	drawing_ball macro x,y,size1
			mov ax,27h
			push ax
			push x
			push y
			push size1
			push size1
			call drawing
	
	endm
	
	removing_ball macro x3,y3,size4
		mov ax,00h
		push ax
		push x3
		push y3
		push size4
		push size4
		call drawing
	endm
	
	
	
	color macro temp_bool2,row_no2
	
	mov ax,temp_bool2
	
	.if  row_no2 == 1 || row_no2 == 3
		.if ax == 0
			mov set_color,70h
		.endif
		
		.if ax == 1
			mov set_color,0ch
		.endif                           ;70,0c,87
		
		.if ax == 2
			mov set_color,87h
		.endif
	.endif
	
	.if  row_no2 == 2 || row_no2 == 4
		.if ax == 0
			mov set_color,7fh
		.endif
		
		.if ax == 1
			mov set_color,36h
		.endif
		
		.if ax == 2
			mov set_color,35h
		.endif
	.endif
	
	endm
	
	
	
	drawing_tile2 macro temp_bool1,col,row,row_no
	
	mov ax,level
	.if temp_bool1 != ax
		.if row_no == 2 || row_no == 4
		add col,12h
		.endif
			
			color temp_bool1,row_no
			push set_color
			push col
			push row
			push tiles_width 
			push tiles_height 
			call drawing
		.if row_no == 2 || row_no == 4
		sub col,12h
		.endif
	.endif
	
	endm
	draw_tile macro
	
	 
	drawing_tile2 bool1,tile1_col,tile1_row,row1
	drawing_tile2 bool2,tile2_col,tile1_row,row1
	drawing_tile2 bool3,tile3_col,tile1_row,row1
	drawing_tile2 bool4,tile4_col,tile1_row,row1
	drawing_tile2 bool5,tile5_col,tile1_row,row1
	drawing_tile2 bool6,tile6_col,tile1_row,row1
	drawing_tile2 bool7,tile7_col,tile1_row,row1
	drawing_tile2 bool22,tile8_col,tile1_row,row1
	drawing_tile2 bool8,tile1_col,tile2_row,row2
	drawing_tile2 bool9,tile2_col,tile2_row,row2
	drawing_tile2 bool10,tile3_col,tile2_row,row2
	drawing_tile2 bool11,tile4_col,tile2_row,row2
	drawing_tile2 bool12,tile5_col,tile2_row,row2
	drawing_tile2 bool13,tile6_col,tile2_row,row2
	drawing_tile2 bool14,tile7_col,tile2_row,row2
	;drawing_tile2 bool23,tile8_col,tile2_row
	drawing_tile2 bool15,tile1_col,tile3_row,row3
	drawing_tile2 bool16,tile2_col,tile3_row,row3
	drawing_tile2 bool17,tile3_col,tile3_row,row3
	drawing_tile2 bool18,tile4_col,tile3_row,row3
	drawing_tile2 bool19,tile5_col,tile3_row,row3
	drawing_tile2 bool20,tile6_col,tile3_row,row3
	drawing_tile2 bool21,tile7_col,tile3_row,row3
	drawing_tile2 bool24,tile8_col,tile3_row,row3
	.if level != 1
	drawing_tile2 bool23,tile1_col,tile4_row,row4
	drawing_tile2 bool25,tile2_col,tile4_row,row4
	drawing_tile2 bool26,tile3_col,tile4_row,row4
	drawing_tile2 bool27,tile4_col,tile4_row,row4
	drawing_tile2 bool28,tile5_col,tile4_row,row4
	drawing_tile2 bool29,tile6_col,tile4_row,row4
	drawing_tile2 bool30,tile7_col,tile4_row,row4
	.endif
    endm
	
	

	reset_tiles macro
	
	    mov bool1,0h
		mov bool2,0h
		mov bool3,0h
		mov bool4,0h
		mov bool5,0h
		mov bool6,0h
		mov bool7,0h
		mov bool8,0h
		mov bool9,0h
		mov bool10,0h
		mov bool11,0h
		mov bool12,0h
		mov bool13,0h
		mov bool14,0h
		mov bool15,0h
		mov bool16,0h
		mov bool17,0h
		mov bool18,0h
		mov bool19,0h
		mov bool20,0h
		mov bool21,0h
		mov bool22,0h
		mov bool23,0h
		mov bool24,0h
		mov bool25,0h
		mov bool26,0h
		mov bool27,0h
		mov bool28,0h
		mov bool29,0h
		mov bool30,0h
	
	endm
	
	
	
	level_change proc 
	push bp
	mov bp,sp
	
	mov ax,[bp+8]
	mov move_y,ax
	sub ax,1
	mov move_x,ax
	
	
		again4:
		mov ax,[bp+6]
		mov paddle_width,ax
		
		reset_tiles
		
	.if level != 1
		
		clear_background
		paddle_reset
		
		mov ah,02h
		mov bh,00h
		mov dh,08h
		mov dl,08h
		int 10h
		
		mov ah,9
		mov dx,[bp+4]
		int 21h
		
		mov ah,01
		int 21h
		cmp al,13
		je exit5
		jmp again4
		
	.endif
	
	exit5:
	clear_background
	position_reset
	pop bp
	ret 6
	level_change endp
	
	check_level macro
	
	again3:
	
		cmp tiles_count,0
		je l1
		jmp exit2
		
	l1:
		clear_background
		inc level
		mov bx,30
		mov ax,level
		mul bx
		mov tiles_count,ax
		cmp level,2
		je l2
		cmp level,3
		je l3
		cmp level,4
		;je l4
		jmp exit2
	l2:
		mov ax,04h
		push ax
		mov ax,025h
		push ax
		mov dx,offset level2_txt
		push dx
		call level_change
		
	jmp exit2
	
	l3:
		mov ax,05h
		push ax
		mov ax,022h
		push ax
		mov dx,offset level3_txt
		push dx
		call level_change
		
	jmp exit2
	l4:
		
		mov tiles_count,0
		jmp end_game
		
	exit2:
	    mov ah,02h
		mov bh,00h
		mov dh,01h
		mov dl,01h
		int 10h
		
		mov ax,level
		add ax,30h
		mov [level_txt+6],al
		
		mov ah,9
		mov dx,offset level_txt
		int 21h
	
	endm
	
	
	level_1 macro
		mov score,0
		mov level,1
		mov lives,4
		mov tiles_count,23
		mov ax,03h
		push ax
		mov ax,028h
		push ax
		mov dx,offset munu_screen_txt
		push dx
		call level_change
	
	endm
	
	died macro
	
	clear_background
	writing_file
		again5:
		
		mov ah,02h
		mov bh,00h
		mov dh,08h
		mov dl,08h
		int 10h
		
		mov ah,9
		.if tiles_count == 0
			mov dx,offset win_txt
		.elseif tiles_count != 0
			mov dx,offset died_txt
		.endif
		int 21h
		
		mov ah,01h
		int 21h
		
		cmp al,13
		je start_again
		cmp al,27
		je exit_game
		
		jmp again5
	endm
	
	
	main proc
	
	;creating_file
	starting_screen 
	start_again:
	level_1
	menu
	start_game:
	
			clear_background
	
	calling_time_interupts:
	
			mov ah,2ch
			int 21h
			cmp dl,time
			
	je calling_time_interupts
	mov time,dl
	;clear_background
	draw_graphics
	moving_ball
	drawing_ball ball_x,ball_y,ball_size
	check_level
	draw_tile
	collision
	drawing_paddle paddle_x,paddle_y,paddle_width,paddle_height
	moving_paddle
	drawing_paddle paddle_x,paddle_y,paddle_width,paddle_height
	display_score
	display_lives
	removing_ball prev_x,prev_y,ball_size
	
	
	jmp calling_time_interupts
	
	
	end_game:
	clear_background
	died
	
	main endp
	exit_game:
	mov ah,4ch
	int 21h
	end