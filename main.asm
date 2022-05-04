TITLE MASM Template						(main.asm)

; Import the Irvine library functions
INCLUDE Irvine32.inc
;Partners: Kahlyll Wilson & Samantha McCartney
;Pupose: the purpose of this lab is to create a program 
;        that will allow the user to use multiple methods 
;        as many times as they want until they quit the program


; Data declarations section used to declare variables for the program
.data
;<<<<<<<<<<<<<<<<<<|Instructions & if you want to continue|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	;intros message and prompts 
		intro BYTE "Welcome to the Swiss Army Program!",0dh,0ah,0
		directions BYTE "What would you like to do?: ",0dh,0ah,0
		option1 BYTE "1: Coin Flipper ",0dh,0ah,0
		option2 BYTE "2: Dice Roller ",0dh,0ah,0
		option3 BYTE "3: String Searcher",0dh,0ah,0
		option4 BYTE "4: Grad Age Calculator",0dh,0ah,0
		option5 BYTE "5: Word Reverser",0dh,0ah,0
		option6 BYTE "6: Quit",0dh,0ah,0 
		responseQuestion BYTE "What would you like to do?: ",0dh,0ah,0 
		response DWORD 1 DUP (0),0 

	;used for the options
		one   DWORD 1
		two   DWORD 2
		three DWORD 3
		four  DWORD 4
		five  DWORD 5
		six   DWORD 6


;<<<<<<<<<<<<<<<<<<<<<<|Goodbye message|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	;The message displayed when the user exist the program
		bye BYTE "Thank you for using the program!",0dh,0ah,0

;<<<<<<<<<<<<<<<<<<<<<<<|Coin flipper variables and instructions|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	;Displays instructions
		inputMessage BYTE "How many times do you want to flip the coin? ", 0

	;Displays the total outcome 
		headsOutcomeMessage	BYTE "HEADS was flipped!", 0
		tailsOutcomeMessage	BYTE "TAILS was flipped!", 0
		headsMessage BYTE "Total number of HEADS: ", 0
		tailsMessage BYTE "Total number of TAILS: ", 0

	;Used for keeping count
		headsCount DWORD 0
		tailsCount DWORD 0
		flipCount DWORD 0

	;used for the heads and tials counter 
		HEADS = 0
		TAILS = 1

;<<<<<<<<<<<<<<<<<<<<<<<|Dice roller variables and instructions|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	;displays instructions and messages to get the prompts
		 howMany BYTE "How many times would you like to roll the dice: ",0dh,0ah,0
		 diceOne BYTE "Dice One: ",0
		 diceTwo BYTE "Dice two: ",0

		 die1 DWORD 0
		 die2 DWORD 0

	 ;Stores the users inputs in the variables
		 addOne DWORD 1
		 numberSix DWORD 6
		 loopCounter DWORD 0
		 

;<<<<<<<<<<<<<<<<<<<<<<|String Searcher variables and instructions|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	;gathers input from the user
		 intialInput BYTE "Enter a string: ",0
		 enteredString BYTE 100 DUP (0),0
		 locateCharacter BYTE "Enter a single character to search: ",0
		 character BYTE 1 DUP (0),0

	 ;preparing message
		 preformMes BYTE "Preforming search...",0
		 completeMes BYTE "Search complete.",0.

	 ;completed results message
		 start BYTE "Search Results:",0
		 begining BYTE "The character '",0
		 middle BYTE "' was found ",0
		 ending BYTE " times in the string.",0
		 first BYTE "The first occurance: ",0
		 last BYTE "The last occurance: ",0

	 ;used to store numeric variables
		 numberOfTimesFound DWORD 0 ;used for counting how many times a character is found
		 firstIndex DWORD 0 ;stores the results of the first index
		 lastIndex DWORD 0 ;stores teh result for the last index
		 index DWORD 0 ;uses the current index
		 notThere DWORD 0 ;used for the loop if not found ;used for if there 

