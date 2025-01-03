      *****************************************************************
      * Program name:    FileCreate                                    
      * Current Author: David Catino                                   
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILE-CREATE.
       AUTHOR. David Catino.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
	   SELECT CUSTOMER-FILE ASSIGN TO 'Customers.dax'
		   ORGANIZATION IS LINE SEQUENTIAL. 
	   DATA DIVISION.
	   FILE SECTION.
	   FD CUSTOMER-FILE.
	   01 CUSTOMER-RECORD.
	       05 FIRST-NAME PIC X(20).
		   05 LAST-NAME PIC X(20).

	   WORKING-STORAGE SECTION.
	   01 WS-CUSTOMER-RECORD.
		   05 WS-FIRST-NAME PIC X(20).
		   05 WS-LAST-NAME PIC X(20).
	   01 WS-EOF PIC X(1) VALUE 'N'.

	   PROCEDURE DIVISION.
	   OPEN OUTPUT CUSTOMER-FILE.
	   PERFORM UNTIL CUSTOMER-RECORD = SPACES
           DISPLAY 'Enter the first and last name for the customer:'
           ACCEPT CUSTOMER-RECORD
           WRITE CUSTOMER-RECORD
       END-PERFORM
           CLOSE CUSTOMER-FILE
           DISPLAY 'Reading from Customer File'
           OPEN INPUT CUSTOMER-FILE.
               PERFORM UNTIL WS-EOF = 'Y'
                   READ CUSTOMER-FILE INTO WS-CUSTOMER-RECORD
                       AT END MOVE 'Y' TO WS-EOF
                       NOT AT END DISPLAY WS-CUSTOMER-RECORD
                   END-READ
               END-PERFORM
	   CLOSE CUSTOMER-FILE.
	   GOBACK.
