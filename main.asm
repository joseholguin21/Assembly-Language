INCLUDE Irvine32.inc
INCLUDE Macros.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

.data
.code

main PROC
.data
gamemenu	BYTE "Typing Game", 0dh, 0ah,
			 "1. Practice a letter.", 0dh, 0ah,
			 "2. Train skills", 0dh, 0ah,
			 "3. Do a timed test", 0dh, 0ah,
			 "4. Falling Game", 0dh, 0ah,
			 "5. Exit program", 0dh, 0ah,
			 "Choice (1~5): ", 0

TimePrompt	BYTE "Select a number 1~3 for time", 0dh, 0ah,
			 "1. 60 Seconds", 0dh, 0ah,
			 "2. 120 Seconds", 0dh, 0ah,
			 "3. 180 Seconds", 0dh, 0ah,
			 "Choice (1~3): ", 0

diffsentence  BYTE "bsckwlackcwdco ciccow dcifiru qpdlvir cowc qpcffhjdhfdk qamiwe poeellk vxnb torodtasx qazx pomaaeddrfrv", 0
challsentence BYTE "Cryptocurrencies, characterized by their decentralized nature and cryptographic underpinnings, ",
				   "have revolutionized traditional financial systems, fostering an intricate ecosystem where blockchain technology intertwines ",
				   "with intricate algorithms, thus reshaping notions of value, trust, and economic paradigms on a global scale.", 0

optionlet   BYTE "Enter letter to practice A~Z: ", 0

messageprompt BYTE "...1...2...3", 0
space		  BYTE "    ",0

scoreprompt1 BYTE "Score: ", 0
scoreprompt2 BYTE " of sentence completed!", 0

counter		DWORD 0				;used to keep track of position
strsize		DWORD 0				;holds length of sentence
char		BYTE ?				;for user input
xp			BYTE 0
yp			BYTE 1
maintimer	DWORD ? 		;used for getting timer
timer		DWORD ?   	    ;used for ouput of timer
count		DWORD ?			;used for keeping track of the timer
second		DWORD 1000
starttime	DWORD ?				;get initial time
mistakecounter DWORD ?			;counts mistakes
	
;filenames
filehandle	DWORD ?
BUFFSIZE = 500
buffer		BYTE BUFFSIZE DUP (?)
bytesRead	DWORD ?
filenameA	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\A.txt", 0
filenameB	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\B.txt", 0
filenameC	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\C.txt", 0
filenameD	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\D.txt", 0
filenameE	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\E.txt", 0
filenameF	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\F.txt", 0
filenameG	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\G.txt", 0
filenameH	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\H.txt", 0
filenameI	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\I.txt", 0
filenameJ	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\J.txt", 0
filenameK	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\K.txt", 0
filenameL	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\L.txt", 0
filenameM	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\M.txt", 0
filenameN	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\N.txt", 0
filenameO	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\O.txt", 0
filenameP	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\P.txt", 0
filenameQ	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\Q.txt", 0
filenameR	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\R.txt", 0
filenameS	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\S.txt", 0
filenameT	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\T.txt", 0
filenameU	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\U.txt", 0
filenameV	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\V.txt", 0
filenameW	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\W.txt", 0
filenameX	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\X.txt", 0
filenameY	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\Y.txt", 0
filenameZ	BYTE "C:\Users\jholguin16\source\repos\C++\Final Project\Z.txt", 0


CaseTable	BYTE 'A' ;lookup value
			DWORD Atext