;<<<<<<<<<<<<<<<<<<<<|Grad Age Calculator variables and instructions|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	;Variables used for getting the information from the user
		 getName BYTE "What is your name? ", 0
		 getBirthYear BYTE "What is your Birth year? ", 0
		 getMajor BYTE "What is your major? ", 0
		 getGradYear BYTE "What is your Grad Year ", 0

	 ;Variables used for setting the strings in the final sentence
		 setName BYTE 30 DUP(0), 0
		 setBirthYear DWORD 0, 0
		 setMajor BYTE 30 DUP(0), 0
		 setGradYear DWORD 0, 0

	 ;Variable used for calculating age
		 age DWORD 0, 0

	 ;Variables used for writing the final message
		 introName BYTE "Hi, ",0
		 period BYTE ". ",0
		 introAge BYTE "You will be ",0
		 middleSentence BYTE " years old when you graduate with a degree in ",0
		 insertIn BYTE " in ", 0
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<|String Reverser|>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	;Variables for getting the information
		sourceString BYTE "Pleaes enter a 3 letter word to be reversed",0
		
		reverseString BYTE 30 DUP(0), 0
		target BYTE SIZEOF sourceString Dup(0),0

; Code section used to write the code for the program.
.code
main PROC
	call Clrscr
;================================================================================================
;Gives initial insturctions

		mov edx,OFFSET intro
		call WriteString

CONTINUE:
		mov edx,OFFSET directions
		call WriteString

		mov edx,OFFSET option1
		call WriteString

		mov edx,OFFSET option2
		call WriteString

		mov edx,OFFSET option3
		call WriteString

		mov edx,OFFSET option4
		call WriteString

		mov edx,OFFSET option5
		call WriteString

		mov edx,OFFSET option6
		call WriteString

		mov edx,OFFSET responseQuestion
		call WriteString

		call ReadDec
		mov response, eax

		;compares the response to the other choices 
		MOV edx, response
		cmp edx, one
		JE optionONE
		cmp edx, two
		JE optionTWO
		cmp edx, three
		JE optionTHREE
		cmp edx, four
		JE optionFOUR
		cmp edx, five
		JE optionFIVE
		cmp edx, six
		JE optionSIX

;================================================================================================
;completes Coin flipper


optionONE:
;clears the screen and the registers before use
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov tailsCount, 0
	mov headsCount, 0
	call Clrscr

	; Get the number of times the user wants to flip the coin,
		mov edx, OFFSET inputMessage
		call WriteString
		call ReadDec
		mov flipCount, eax
		call coinFlip

	; Display the final counts for heads and tails
		mov edx, OFFSET tailsMessage
		call WriteString

		mov eax, tailsCount
		call WriteDec
		call Crlf

		mov edx, OFFSET headsMessage
		call WriteString

		mov eax, headsCount
		call WriteDec
		call Crlf
		call Crlf
		
		JMP CONTINUE
;================================================================================================
;completes Dice roller variables and instructions 
optionTWO:
;clears the screen and the registers before use
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	call Clrscr
	
	mov edx,OFFSET howMany
	call WriteString
	call ReadDec

	mov ecx, eax
	call DiceRoller

	mov edx, OFFSET tailsMessage
	call WriteString

JMP CONTINUE
;================================================================================================
;completes String Searcher variables and instructions 

optionTHREE:
;clears the screen and the registers before use
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov numberOfTimesFound, 0
	mov firstIndex , 0
	mov lastIndex , 0
	mov index, 0
	call Clrscr

 ;prints out the initial message

	MAX = 101
	MIN = 2

	mov edx,OFFSET intialInput
	call WriteString

	mov edx, OFFSET enteredString
	mov ecx, MAX ;buffer size - 1
	call ReadString

	mov edx,OFFSET locateCharacter
	call WriteString

	mov edx, OFFSET character
	mov ecx, MIN ;buffer size - 1
	call ReadString
	call Crlf
	call Crlf

 ;Calls the search string prodecure to look for the string
 ;copies input parameters needed for the Search String procedure
 ;into the appropriate registers and then executes the procedure.

	mov edx, SIZEOF enteredString
	mov esi, OFFSET enteredString
	mov edi, OFFSET character
	call searchString

 ;prints the final message
 ;prints preparing message
	mov edx,OFFSET preformMes
	call WriteString
	call Crlf

	mov edx,OFFSET completeMes
	call WriteString
	call Crlf
	call Crlf

	;prints final message
	mov edx,OFFSET start
	call WriteString
	call Crlf

	mov edx,OFFSET begining
	call WriteString

	mov edx,OFFSET character
	call WriteString

	mov edx,OFFSET middle
	call WriteString

	mov eax, numberOfTimesFound
	call WriteDec

	mov edx,OFFSET ending
	call WriteString

	;Prints the first and last index of the characters
	call Crlf
	mov edx,OFFSET first
	call WriteString

	mov eax, firstIndex
	call WriteDec
	call Crlf

	mov edx,OFFSET last
	call WriteString

	mov eax, lastIndex
	call WriteDec
	call Crlf
	call Crlf

	JMP CONTINUE
