      *****************************************************************
      * Program name:    input                                         
      * Current Author: David Catino                                   
      *                                                                
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. input.
       AUTHOR. David Catino.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 USER-NAME PIC X(15).
       PROCEDURE DIVISION.
           100-GET-USER-INPUT.
           DISPLAY 'Enter the User Name'.
           ACCEPT USER-NAME.
           200-PRINT-USER-NAME.
           DISPLAY 'The User Name: ' USER-NAME.
           300-STOP-APP.
           STOP RUN.