EntrySize = ($ - CaseTable)
			BYTE 'B' 
			DWORD Btext
			BYTE 'C'
			DWORD Ctext
			BYTE 'D'
			DWORD Dtext
			BYTE 'E'
			DWORD Etext
			BYTE 'F'
			DWORD Ftext
			BYTE 'G'
			DWORD Gtext
			BYTE 'H'
			DWORD Htext
			BYTE 'I'
			DWORD Itext
			BYTE 'J'
			DWORD Jtext
			BYTE 'K'
			DWORD Ktext
			BYTE 'L'
			DWORD Ltext
			BYTE 'M'
			DWORD Mtext
			BYTE 'N'
			DWORD Ntext
			BYTE 'O'
			DWORD Otext
			BYTE 'P'
			DWORD Ptext
			BYTE 'Q'
			DWORD Qtext
			BYTE 'R'
			DWORD Rtext
			BYTE 'S'
			DWORD Stext
			BYTE 'T'
			DWORD Ttext
			BYTE 'U'
			DWORD Utext
			BYTE 'V'
			DWORD Vtext
			BYTE 'W'
			DWORD Wtext
			BYTE 'X'
			DWORD Xtext
			BYTE 'Y'
			DWORD Ytext
			BYTE 'Z'
			DWORD Ztext

NumberOfEntries = ($ - CaseTable) / EntrySize

;variables for falling game 
fallmenu  BYTE "Falling Speed Difficulty", 0Dh, 0Ah,
		       "1. Level 1", 0Dh, 0Ah,
			   "2. Level 2", 0Dh, 0Ah,
			   "3. Level 3", 0Dh, 0Ah,
			   "Choice (1~3): ", 0
stats BYTE "====< STATS >====", 0
fscoreprompt BYTE " words completed!", 0
variable1 BYTE "wdoweorha ", 0
variable2 BYTE "lqmzncieod ", 0
variable3 BYTE "rthnvba ", 0
variable4 BYTE "lllesfgh ", 0
variable5 BYTE "plqamziw ", 0
variable6 BYTE "nvbcnsjdve ", 0
variable7 BYTE "ymxxzswe ", 0
floor BYTE "========================================================================================================================", 0

yp1 BYTE 0
xp1 BYTE 10
yp2 BYTE 0
xp2 BYTE 90
yp3 BYTE 0
xp3 BYTE 40
yp4 BYTE 0
xp4 BYTE 30
yp5 BYTE 0
xp5 BYTE 60
yp6 BYTE 0
xp6 BYTE 80
yp7 BYTE 0
xp7 BYTE 25

tempyp1 BYTE 0
tempyp2 BYTE 0
tempyp3 BYTE 0
tempyp4 BYTE 0
tempyp5 BYTE 0
tempyp6 BYTE 0
tempyp7 BYTE 0

wordmark1 DWORD 0
wordmark2 DWORD 0
wordmark3 DWORD 0
wordmark4 DWORD 0
wordmark5 DWORD 0
wordmark6 DWORD 0
wordmark7 DWORD 0


;starttime DWORD ?
divisor DWORD 1000
timerIterator DWORD 1
counterf DWORD 1
;char BYTE ?
ExitCondition BYTE 0
scoretracker DWORD 0
accuracytracker DWORD 0
numberOfKeys DWORD 60
percent DWORD 100
difficultylevel DWORD 0
levelchoice BYTE 0



.code

redo:
;display menu
mov edx, OFFSET gamemenu
call	WriteString
call	ReadInt

;ask user for time
call Crlf

;check the choice input
cmp		al, 1		;check for menu input 1
je		Option1
cmp		al, 2		;check for menu input 2
je		Option2
cmp		al, 3		;check for menu input 3
je		Option3 
cmp		al, 4		;check for menu input 4
je      Option4
cmp		al, 5		;check for end program
je		Option5

Option1:
call SetTime
mov	 edx, OFFSET optionlet
call WriteString
call ReadChar

call	Clrscr
call DelayMessage
mov		dh, yp
mov		dl, xp
call    Gotoxy

;procedure table that finds the specific sentence to ouput based off user input
mov		ebx, OFFSET CaseTable
mov		ecx, NumberOfEntries
FindChoice: cmp al, [ebx]
			jne NextChoice
			call NEAR PTR [ebx + 1]
			jmp ExitChoice