;================================================================================================
optionFOUR:
;clears the screen and the registers before use
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	call Clrscr

;completes Age Calculator variables and instructions 
	 MOV eax, 0
	 MOV ebx, 0

	 call Clrscr

 ;Constant for getting the maximum characters allowed

	MAX_CHARS = 100

 ;Prints prompt and gets user input
 ;Prints prompt
 mov edx, OFFSET getName
 call WriteString

 ;reads string input and stores it
	 MOV edx, OFFSET setName
	 MOV ecx, MAX_CHARS
	 CALL ReadString

 ;Prints prompt for number
	 mov edx, OFFSET getBirthYear
	 call WriteString

 ;reads the number and stores value
	 CALL ReadDec
	 MOV setBirthYear, eax

	 mov edx,OFFSET getMajor
	 call WriteString

	 MOV edx, OFFSET setMajor
	 MOV ecx, MAX_CHARS
	 CALL ReadString

	 mov edx,OFFSET getGradYear
	 call WriteString
	 CALL ReadDec

	MOV setGradYear, eax

 ;calculates age

	MOV eax, setGradYear
	MOV ebx, setBirthYear
	call gradAgeCalculator

 ;Prints out the users input with the correct input
	 call Crlf
	 mov edx, OFFSET introName
	 call WriteString

	 mov edx, OFFSET setName
	 call WriteString

	 mov edx, OFFSET period
	 call WriteString

	 mov edx, OFFSET introAge
	 call WriteString

	 mov eax, age
	 call WriteDec
	 call Crlf

	 mov edx, OFFSET middleSentence
	 call WriteString

	 mov edx, OFFSET setMajor
	 call WriteString

	 mov edx, OFFSET insertIn
	 call WriteString

	 mov eax, setGradYear
	 call WriteDec
	 call Crlf

	 JMP CONTINUE
;=============================================================================
;String reverser
optionFive:
;clears the screen and the registers before use
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	call Clrscr

;displays initial message and reads in string 
	mov edx,OFFSET sourceString
	call WriteString
	call Crlf

	mov edx, OFFSET reverseString
	mov ecx, SIZEOF reverseString
	call ReadString

;sends the items to the strings  
	mov edx, SIZEOF reverseString
	MOV esi, OFFSET reverseString+2
	mov edi, OFFSET target
	call reversal
			
;prints the converted string to the screen

	mov	 edx,OFFSET target
	call WriteString
	call crlf
	call crlf

JMP CONTINUE
;=============================================================================
;quits the game

optionSIX:

	call Clrscr
	mov edx,OFFSET bye 
	call WriteString

	exit
main ENDP


;---------------------------------------------------------------------------------
coinFlip PROC
;
;Purpose: allow the user to flip a coin a user-specified number of times and the program 
;         displays the string result (Heads or Tails) of the operation.
;
;
;Recieves:    eax flip count
;
;
;Returns: Heads and tails
;----------------------------------------------------------------------------------

; Setup a loop to execute the number of times the user
; wants to flip the coin.
	mov ecx, eax

call Randomize			; Seeds the random number generator before calling RandomRange

FlipLoop:
	; Loop that executes the number of times to flip the coin
	; Generate a random number between 0 and 2 not including 2 that represents
	; the coin flip.
	mov eax, 2
	call RandomRange

	; Determine the outcome of the flip and display a message accordingly.
	; Keep track of the number of heads and tails that were flipped.
	
	cmp eax, TAILS
	JE TailsFlip		; jump when eax == TAILS
	inc headsCount		; otherwise, heads was flipped
	mov edx, offset headsOutcomeMessage
	call WriteString
	call Crlf
	JMP Next			