NextChoice: add ebx, EntrySize
			loop FindChoice;
ExitChoice:
jmp startgame

Option2:
call SetTime
call Clrscr
call DelayMessage
mov		dh, yp
mov		dl, xp
call    Gotoxy
call OptionTwo
jmp startgame

Option3: 
call Clrscr
call DelayMessage
mov dh, yp
mov dl, xp
call Gotoxy
call OptionThree
jmp startgame

;where the start of the game is for options 1 to 3
startgame:
call    setTextColorWhite
call	WriteString
mov dh, yp
mov dl, xp
call Gotoxy

call GetMSeconds
mov starttime, eax

;calling the the typing game loop
call InputTimer
call setTextColorBlack
call Clrscr

;end game
call DisplayScore
mGotoxy 40, 5
call WaitMsg
call Refresh
call Clrscr
jmp redo

;falling game 
Option4:
call fallgamemenu
call setDifficulty
call fallgame
call Clrscr
call fallingScore
call resetVariables
call Refresh
jmp redo

Option5:
call Clrscr

	INVOKE ExitProcess, 0
main ENDP

;=======================================
;resets certain variables for typing game
;=======================================
Refresh PROC
mov xp, 0
mov yp, 1
mov counter, 0
mov strSize, 0
mov mistakecounter, 0
ret
Refresh ENDP

;======================================
;prompts countdown before starting game
;======================================
DelayMessage PROC
pushad
mov esi, 0
mov ecx, LENGTHOF messageprompt
L5:
mov eax, 250
call Delay
mov al, messageprompt[esi]
call WriteChar
inc esi
loop L5
call Clrscr
popad
ret
DelayMessage ENDP

;==========================================
;displays the score for typing tutor game
;==========================================
DisplayScore PROC
call setTextColorBlack
call Clrscr
mGotoxy 0, 1
mWrite "===< STATS >==="
mGotoxy 0, 2
mov edx, OFFSET scoreprompt1
call WriteString
mov edx, 0 
mov eax, counter
mul percent
div strsize
call WriteDec
mWrite "."
mov counter, edx
mov eax, counter
call WriteDec
mWrite "% "
mov edx, OFFSET scoreprompt2
call WriteString
mGotoxy 0, 3
mWrite "Mistakes: "
mov eax, mistakecounter
call WriteDec
call setTextColorBlack
ret
DisplayScore ENDP

setTextColorWhite Proc uses eax
mov		eax, black + (white * 16)
call	SetTextColor
ret
setTextColorWhite ENDP

setTextColorBlack Proc uses eax
mov		eax, white + (black * 16)
call	SetTextColor
ret
setTextColorBlack ENDP

setTextColorRed PROC uses eax
inc mistakecounter
mov eax, black + (red*16)
call setTextColor
ret
setTextColorRed ENDP

setTextColorGreen PROC uses eax
mov eax, black + (green*16)
call setTextColor
ret
setTextColorGreen ENDP

;======================
;clears time at 9 or 99
;======================
clearLine PROC
pushad
call setTextColorBlack
mov dh, 0
mov dl, 0
call Gotoxy
mov edx, OFFSET space
call WriteString
popad
ret
clearLine ENDP

;===============================
;letter sentence option procedure
;===============================
OptionTwo PROC
mov edx, OFFSET diffsentence
mov esi, OFFSET diffsentence
mov strsize, LENGTHOF diffsentence
ret
OptionTwo ENDP

;=======================================
;timed test procedure
;=======================================
OptionThree PROC
mov edx, OFFSET challsentence
mov esi, OFFSET challsentence
mov strsize, LENGTHOF challsentence
;static option 3 timer
mov maintimer, 75
mov timer, 75
mov count, 75
ret
OptionThree ENDP

;==================================
;sets the time based off user input
;==================================
setTime PROC
push eax
mov edx, OFFSET TimePrompt
call WriteString
call ReadInt
cmp al, 1
jne secondOption
mov maintimer, 60
mov timer, 60
mov count, 60
jmp return
secondOption:
cmp al, 2
jne thirdOption
mov maintimer, 120
mov timer, 120
mov count, 120
jmp return
thirdOption:
mov maintimer, 180
mov timer, 180
mov count, 180
return:
pop eax
ret
setTime ENDP

;=================================
;processes the inputted character 
;=================================
ProcessInput PROC
cmp ax, 0E08h		;if user presses backspace
je backspace
cmp al, [esi]
jne LR			

;jump if not equal else we do green background
call setTextColorGreen
mov al, [esi] 
call WriteInput
inc esi
inc counter
inc xp
jmp L1

;if red then output background with red
LR :
call setTextColorRed
mov al, [esi]
call WriteInput
inc esi
inc counter
inc xp
jmp L1

;for if user presses backspace
backspace:
call WriteInput
dec esi
dec counter
dec xp

;exit procedure
L1:
ret
ProcessInput ENDP

;===================================================
;writes the character at the specified location
;also takes account for moving lines upward and downward
;===================================================
WriteInput PROC
cmp xp, 120
jne secondif
inc yp
mov xp, 0
secondif:
cmp xp, -1
jne output
mov xp, 119
dec yp

output:
mov dh, yp
mov dl, xp
call Gotoxy
call WriteChar
ret
WriteInput ENDP

;==============================================
;Procedures for opening specific file based off useer character input
;==============================================
Extract PROC
push eax
call OpenInputFile
mov filehandle, eax
mov edx, OFFSET buffer
mov ecx, BUFFSIZE
call ReadFromFile
mov strsize, eax
mov eax, filehandle
call CloseFile
mov edx, OFFSET buffer
mov esi, OFFSET buffer
pop eax
ret
Extract ENDP

Atext PROC
mov edx, OFFSET filenameA
call Extract
ret
Atext ENDP

Btext PROC
mov edx, OFFSET filenameB
call Extract
ret
Btext ENDP

Ctext PROC 
mov edx, OFFSET filenameC
call Extract
ret
Ctext ENDP

Dtext PROC
mov edx, OFFSET filenameD
call Extract
ret
Dtext ENDP

Etext PROC
mov edx, OFFSET filenameE
call Extract
ret
Etext ENDP

Ftext PROC
mov edx, OFFSET filenameF
call Extract
ret
Ftext ENDP

Gtext PROC
mov edx, OFFSET filenameG
call Extract
ret
Gtext ENDP

Htext PROC
mov edx, OFFSET filenameH
call Extract
ret
Htext ENDP

Itext PROC
mov edx, OFFSET filenameI
call Extract
ret
Itext ENDP

Jtext PROC
mov edx, OFFSET filenameJ
call Extract
ret
Jtext ENDP

Ktext PROC
mov edx, OFFSET filenameK
call Extract
ret
Ktext ENDP

Ltext PROC
mov edx, OFFSET filenameL
call Extract
ret
Ltext ENDP

Mtext PROC
mov edx, OFFSET filenameM
call Extract
ret
Mtext ENDP

Ntext PROC
mov edx, OFFSET filenameN
call Extract
ret
Ntext ENDP

Otext PROC
mov edx, OFFSET filenameO
call Extract
ret
Otext ENDP

Ptext PROC
mov edx, OFFSET filenameP
call Extract
ret
Ptext ENDP

Qtext PROC
mov edx, OFFSET filenameQ
call Extract
ret
Qtext ENDP

Rtext PROC
mov edx, OFFSET filenameR
call Extract
ret
Rtext ENDP

Stext PROC
mov edx, OFFSET filenameS
call Extract
ret
Stext ENDP

Ttext PROC
mov edx, OFFSET filenameT
call Extract
ret
Ttext ENDP