TailsFlip:
	; Body of code that handles a tails outcome.
	inc tailsCount		
	mov edx, offset tailsOutcomeMessage
	call WriteString
	call Crlf

Next:

	LOOP FlipLoop



RET
coinFlip ENDP


;----------------------------------------------------------------------------------
DiceRoller PROC
;
;Purpose: Allow the user to roll a set of dice a user-specified number of 
;         times and the program displays the result of each die face.
;
;
;Recieves:		eax - how many times to roll the dice
;
;
;Returns: Dice rolls
;-----------------------------------------------------------------------------------

mov ecx, eax

CALL Randomize


	diceRollerGenerator:
		
		mov edx,OFFSET diceOne
		call WriteString

		MOV eax, numberSix            ;range (0 through to six - 1) 
		CALL RandomRange		
		ADD eax, addOne          ;The original startingValue is added to the newStart random value
		CALL WriteDec		     ;Prints the result of first die
		CALL CRLF		
		
		mov edx,OFFSET diceTwo
		call WriteString

		MOV eax, numberSix             ;range (0 through to six - 1) 
		CALL RandomRange		
		ADD eax, addOne          ;The original startingValue is added to the newStart random value
		CALL WriteDec		     ;Prints the result of second die
		CALL CRLF
		CALL CRLF


	LOOP diceRollerGenerator


RET
DiceRoller ENDP

;------------------------------------------------------------------------------------
searchString PROC
;
;Purpose: This Procedure is used to search for how many indexs of the character is within the string
;         the procedure will also find the first occurance of the character in the index
;         then finally it will find the last occurance of the character in the index.
;
;
;Recieves:   EDX - SIZEOF enteredString
;            ESI - OFFSET enteredString
;            EDI - OFFSET character
;
;
;
;Returns: modified destination variables
;-------------------------------------------------------------------------------------

;copies the value into a string

mov ecx, edx

IsThereLoop:
	 mov dl, [esi]                        ;loads in the source string for comparreison
	 cmp dl, [edi]                        ;compares source string to character
	 JNE notFound
	 JE found

	 notFound:                            ;seperates the not found out
			 INC notThere                 ;records if not there
			 INC index                    ;indicates where the loop is at in the string
			 INC esi                      ;moves to the next index
			 JMP Next

	 found:
			 INC numberOfTimesFound       ;stores the number of times found
			 INC index                    ; current index
			 mov ebx, firstIndex
			 mov eax, index
			 cmp ebx, 0                   ;compares the firstIdex to zero
			 JE firstEncounter            ;if Zero then it will add the current index
			 mov lastIndex, eax           ;moves the current index to the last occurance
			 INC esi                      ;moves to the next index
			 JMP Next

	 firstEncounter:
			 mov firstIndex, eax          ;moves the current index to the first occurance
			 INC esi
			 JMP Next

 Next:
	LOOP IsThereLoop


RET
searchString ENDP


;------------------------------------------------------------------------------
gradAgeCalculator PROC
;
;Purpose: This procedure calculates when a user will be graduating based on 
;         Birth year, and Graduation year.
;
;
;Recieves:          eax - setGradYear
;				    ebx - setBirthYea
; 
;Returns: age
;------------------------------------------------------------------------------

;Calculates the age
	 
	 sub eax, ebx
	 MOV age, eax
	 call WriteDEC

RET
gradAgeCalculator ENDP



;-----------------------------------------------------------------------------
reversal PROC
;
;Purpose: This procedure reverses the string 
;
;
;Recieves:          esi - takes in the string and then reverses it 
;					edi - starting address of the destination string 
;					edx - the size of the target string 
;                   
;					
; 
;Returns: reversed string
;------------------------------------------------------------------------------


	;the loop count
	MOV ecx, SIZEOF sourceString
		
	reverseWordLoop:	
		
		MOV al, [esi]           ;takes the value from the sourcestring and places it in al
		Mov [edi], al     ;takes the value from al and places it in target 
		
		DEC esi					;moves to the next character in the sourceString  

		INC edi					;moves to the next character in the target

		Loop reverseWordLoop

RET
reversal ENDP

END main