Utext PROC
mov edx, OFFSET filenameU
call Extract
ret
Utext ENDP

Vtext PROC
mov edx, OFFSET filenameV
call Extract
ret
Vtext ENDP

Wtext PROC
mov edx, OFFSET filenameW
call Extract
ret
Wtext ENDP

Xtext PROC
mov edx, OFFSET filenameX
call Extract
ret
Xtext ENDP

Ytext PROC
mov edx, OFFSET filenameY
call Extract
ret
Ytext ENDP

Ztext PROC
mov edx, OFFSET filenameZ
call Extract
ret
Ztext ENDP


;====================================================================================================ggg
;Game loop with timer and calls process input procedure for displaying the highlighted character
;=====================================================================================================
InputTimer PROC
timeloop:
mov eax, 10
call Delay
call ReadKey
jnz processchar 
mov eax, maintimer
mov timer, eax
mov edx, 0
call GetMSeconds
sub eax, starttime
div second
sub timer, eax
mov eax, timer
cmp eax, count
jne timeloop
mov eax, count
cmp count, 9    ;; for clearing the white spaces
je clearspace
cmp count, 99
jne after
clearspace:
call clearLine 
after:			
mov dh, 0
mov dl, 0
call Gotoxy
call setTextColorWhite
call WriteInt
cmp count, 0	;checks if timer is at 0
dec count
je finish		
jmp timeloop	
processchar: 
call ProcessInput
mov eax, counter
cmp eax, strsize
jne timeloop
finish:
ret
InputTimer ENDP


;=================================================================================================================================================================


;=============================================
;Displays fall game score
;=============================================
fallingScore PROC
cmp wordmark1, LENGTHOF variable1 - 2
jne printscore
inc scoretracker
cmp wordmark2, LENGTHOF variable2 - 2
jne printscore
inc scoretracker
cmp wordmark3, LENGTHOF variable3 - 2
jne printscore
inc scoretracker
cmp wordmark4, LENGTHOF variable4 - 2
jne printscore
inc scoretracker
cmp wordmark5, LENGTHOF variable5 - 2
jne printscore
inc scoretracker
cmp wordmark6, LENGTHOF variable6 - 2
jne printscore
inc scoretracker
cmp wordmark7, LENGTHOF variable7 - 2
jne printscore
inc scoretracker



printscore:
mov eax, 0
add eax, wordmark1
add eax, wordmark2
add eax, wordmark3
add eax, wordmark4
add eax, wordmark5
add eax, wordmark6
add eax, wordmark7
mov counter, eax

mGotoxy 0, 5
mWriteString OFFSET stats
mov eax, scoretracker
mGotoxy 0, 6
call WriteDec
mWrite " words completed"
mGotoxy 0, 7
mWrite "Accuracy: "
mov edx, 0
mov eax, counter
mul percent
div accuracytracker
call WriteDec
mov accuracytracker, edx
mov eax, accuracytracker
mWrite "."
call WriteDec
mWrite "%"
mGotoxy 45, 10
call WaitMsg
call Clrscr
ret
fallingScore ENDP


;==================================
;resets everything for fall game
;==================================
resetVariables PROC
mov yp1, 0
mov yp2, 0
mov yp3, 0
mov yp4, 0
mov yp5, 0
mov yp6, 0
mov yp7, 0
mov wordmark1, 0
mov wordmark2, 0
mov wordmark3, 0
mov wordmark4, 0
mov wordmark5, 0
mov wordmark6, 0
mov wordmark7, 0
mov timerIterator, 1
mov ExitCondition, 0
mov divisor, 1000
mov counterf, 1
mov scoretracker, 0
mov tempyp1, 0
mov tempyp2, 0
mov tempyp3, 0
mov tempyp4, 0
mov tempyp5, 0
mov tempyp6, 0
mov tempyp7, 0
mov accuracytracker, 0
ret
resetVariables ENDP


;======================================
;sets the speed of the falling words
;======================================
setDifficulty PROC
cmp levelchoice, 1
jne difficultytwo
mov difficultylevel, 1000
jmp leaveproc

difficultytwo:
cmp levelchoice, 2
jne difficultythree
mov difficultylevel, 750
jmp leaveproc

difficultythree:
mov difficultylevel, 500
leaveproc:

ret
setDifficulty ENDP


;=============================
;menu that displays difficulties
;=============================
fallgamemenu PROC
mov edx, OFFSET fallmenu
call WriteString
call ReadInt
mov levelchoice, al
call Clrscr
ret
fallgamemenu ENDP



;===========================
;fall gameloop
;===========================
fallgame PROC
call getMseconds
	mov starttime, eax

	fallgameloop:
	;prints out each word 
	mov dh, yp1
	mov dl, xp1
	call WriteInChars1
	cmp counterf, 2
	jb continue
	mov dh, yp2
	mov dl, xp2
	call WriteInChars2
	cmp counterf, 3
	jb continue
	mov dh, yp3
	mov dl, xp3
	call WriteInChars3
	cmp counterf, 4
	jb continue
	mov dh, yp4
	mov dl, xp4
	call WriteInChars4
	cmp counterf, 5
	jb continue
	mov dh, yp5
	mov dl, xp5
	call WriteInChars5
	cmp counterf, 6
	jb continue
	mov dh, yp6
	mov dl, xp6
	call WriteInChars6
	cmp counterf, 7
	jb continue
	mov dh, yp7
	mov dl, xp7
	call WriteInChars7

	;reduces time 
	continue:
	call ReadInput
	cmp al, 1
	je reducetime
	mov char, al
	inc accuracytracker
	jmp fallgameloop
	reducetime:
	mov edx, 0
	call getMseconds
	sub eax, starttime
	div divisor
	;cmp eax, timerIterator 
	cmp eax, 1 
	jne continue

	mov eax, difficultylevel
	add divisor, eax
	call increaseYPositions
	call checkYPositions
	cmp ExitCondition, 1
	je gameFinish
	cmp wordmark7, LENGTHOF variable7-2
	je gameFinish
	inc timerIterator
	inc counterf
	call Clrscr
	call WriteFloor
		jmp fallgameloop

		gameFInish:
ret
fallgame ENDP

;===================================
;updates line positions
;====================================
checkYPositions PROC
cmp tempyp1, 25
je setExit
cmp tempyp2, 25
je setExit
cmp tempyp3, 25
je setExit
cmp tempyp4, 25
je setExit
cmp tempyp5, 25
je setExit
cmp tempyp6, 25
je setExit
cmp tempyp7, 25
je setExit
jmp notSet

setExit:
mov ExitCondition, 1

notSet:
ret
checkYPositions ENDP

;==========================================
increaseYPositions PROC
	inc yp1
	cmp counterf, 2
	jb continue
	inc yp2
	cmp counterf, 3
	jb continue
	inc yp3
	cmp counterf, 4
	jb continue
	inc yp4
	cmp counterf, 5
	jb continue
	inc yp5
	cmp counterf, 6
	jb continue
	inc yp6
	cmp counterf, 7
	jb continue
	inc yp7

	continue:
	ret
increaseYPositions ENDP

;============================================================
setTextBlue PROC uses eax
mov eax, blue + (black * 16)
call setTextColor
ret
setTextBlue ENDP

setTextGreen PROC uses eax
mov eax, green + (black * 16)
call setTextColor
ret
setTextGreen ENDP


;===========================================================
;variable procedures for each word
;===========================================================
WriteInChars1 PROC
cmp wordmark1, LENGTHOF variable1 - 2
je skipproc1
call Gotoxy
;check input
mov esi, wordmark1
mov al, char
cmp variable1[esi], al
mov esi, 0
jne writeinblue1
inc wordmark1

writeinblue1:
cmp wordmark1, 0
je writeregular1

call setTextGreen
mov ecx, wordmark1
LL1:
	mov al, variable1[esi]
	call WriteChar
	inc esi
loop LL1

writeregular1:
call setTextBlue
mov ecx, LENGTHOF variable1 - 1
sub ecx, wordmark1
L1:
mov al, variable1[esi]
call WriteChar
inc esi
loop L1
mov al, yp1
mov tempyp1, al
skipproc1:
ret
WriteInChars1 ENDP

;======================================================
WriteInChars2 PROC
cmp wordmark2, LENGTHOF variable2 - 2
je skipproc2
call Gotoxy
mov esi, 0
cmp wordmark1, LENGTHOF variable1 - 2
jne writeregular2

;check input
mov esi, wordmark2
mov al, char
cmp variable2[esi], al
mov esi, 0
jne writeinblue2
inc wordmark2

writeinblue2:
cmp wordmark2, 0
je writeregular2

call setTextGreen
mov ecx, wordmark2
LL2:
	mov al, variable2[esi]
	call WriteChar
	inc esi
loop LL2

writeregular2:
call setTextBlue
mov ecx, LENGTHOF variable2 - 1
sub ecx, wordmark2
L2:
mov al, variable2[esi]
call WriteChar
inc esi
loop L2
mov al, yp2
mov tempyp2, al
skipproc2:
ret
WriteInChars2 ENDP

;===================================================
WriteInChars3 PROC
cmp wordmark3, LENGTHOF variable3 - 2
je skipproc3
call Gotoxy
mov esi, 0
;compound and statement
cmp wordmark1, LENGTHOF variable1 - 2
jne writeregular3
cmp wordmark2, LENGTHOF variable2 - 2
jne writeregular3

;check input
mov esi, wordmark3
mov al, char
cmp variable3[esi], al
mov esi, 0
jne writeinblue3
inc wordmark3

writeinblue3:
cmp wordmark3, 0
je writeregular3

call setTextGreen
mov ecx, wordmark3
LL3:
	mov al, variable3[esi]
	call WriteChar
	inc esi
loop LL3

writeregular3:
call setTextBlue
mov ecx, LENGTHOF variable3 - 1
sub ecx, wordmark3
L3:
mov al, variable3[esi]
call WriteChar
inc esi
loop L3
mov al, yp3
mov tempyp3, al
skipproc3:
ret
WriteInChars3 ENDP

;====================================================
WriteInChars4 PROC
cmp wordmark4, LENGTHOF variable4 - 2
je skipproc4
call Gotoxy
mov esi, 0
;compound and statement
cmp wordmark1, LENGTHOF variable1 - 2
jne writeregular4
cmp wordmark2, LENGTHOF variable2 - 2
jne writeregular4
cmp wordmark3, LENGTHOF variable3 - 2
jne writeregular4

;check input
mov esi, wordmark4
mov al, char
cmp variable4[esi], al
mov esi, 0
jne writeinblue4
inc wordmark4

writeinblue4:
cmp wordmark4, 0
je writeregular4

call setTextGreen
mov ecx, wordmark4
LL4:
	mov al, variable4[esi]
	call WriteChar
	inc esi
loop LL4

writeregular4:
call setTextBlue
mov ecx, LENGTHOF variable4 - 1
sub ecx, wordmark4
L4:
mov al, variable4[esi]
call WriteChar
inc esi
loop L4
mov al, yp4
mov tempyp4, al
skipproc4:
ret
WriteInChars4 ENDP

;==========================================================
WriteInChars5 PROC
cmp wordmark5, LENGTHOF variable5 - 2
je skipproc5
call Gotoxy
mov esi, 0
;compound and statement
cmp wordmark1, LENGTHOF variable1 - 2
jne writeregular5
cmp wordmark2, LENGTHOF variable2 - 2
jne writeregular5
cmp wordmark3, LENGTHOF variable3 - 2
jne writeregular5
cmp wordmark4, LENGTHOF variable4 - 2
jne writeregular5

;check input
mov esi, wordmark5
mov al, char
cmp variable5[esi], al
mov esi, 0
jne writeinblue5
inc wordmark5

writeinblue5:
cmp wordmark5, 0
je writeregular5

call setTextGreen
mov ecx, wordmark5
LL5:
	mov al, variable5[esi]
	call WriteChar
	inc esi
loop LL5

writeregular5:
call setTextBlue
mov ecx, LENGTHOF variable5 - 1
sub ecx, wordmark5
L5:
mov al, variable5[esi]
call WriteChar
inc esi
loop L5
mov al, yp5
mov tempyp5, al
skipproc5:
ret
WriteInChars5 ENDP


;====================================================
WriteInChars6 PROC
cmp wordmark6, LENGTHOF variable6 - 2
je skipproc6
call Gotoxy
mov esi, 0
;compound and statement
cmp wordmark1, LENGTHOF variable1 - 2
jne writeregular6
cmp wordmark2, LENGTHOF variable2 - 2
jne writeregular6
cmp wordmark3, LENGTHOF variable3 - 2
jne writeregular6
cmp wordmark4, LENGTHOF variable4 - 2
jne writeregular6
cmp wordmark5, LENGTHOF variable5 - 2
jne writeregular6

;check input
mov esi, wordmark6
mov al, char
cmp variable6[esi], al
mov esi, 0
jne writeinblue6
inc wordmark6

writeinblue6:
cmp wordmark6, 0
je writeregular6

call setTextGreen
mov ecx, wordmark6
LL6:
	mov al, variable6[esi]
	call WriteChar
	inc esi
loop LL6

writeregular6:
call setTextBlue
mov ecx, LENGTHOF variable6 - 1
sub ecx, wordmark6
L6:
mov al, variable6[esi]
call WriteChar
inc esi
loop L6
mov al, yp6
mov tempyp6, al
skipproc6:
ret
WriteInChars6 ENDP

;===============================================================
WriteInChars7 PROC
cmp wordmark7, LENGTHOF variable7 - 2
je skipproc7
call Gotoxy
mov esi, 0
;compound and statement
cmp wordmark1, LENGTHOF variable1 - 2
jne writeregular7
cmp wordmark2, LENGTHOF variable2 - 2
jne writeregular7
cmp wordmark3, LENGTHOF variable3 - 2
jne writeregular7
cmp wordmark4, LENGTHOF variable4 - 2
jne writeregular7
cmp wordmark5, LENGTHOF variable5 - 2
jne writeregular7
cmp wordmark6, LENGTHOF variable6 - 2
jne writeregular7

;check input
mov esi, wordmark7
mov al, char
cmp variable7[esi], al
mov esi, 0
jne writeinblue7
inc wordmark7

writeinblue7:
cmp wordmark7, 0
je writeregular7

call setTextGreen
mov ecx, wordmark7
LL7:
	mov al, variable7[esi]
	call WriteChar
	inc esi
loop LL7

writeregular7:
call setTextBlue
mov ecx, LENGTHOF variable7 - 1
sub ecx, wordmark7
L7:
mov al, variable7[esi]
call WriteChar
inc esi
loop L7
mov al, yp7
mov tempyp7, al
skipproc7:
ret
WriteInChars7 ENDP


;=======================================================
;waits for input
;=======================================================
ReadInput PROC
mov eax, 15
call Delay
call ReadKey
ret
ReadInput ENDP

;======================================================
;prints out the floor
;======================================================
WriteFloor PROC
push edx
mov dh, 25
mov dl, 0
call Gotoxy
mov eax, red + (black * 16)
call setTextColor
mov edx, OFFSET floor
call WriteString
pop edx
ret
WriteFLoor ENDP


END main