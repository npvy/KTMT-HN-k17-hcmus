main:
.data
        # Data for Program
	tb0: .asciiz "\n----------Ban hay chon 1 trong cac thao tac duoi day----------\n"
	tb1: .asciiz "1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"
	tb2: .asciiz "2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:"
	tb2a: .asciiz "\n\tA. MM/DD/YYYY\n"
	tb2b: .asciiz "\tB. Month DD, YYYY\n"
	tb2c: .asciiz "\tC. DD Month, YYYY\n"
        tb3: .asciiz "3. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong\n"
	tb4: .asciiz "4. Cho biet ngay vua nhap la ngay thu may trong tuan\n"
        tb5: .asciiz "5. Cho biet ngay vua nhap la ngay thu may ke tu ngay 1/1/1.\n"
        tb6: .asciiz "6. Cho biet can chi cua nam vua nhap.\n"
	tb7: .asciiz "7. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2\n"
	tb8: .asciiz "8. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi time\n"
        tb9: .asciiz "9. Nhap input tu file input.txt xuat ket qua toan bo cac chuc nang tren ra file output.txt\n" 
        tb10: .asciiz "10. Thoat.\n"
	str_: .asciiz "\n----------------------------------------------------------\n"
        StrChoose: .asciiz "\nLua chon: "
       	strResult: .asciiz "\nKet qua: "
	errorChoose: .asciiz "\nLua chon sai cu phap! Vui long nhap lai lua chon: \n"
        time1: .space 40
	time2: .space 40

.text   
        la $a0, time1
	jal input   #goi ham input voi vùng nho chuoi
	add $t0,$v0,$0  #luu ket qua vao t0
menu: 
        # xuat menu
    	la $a0,tb0  
    	addi $v0,$0,4
    	syscall
    	
    	la $a0,tb1  
    	syscall
    	
    	la $a0,tb2  
    	syscall
    	
    	la $a0,tb2a 
    	syscall
    	
    	la $a0,tb2b
    	syscall
    	
    	la $a0,tb2c
        syscall
    	
    	la $a0,tb3
    	syscall
    	
        la $a0,tb4   
    	syscall
    	
        la $a0,tb5
    	syscall
    	
        la $a0,tb6
    	syscall
    	
        la $a0,tb7
    	syscall
    
        la $a0,tb8
    	syscall
    
        la $a0,tb9
    	syscall
    
        la $a0,tb10
    	syscall
	
	la $a0,str_
    	syscall
    
	# xuat thong bao lua chon
    	la $a0,StrChoose
    	syscall	
    
	#Nhap vao so nguyen
	li $v0, 5
	syscall

	#Luu lai thao tac vao $t1
	addi $t1, $v0, 0

	#Xu ly
	beq $t1, 1, YC1
	beq $t1, 2, YC2
	beq $t1, 3, YC3
	beq $t1, 4, YC4
	beq $t1, 5, YC5
	beq $t1, 6, YC6
	beq $t1, 7, YC7
	beq $t1, 8, YC8
	beq $t1, 9, YC9
	beq $t1, 10, Exit

	#Nhap sai thi bat nhap lai
	la $a0,errorChoose
	addi $v0,$0,4
	syscall

        addi $a0,$0,2000		#sleep 2s
	li $v0,32
	syscall

        j menu
        
## KET THUC MENU

YC1:
	
        # Print ket qua chuoi da nhap
        la $a0,strResult			
	li $v0, 4
	syscall

	add $a0,$t0,$0			# gán $a0 = $t0 
	li $v0, 4				
	syscall				#in chuoi 
        
        addi $a0,$0,2000		#sleep 2s
	li $v0,32
	syscall

        j menu
        
YC2:
	
        la $a0,tb2a
	li $v0,4
	syscall
	
	la $a0,tb2b
	syscall
	
	la $a0,tb2c
	syscall

        la $a0, StrChoose
	li $v0,4
	syscall

	li $v0,12	# nhap ki tu A or B or C
	syscall

	addi $t1,$0,65     #A
	beq $v0,$t1, continueYC2
	
	addi $t1,$0,66     #B
	beq $v0,$t1, continueYC2
	
	addi $t1,$0,67     #C
	beq $v0,$t1, continueYC2

	#Nhap sai thi bat nhap lai
	la $a0,errorChoose
	addi $v0,$0,4
	syscall

        addi $a0,$0,2000		#sleep 2s
	li $v0,32
	syscall

	j YC2
continueYC2:
        la $a0,strResult			
	li $v0, 4
	syscall

	add $a0,$t0,$0
	add $a1,$t1,$0  ### gan gia tri choose

        jal Convert

	add $a0,$v0,$0
	li $v0,4
	syscall 

	addi $a0,$0,2000
	li $v0,32
	syscall

	j menu
       
YC3:
        la $a0,strResult			
	li $v0, 4
	syscall

	add $a0,$t0,$0
	
	jal LeapYear			

	.data 
        	leap: .asciiz "Nam nhuan\n"
        	nleap:.asciiz "Nam khong nhuan\n"
	.text 
	
        	beq $v0, $0, NotLeap		
        	la $a0,leap
        	j next
        
                NotLeap:  
                        la $a0,nleap
                next:	
                        li $v0,4
                	syscall
                	
                	addi $a0,$0,2000
                	li $v0,32
                	syscall
                	j menu
      
YC4:
        la $a0,strResult			
	li $v0, 4
	syscall

	add $a0,$t0,$0
	
	jal WeekDay			
        add $a0,$v0,$0
	li $v0,4
	syscall 

	addi $a0,$0,2000
	li $v0,32
	syscall
        j menu
YC5:
        la $a0,strResult			
	li $v0, 4
	syscall

	add $a0,$t0,$0
	jal FullDate

        add $a0,$v0,$0
	li $v0,1
	syscall 

	addi $a0,$0,2000
	li $v0,32
	syscall
        j menu
        
YC6:
        la $a0,strResult			
	li $v0, 4
	syscall

        add $a0,$t0,$0

        jal Can
        add $a0,$v0,$0
        li $v0, 4
	syscall

        add $a0,$t0,$0

        jal Chi
        add $a0,$v0,$0
        li $v0, 4
	syscall

        addi $a0,$0,2000		#sleep 2s
	li $v0,32
	syscall

        j menu
       
YC7:
        .data
	   strDate2: .asciiz "\nMoi ban nhap Date thu 2: "	
	.text
	
	addi $sp,$sp,-4
	sw $t1,0($sp)
	
	la $a0,strDate2
	addi $v0,$0,4
	syscall
	
	la $a0,time2
	jal input
	add $t1,$v0,$0
	
        la $a0,strResult			
	li $v0, 4
	syscall
	
	#t0: time1, t1: time2
	
	add $a0,$t0,$0
	add $a1,$t1,$0

	jal DateDiff
	
	add $a0,$v0,$0 # print_int
	li $v0,1
	syscall
	
	lw $t1,0($sp)
	addi $sp,$sp,4
	
	addi $a0,$0,2000
	addi $v0,$0,32
	syscall

	j menu   
       
YC8:
        la $a0,strResult			
	li $v0, 4
	syscall

        add $a0,$t0,$0

        jal TwoNearestLeapYear      

	add $a0, $v0, $0
	li $v0,1
	syscall

	.data 
	strAnd: .asciiz " and "
	.text 
	la $a0,strAnd
	li $v0,4
	syscall

	add $a0, $v1, $0
	li $v0,1
	syscall

        addi $a0,$0,2000		#sleep 2s
	li $v0,32
	syscall

        j menu 
YC9:     	
	jal XuLyFile
                                            
Exit:
        addi $v0,$0,10
        syscall
        
#############################################################
#	int Day(char*DD/MM/YYYY)
#input: DD/MM/YYYY
#output: DD
Day:
	.data 
	day: .space 10	
	.text 
	addi $sp,$sp,-16
	sw $a0, 12($sp)
	sw $ra, 8($sp)
	sw $t0,	4($sp)
	sw $t1, 0($sp)

	add $t0, $a0,$0

	la $v0,day

	lb $t1,($t0)
	sb $t1,($v0)

	lb $t1,1($t0)
	sb $t1,1($v0)

	add $a0,$v0,$0

	jal atoi

	lw $t1,0($sp)
	lw $t0,4($sp)
	lw $ra,8($sp)
	lw $a0,12($sp)
	addi $sp,$sp,16
	jr $ra

#################################################################
#	int Month(char* DD/MM/YYYY)
#input: DD/MM/YYYY
#output: MM
Month:
	.data 
	month: .space 10	
	.text 
	addi $sp,$sp,-16                      
	sw $a0, 12($sp)
	sw $ra, 8($sp)
	sw $t0,	4($sp)
	sw $t1, 0($sp)

	add $t0, $a0,$0

	la $v0,month

	lb $t1,3($t0)
	sb $t1,($v0)

	lb $t1,4($t0)
	sb $t1,1($v0)

	add $a0,$v0,$0

	jal atoi

	lw $t1,0($sp)                            
	lw $t0,4($sp)
	lw $ra,8($sp)
	lw $a0,12($sp)
	addi $sp,$sp,16
	jr $ra

####################################################################
#	int Year(char* DD/MM/YYYY)
#input: DD/MM/YYYY
#output: YY
Year:
	.data 
	year: .space 10
	
	.text 
	addi $sp,$sp,-24
	sw $t3, 20($sp)
	sw $t2, 16($sp)
	sw $a0, 12($sp)
	sw $ra, 8($sp)
	sw $t0,	4($sp)
	sw $t1, 0($sp)

	add $t2, $a0,$0

	la $a0,year

	add $t0, $a0,$0

	addi $t3,$0,10

	addi $t2, $t2,6
forYEAR:
	lb $t1,($t2)
	beq $t1,$0,outforYEAR
	beq $t1,$t3,outforYEAR
	sb $t1,($a0)
	addi $t2, $t2,1
	addi $a0, $a0,1
	j forYEAR
outforYEAR:
	sb $0,($a0)
	add $a0,$t0,$0	
	jal atoi

	lw $t1,0($sp)
	lw $t0,4($sp)
	lw $ra,8($sp)
	lw $a0,12($sp)
	lw $t2,16($sp)
	lw $t3, 20($sp)
	addi $sp,$sp,24

	jr $ra

#################################################################
#	int atoi(char*)
#input: $a0 chuoi muon chuyen
#output: $v0 giá tri nguyen cua chuoi so
atoi:
	# Backup to stack
	addiu $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)

	li $v0, 0				# result = 0
	ori $t0, $a0, 0				# it = num
	lb $t1, 0($t0)				# c = *it

atoi_forloop:
	slti $t3, $t1, 48			# if (c < 48)
	bne $t3, $0, atoi_endfunc		#	jump to atoi_error
	slti $t3, $t1, 58			# if (c >= 58)
	beq $t3, $0, atoi_endfunc		#	jump to atoi_error
	addi $t1, $t1, -48                      # $t1 = $t1 - 48 : char to int

	ori $t3, $0, 10				# temp = 10
	mult $v0, $t3				# result = ...
	mflo $v0				# 	result * temp
	add $v0, $v0, $t1			# result += 1
	addi $t0, $t0, 1			# ++it
	lb $t1, 0($t0)				# c = *it
	j atoi_forloop

atoi_endfunc:
	# Restore the stack
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	addiu $sp, $sp, 12
	jr $ra
        
#############################################################
#	char* input(char*)
#input: $a0 address
#output: $v0 DD/MM/YYYY

input:
    .data
	Nhaplai : .asciiz "Nhap sai vui long nhap lai!\n"
	NhapNgay : .asciiz "\nNhap ngay (DAY): "
	NhapThang : .asciiz "Nhap thang (MONTH): "
	NhapNam : .asciiz "Nhap nam (YEAR): "
	temp : .space 40

    .text
        addi $sp, $sp, -44
	sw $t5, 40($sp)
	sw $t4, 36($sp)
	sw $t3, 32($sp)
	sw $t2, 28($sp)
	sw $t1, 24($sp)
	sw $t0, 20($sp)
	sw $a3, 16($sp)
	sw $a0, 12($sp)
	sw $a1, 8($sp)
	sw $a2, 4($sp)
	sw $ra, ($sp)

        #Ngay
        inputNgay :
        	la $a0, NhapNgay
        	li $v0, 4
        	syscall
        
        	la $a0, temp
        	li $a1, 10
        	li $v0, 8  #8 is to read_string
        	syscall
        
        	add $t2, $a0, $0 #$t2: Day
        
        checkDayInput:
                # Lay tung ki tu trong chuoi nhap vao $t0
        	lb $t0, ($a0)
        
                # Neu so ki tu da dung thi thoat khoi vong lap
        	addi $t3, $0, 10
        	beq $t0, $t3, outputNgay
        
                #Kiem tra ma ASCII cua ki tu do co hop le chua
        	slti $t1, $t0, 48
        	bne $t1, $0, ErrorInNgay		#if (t0 < 48) != 0 -> false
        	slti $t1, $t0, 58
        	beq $t1, $0, ErrorInNgay		#if (t0 < 58) == 0 -> false
        
                #Den ki tu tiep theo
        	addi $a0, $a0, 1
        	j checkDayInput
        
        ErrorInNgay :
        	la $a0, Nhaplai
        	li $v0, 4
        	syscall
        
        	j inputNgay
        
        outputNgay :
        	add $a0, $t2, $0
        	jal atoi
        	add $t4, $v0, $0 #$t4: int(Day)
        
        #Thang
        inputThang :
        	la $a0, NhapThang
        	li $v0, 4
        	syscall
        
        	la $a0, temp
        	li $a1, 10
        	li $v0, 8
        	syscall
        
        	add $t2, $a0, $0
        
        checkMonthInput:
        	lb $t0, ($a0)
        
        	addi $t3, $0, 10
        	beq $t0, $t3, outputThang
           
        	slti $t1, $t0, 48
        	bne $t1, $0, ErrorInThang		#if (t0 < 48) != 0 -> false
        	slti $t1, $t0, 58
        	beq $t1, $0, ErrorInThang		#if (t0 < 58) == 0 -> false
        	
                addi $a0, $a0, 1
        	j checkMonthInput
        
        ErrorInThang :
        	la $a0, Nhaplai
        	li $v0, 4
        	syscall
        	j inputThang
        
        outputThang :
        	add $a0, $t2, $0
        	jal atoi
        	add $t5, $v0, $0 #$t5: int(Month)
        
        #Nam
        inputNam :
        	la $a0, NhapNam
        	li $v0, 4
        	syscall
        
        	la $a0, temp
        	li $a1, 10
        	li $v0, 8
        	syscall
        
        	add $t2, $a0, $0
        
        checkYearInput :
        	lb $t0, ($a0)
        
        	addi $t3, $0, 10
        	beq $t0, $t3, outputNam
        
        	slti $t1, $t0, 48
        	bne $t1, $0, ErrorInNam			#if (t0 < 48) != 0 -> false
        
        	slti $t1, $t0, 58
        	beq $t1, $0, ErrorInNam			#if (t0 < 58) == 0 -> false
        	
                addi $a0, $a0, 1
        	j checkYearInput
        
        ErrorInNam :
        	la $a0, Nhaplai
        	li $v0, 4
        	syscall
        	j inputNam
        
        outputNam :
        	add $a0, $t2, $0
        	jal atoi
        
        	
                lw $a3, 12($sp)
        	add $a0, $t4, $0
        	add $a1, $t5, $0
        	add $a2, $v0, $0
        
        	jal CheckDate
        
        	beq $v0, $0, ErrorInNgay
                
                #luu vao Date
        	jal Date
        	
        	lw $ra, ($sp)
        	lw $a2, 4($sp)
        	lw $a1, 8($sp)
        	lw $a0, 12($sp)
        	lw $t0, 20($sp)
        	lw $t1, 24($sp)
        	lw $t2, 28($sp)
        	lw $t3, 32($sp)
        	lw $t4, 36($sp)
        	lw $t5, 40($sp)
        	addi $sp, $sp, 44
        
        	jr $ra

#############################################################
#	int CheckDate(int day,int month,int year)
#input: $a0 day. $a1 month. $a2 year
#output: 1 if valid date else 0

CheckDate:
	addi $sp,$sp,-16
	sw $a0, 12($sp)			#store
	sw $ra, 8($sp)
	sw $t0,	4($sp)
	sw $t1, 0($sp)

	slt $t0,$0,$a0
	beq $t0,$0,falseDate		# if (0 < day) == 0 -> false

	slt $t0,$0,$a1
	beq $t0,$0,falseDate		# if (0 < month) == 0 -> false

	slti $t0,$a1,13
	beq $t0,$0,falseDate		# if (month < 13) == 0 -> false

	add $t1,$a0,$0			# t1 = day
	add $a0,$0,$a2			# a0 = a2 (year)
	jal DayOfMonth
	
        slt $t0,$v0,$t1
	bne $t0,$0,falseDate		# if (DOM < day) != 0 -> false

	addi $v0,$0,1
	j end_check

falseDate:
	addi $v0,$0,0

end_check:
	lw $t1,0($sp)			#restore
	lw $t0,4($sp)
	lw $ra,8($sp)
	lw $a0, 12($sp)	
	addi $sp,$sp,16
	
	jr $ra
	
#############################################################
#	int DayOfMouth(int year,int month)
#input: $a0 YYYY $a1 MM
#output: $v0 : so ngay cua thang

DayOfMonth:
	addi $sp,$sp,-8
	sw $ra,4($sp)

	beq $a1,1, Day31
	beq $a1,2, Orther
	beq $a1,3, Day31
	beq $a1,4, Day30
	beq $a1,5, Day31
	beq $a1,6, Day30
	beq $a1,7, Day31
	beq $a1,8, Day31
	beq $a1,9, Day30
	beq $a1,10, Day31
	beq $a1,11, Day30
	beq $a1,12, Day31

Day31:
	addi $v0,$0,31
	j end_DayOfMonth
Day30:
	addi $v0,$0,30
	j end_DayOfMonth

Orther:
	jal isLeapYear
	addi $v0,$v0,28

end_DayOfMonth:
	lw $ra,4($sp)
	addi $sp,$sp,8

	jr $ra

#############################################################
#	char* Date(int day,int month,int year,char* date)
#input: $a0 day, $a1 month, $a2 year, $a3 address
#output: $v0 DD/MM/YYYY or "\0" if not is date
Date:
	addi $sp,$sp,-32
        sw $a2,28($sp)
	sw $a1,24($sp)
	sw $a0,20($sp)		#store
        sw $t3,16($sp)
	sw $t2,12($sp)
	sw $ra,8($sp)
	sw $t0,4($sp)
	sw $t1,0($sp)

	li $t0,10 #so chia
	addi $t2,$0,47 #'/'

	div $a0,$t0
	mflo $t1
	addi $t1,$t1,48
	sb $t1,($a3)
	mfhi $t1
	addi $t1,$t1,48
	sb $t1,1($a3)
	sb $t2,2($a3) #DD/

	div $a1,$t0
	mflo $t1
	addi $t1,$t1,48
	sb $t1,3($a3)
	mfhi $t1
	addi $t1,$t1,48
	sb $t1,4($a3)
	sb $t2,5($a3) #DD/MM/

        li $t0,1000 #so chia
        div $a2,$t0
	mflo $t1
        mfhi $t3
	addi $t1,$t1,48
        sb $t1,6($a3)
        li $t0,100  #so chia
        div $t3,$t0
	mflo $t1
        mfhi $t3
	addi $t1,$t1,48
        sb $t1,7($a3)
        li $t0,10   #so chia
        div $t3,$t0
	mflo $t1
        mfhi $t3
	addi $t1,$t1,48
	addi $t3,$t3,48
        sb $t1,8($a3)
        sb $t3,9($a3) #DD/MM/YYYY
        sb $0,10($a3) # ki tu null de ket thuc chuoi
     
        move $v0,$a3

exit_Date:
	lw $t1,0($sp)				#restore
	lw $t0,4($sp)
	lw $ra,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $a0,20($sp)	
	lw $a1,24($sp)	
	lw $a2,28($sp)	
	addi $sp,$sp,32
	
	jr $ra

#############################################################
#char* Convert(char* dd/mm/yy, char A/B/C)
#output: MM/DD/YYYY if A
#	 Month DD, YYYY if B
#	 DD Month, YYYY if C
Convert:
	addi $sp,$sp,-28
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $t0,12($sp)
	sw $t1,16($sp)
	sw $t2,20($sp)
	sw $t3,24($sp)
	
	addi $t0,$0,65
	beq $a1,$t0,C2A
	
	addi $t0,$0,66
	beq $a1,$t0,C2B
	
	addi $t0,$0,67
	beq $a1,$t0,C2C

C2A:
.data 
	adate: .space 30
.text	
	la $v0,adate

	# Sao chep Ngay va Thang tu Time nhap ban dau
        # Hoan vi ngay va thang voi nhau
        
	lb $t0,3($a0)
	sb $t0,0($v0)
	
	lb $t0,4($a0)
	sb $t0,1($v0)
	
	lb $t0,2($a0)
	sb $t0,2($v0)
	
	lb $t0,0($a0)
	sb $t0,3($v0)
	
	lb $t0,1($a0)
	sb $t0,4($v0)
	
	lb $t0,5($a0)
	sb $t0,5($v0)
	
	add $t1,$v0,$0
	addi $a0,$a0,6
	addi $v0,$v0,6
	j getYear
C2B:
.data 
	bdate: .space 30
.text	
	jal Month
	add $a0,$v0,$0
	jal textMonth
	add $t0,$v0,$0
	
	la $v0,bdate
	add $t1,$v0,$0
loop_C2B:
	lb $t2,0($t0)
	beq $t2,$0,out_loop_C2B
	sb $t2,0($v0)
	addi $t0,$t0,1
	addi $v0,$v0,1
	j loop_C2B
out_loop_C2B:
	lw $a0,4($sp)
	
	addi $t3,$0,32
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	lb $t3,0($a0)
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	lb $t3,1($a0)
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	addi $t3,$0,44 #them dau phay ','
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	addi $t3,$0,32 #them khoang trong ' '
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	addi $a0,$a0,6
	j getYear	
C2C:
.data 
	cdate: .space 30
.text	
	jal Month
	add $a0,$v0,$0
	jal textMonth
	add $t0,$v0,$0
	
	la $v0,cdate
	add $t1,$v0,$0
	
	lw $a0,4($sp)
	lb $t2,0($a0)
	sb $t2,0($v0)
	
	lb $t2,1($a0)
	sb $t2,1($v0)
	
	addi $t2,$0,32
	sb $t2,2($v0)
	
	addi $v0,$v0,3
loop_C2C:
	lb $t2,0($t0)
	beq $t2,$0,out_loop_C2C
	sb $t2,0($v0)
	addi $t0,$t0,1
	addi $v0,$v0,1
	j loop_C2C

out_loop_C2C:
	addi $t2,$0,44  #them dau phay ','
	sb $t2,0($v0)
	addi $v0,$v0,1
	addi $t2,$0,32 #them khoang trong ' '
	sb $t2,0($v0)
	addi $v0,$v0,1
	addi $a0,$a0,6

getYear:
	lb $t2,0($a0)
	beq $t2,$0,end_Convert
	sb $t2,0($v0)
	addi $v0,$v0,1
	addi $a0,$a0,1
	j getYear

end_Convert:
	sb $0,0($v0)
	add $v0,$t1,$0

	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $t0,12($sp)
	lw $t1,16($sp)
	lw $t2,20($sp)
	lw $t3,24($sp)
	addi $sp,$sp,28
	jr $ra

#############################################################
#	char* textMonth(int)
#input:$a0 num from 1 to 12
#output: $v0 English of this mouth

textMonth:
    .data
        Month_1: .asciiz "Jannuary"
	Month_2: .asciiz "February"
	Month_3: .asciiz "March"
	Month_4: .asciiz "April"
	Month_5: .asciiz "May"
	Month_6: .asciiz "June"
	Month_7: .asciiz "July"
	Month_8: .asciiz "August"
	Month_9: .asciiz "September"
	Month_10: .asciiz "October"
	Month_11: .asciiz "November"
	Month_12: .asciiz "December"
    .text 
        addi $sp,$sp,-4

	beq $v0,1,isT1
	beq $v0,2,isT2
	beq $v0,3,isT3
	beq $v0,4,isT4
	beq $v0,5,isT5
	beq $v0,6,isT6
	beq $v0,7,isT7
	beq $v0,8,isT8
	beq $v0,9,isT9
	beq $v0,10,isT10
	beq $v0,11,isT11
	beq $v0,12,isT12
	
isT1:
	la $v0,Month_1
	j End_Month
isT2:
	la $v0,Month_2
	j End_Month
isT3:
	la $v0,Month_3
	j End_Month
isT4:
	la $v0,Month_4
	j End_Month
isT5:
	la $v0,Month_5
	j End_Month
isT6:
	la $v0,Month_6
	j End_Month
isT7:
	la $v0,Month_7
	j End_Month
isT8:
	la $v0,Month_8
	j End_Month
isT9:
	la $v0,Month_9
	j End_Month
isT10:
	la $v0,Month_10
	j End_Month
isT11:
	la $v0,Month_11
	j End_Month
isT12:
	la $v0,Month_12

End_Month:
	addi $sp,$sp,4
	
	jr $ra

#############################################################
#	int isLeapYear(int year)
#input: YYYY
#output: 1 if leapyear else 0
isLeapYear:
	addi $sp,$sp,-12
	sw $a0,8($sp)
	sw $t0,	4($sp)
	sw $t1, 0($sp)
	
	addi $t0,$0,400
	div $a0,$t0
	mfhi $t1
	beq $t1,$0,true

	addi $t0,$0,4
	div $a0,$t0
	mfhi $t1
	bne $t1,$0,false

	addi $t0,$0,100
	div $a0,$t0
	mfhi $t1
	beq $t1,$0,false
true:
	addi $v0,$0,1
	j end_isLeapYear
false:
	addi $v0,$0,0

end_isLeapYear:
	lw $t1,0($sp)
	lw $t0,4($sp)
	lw $a0,8($sp)
	addi $sp,$sp,12

	jr $ra

########################################################
#	int 	LeapYear(char* date)
#input: DD/MM/YYYY <- a0
#output: 1 if leapyear else 0 -> v0
LeapYear:
	addi $sp,$sp,-8
	sw $ra, 4($sp)
	sw $a0, 0($sp)

	jal Year
	add $a0,$v0,$0
	
	jal isLeapYear

	lw $ra,4($sp)
	lw $a0, ($sp)
	addi $sp,$sp,8
	jr $ra

#############################################################
#	char* WeekDay(char*)
# input: $a0 DD/MM/YYYY
# $t0 day, $t1 month, $t2 year
# output: $v0 day of week
WeekDay:
    .data
        T2: .asciiz"Thu hai\n"
	T3: .asciiz"Thu ba\n"
	T4: .asciiz"Thu tu \n"
	T5: .asciiz"Thu nam\n"
	T6: .asciiz"Thu sau \n"
	T7: .asciiz"Thu bay \n"
	CN: .asciiz"Chu Nhat \n"
    .text
	addi $sp,$sp,-20		#store
	sw $t3, 16($sp)
	sw $t2, 12($sp)
	sw $ra, 8($sp)
	sw $t0,	4($sp)
	sw $t1, 0($sp)

	jal Day
	add $t0,$v0,$0			

	jal Month
	add $t1,$v0,$0			

	jal Year
	add $t2,$v0,$0			

	slti $t3,$t1,3
	beq $t3,$0,LoopWeek		# if (month<3)
	addi $t1,$t1,12			# month+=12
	addi $t2,$t2,-1			# year--

LoopWeek:
	add $t0,$t0,$t1
	add $t0,$t0,$t1			# t0 = 2*t1 + t0
	
	addi $t1,$t1,1
	add $t3,$0,$t1
	add $t3,$t3,$t1
	add $t3,$t3,$t1			# t3 = 3*t1 + 3

	addi $t1,$0,5
	div $t3,$t1
	mflo $t3			# t3 = t3 / 5

	add $t0,$t0,$t3			# t0 = t0 + t3
	add $t0,$t0,$t2			# t0 = t0 + t2

	addi $t1,$0,4
	div $t2,$t1
	mflo $t2 			# t2 = t2 / 4

	add $t0,$t0,$t2			# t0 = t0 + t2

        # t0 = ( t0 + 2*t1 + (3*t1 + 3)/5 + t2 + t2/4)
	addi $t1,$0,7
	div $t0,$t1
	mfhi $t0			# t0 = t0 % 7
	
	#case switch
	beq $t0,0,isCN
	beq $t0,1,isTh2
	beq $t0,2,isTh3
	beq $t0,3,isTh4
	beq $t0,4,isTh5
	beq $t0,5,isTh6
	beq $t0,6,isTh7
isCN:
	la $v0,CN
	j endD
isTh2:
	la $v0,T2
	j endD
isTh3:
	la $v0,T3
	j endD
isTh4:
	la $v0,T4
	j endD
isTh5:
	la $v0,T5
	j endD
isTh6:
	la $v0,T6
	j endD
isTh7:
	la $v0,T7
	j endD
endD:
	lw $t1,0($sp)				#restore
	lw $t0,4($sp)
	lw $ra,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	addi $sp,$sp,20
	
	jr $ra

#############################################################
#	int FullDate(char*)
#input: DD/MM/YYYY 
#$t0 day, $t1 month, $t2 year
#output: khoang cach tu time1 den 1/1/1
#Su dung cong thuc: khoang cach= year*365 + year/4 - year/100 + year/400 + (153*month - 457)/5 + day -306

FullDate:
	addi $sp,$sp,-28       #store
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
	sw $t3,20($sp)
	sw $ra,24($sp)
	 
	jal Day
	move $t0,$v0
	jal Month
	move $t1,$v0
	lw $a0,0($sp)
	jal Year
	move $t2,$v0

	move $a1,$t2	   #$a1 = year
	
	li $t3, 365
	mult $a1,$t3
	mflo $a1	   #$a1 = year*365

	li $t3, 4
	div $t2,$t3
	mflo $t3	   #$t3 = year/4
	
	add $a1,$a1,$t3    #$a1 = year*365 + year/4
	
	li $t3, -100
	div $t2,$t3
	mflo $t3	      #$t3 = -year/100
	
	add $a1,$a1,$t3       #$a1 = year*365+year/4-year/100

	li $t3, 400
	div $t2,$t3
	mflo $t3	      #$t3 = year/400
	
	add $a1,$a1,$t3       #$a1 = year*365+year/4-year/100+year/400
	
	li $t3,153
	mult $t1,$t3
	mflo $t1 	     #$t1 = 153*month
	addi $t1,$t1,-457    #$t1 = 153*month - 457

	li $t3,5
	div $t1, $t3
	mflo $t1	    #$t1 = (153*month - 457)/5

	add $a1,$a1,$t1	    #$a1 = year*365+year/4-year/100+year/400+(153*month - 457)/5
	add $a1,$a1,$t0	    #$a1 = year*365+year/4-year/100+year/400+(153*month - 457)/5 + day

	addi $a1, $a1,-306  #$a1 = year*365+year/4-year/100+year/400+(153*month - 457)/5 + day

	move $v0,$a1
	
	#restore
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	lw $t3,20($sp)
	lw $ra,24($sp)
	addi $sp,$sp,28
	
	jr $ra

########################################################
#	char* CanChi(char* date)
#input:  a0: YYYY
#output: can chi cua nam ->v0

Can:
        .data 
        can1: .asciiz "Giap "
        can2: .asciiz "At "
        can3: .asciiz "Binh " 
        can4: .asciiz "Dinh "
        can5: .asciiz "Mau "
        can6: .asciiz "Ky "
        can7: .asciiz "Canh "
        can8: .asciiz "Tan "  
        can9: .asciiz "Nham "
        can10: .asciiz "Quy "
       
	.text
        addi $sp,$sp,-16        #store
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $a0,12($sp)

	jal Year
	add $a0,$v0,$0

        addi $t0, $0, 10 	# Gan bien tam t0 = 10
        addi $t1,$a0,6		# Year=Year+6
        div $t1, $t0		
        mfhi $t1		# $t1 = (Year +6) mod 10
        
	beq $t1,0,IsCan1
	beq $t1,1,IsCan2
	beq $t1,2,IsCan3
	beq $t1,3,IsCan4
	beq $t1,4,IsCan5
	beq $t1,5,IsCan6
	beq $t1,6,IsCan7
	beq $t1,7,IsCan8
	beq $t1,8,IsCan9
	beq $t1,9,IsCan10

IsCan1:
	la $v0,can1
	j End_Can
IsCan2:
	la $v0,can2
	j End_Can
IsCan3:
	la $v0,can3
	j End_Can
IsCan4:
	la $v0,can4
	j End_Can
IsCan5:
	la $v0,can5
	j End_Can
IsCan6:
	la $v0,can6
	j End_Can
IsCan7:
	la $v0,can7
	j End_Can
IsCan8:
	la $v0,can8
	j End_Can
IsCan9:
	la $v0,can9
	j End_Can
IsCan10:
	la $v0,can10
	j End_Can
End_Can:
        lw $ra,0($sp)   #restore
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $a0,12($sp)
	addi $sp,$sp,16
	
	jr $ra
###############################################################

Chi:
     .data
        chi1: .asciiz "Ti \n"
        chi2: .asciiz "Suu \n"
        chi3: .asciiz "Dan \n"
        chi4: .asciiz "Meo \n"
        chi5: .asciiz "Thin \n"
        chi6: .asciiz "Ty \n"
        chi7: .asciiz "Ngo \n"
        chi8: .asciiz "Mui \n"
        chi9: .asciiz "Than \n"
        chi10: .asciiz "Dau \n"
        chi11: .asciiz "Tuat \n"
        chi12: .asciiz "Hoi \n"
    .text 
        addi $sp,$sp,-16        #store
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $a0,12($sp)

	jal Year
	add $a0,$v0,$0

        addi $t0, $0, 12 	# Gan bien tam t0 = 12
        addi $t1,$a0,8		# Year=Year+8
        div $t1, $t0		
        mfhi $t1		# $t1 = (Year +8) mod 12
        
	beq $t1,0,IsChi1
	beq $t1,1,IsChi2
	beq $t1,2,IsChi3
	beq $t1,3,IsChi4
	beq $t1,4,IsChi5
	beq $t1,5,IsChi6
	beq $t1,6,IsChi7
	beq $t1,7,IsChi8
	beq $t1,8,IsChi9
	beq $t1,9,IsChi10
	beq $t1,10,IsChi11
	beq $t1,11,IsChi12
	
IsChi1:
	la $v0,chi1
	j End_Chi
IsChi2:
	la $v0,chi2
	j End_Chi
IsChi3:
	la $v0,chi3
	j End_Chi
IsChi4:
	la $v0,chi4
	j End_Chi
IsChi5:
	la $v0,chi5
	j End_Chi
IsChi6:
	la $v0,chi6
	j End_Chi
IsChi7:
	la $v0,chi7
	j End_Chi
IsChi8:
	la $v0,chi8
	j End_Chi
IsChi9:
	la $v0,chi9
	j End_Chi
IsChi10:
	la $v0,chi10
	j End_Chi
IsChi11:
	la $v0,chi11
	j End_Chi
IsChi12:
	la $v0,chi12

End_Chi:
	lw $ra,0($sp)      #restore
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $a0,12($sp)
	addi $sp,$sp,16
	
	jr $ra  

#############################################################
#	int DateDiff(char* Date1,char* Dte2)
#output: abs(Date1-Date2)
#result= asb(FullDate(char* Date1) - FullDate(char* Date2))
DateDiff:
        addi $sp,$sp,-24    #store
	sw $s0,($sp)
	sw $s1,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
	sw $ra,20($sp)

        #Tinh FullTime Date1
	move $s0,$a0            #luu Date1 vao $s0
	move $a0,$s0
	jal FullDate            #tinh FullTime Date1
	move $t1,$v0            #luu ket qua vao $t1

	#Tinh FullTime Date2
	move $s1,$a1            #luu Date2 vao $s1
	move $a0,$s1
	jal FullDate            #tinh FullTime Date2
	move $t2,$v0            #luu ket qua vao $t2

	#Tinh khoang cach giua TIME1 va TIME2

	slt $t0,$t1,$t2  
	beq $t0,$0,if_DateDiff     # if(t1 > t2)

	sub $t0,$t2,$t1
	j End_DateDiff

if_DateDiff:
	sub $t0,$t1,$t2

End_DateDiff:
	move $v0,$t0
 
	lw $s0,($sp)	#restore
	lw $s1,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	lw $ra,20($sp)
	add $sp,$sp,24

	jr $ra
 
#############################################################
#        int TwoNearestLeapYear(char*)
#input: $a0 DD/MM/YYYY
#output: $v0: Year1 < Selected Year, $v1: Year2 > Selected Year
TwoNearestLeapYear:
	addi $sp,$sp,-24
	sw $a3,20($sp)
	sw $a2,16($sp)
	sw $a1,12($sp)
	sw $a0, 8($sp)					#store
	sw $ra, 4($sp)
	sw $t0,	0($sp)
.data 
	tempyear: .space 40
.text 
	jal Year
	addi $a2, $v0,0    #a2: Year
        sw $a2,16($sp)
        
	addi $a0,$0,1      #a0 bat dau tu 1
	addi $a1,$0,1      #a1 bat dau tu 1
	la $a3,tempyear

forLY1:
        addi $a2,$a2,-1            #year--
	jal Date
	add $a0,$v0,$0
	jal LeapYear
	bne $v0,$0,forLY2      #neu la nam nhuan thi tim year2
	addi $a0,$0,1
	j forLY1

forLY2:
	add $t0,$a2,$0             # t0: nam nhuan ben trai
        lw $a2,16($sp)
forLY2Next:        
	addi $a2,$a2,1             # year+=1
	jal Date
	add $a0,$v0,$0
	jal LeapYear
	bne $v0,$0, exitTNLY       #neu la nam nhuan thi xuat ra 
	j forLY2Next

exitTNLY:
	add $v0,$t0,$0
	add $v1,$a2,$0

	lw $t0, 0($sp)					#restore
	lw $ra, 4($sp)	
	lw $a0, 8($sp)
	lw $a1,12($sp)
	lw $a2,16($sp)
	lw $a3,20($sp)
	addi $sp,$sp,24
	
	jr $ra

###############################################################
XuLyFile:     	
.data
        # Data for File
	time1k_hople:	.asciiz "Chuoi Time_1 khong hop le\n"
	time2k_hople:	.asciiz "Chuoi Time_2 khong hop le\n"
	time12k_hople:	.asciiz	"Chuoi Time_1 va Time_2 khong hop le\n"
	daghidulieu:	.asciiz "Da ghi du lieu vao File\n"
	Fnamnhuan:	.asciiz " La Nam Nhuan\n"
	Fnamthuong:	.asciiz " La Nam Thuong\n"
	Fkhoangcach:	.asciiz	"Khoang cach tu ngay 01/01/0001 den ngay "
	Fkhoangcachtu: .asciiz "Khoang cach tu ngay "
	Fdenngay:	.asciiz	" den ngay "
	Fngay:	.asciiz	" ngay\n"
	Flanam:	.asciiz " la nam "
	F2namnhuan:	.asciiz "Hai nam nhuan gan nhat voi nam "
	Fva:		.asciiz	" va "
	lathu:		.asciiz " la "
	Ftemp: 	.space 40
	Ftemp2: 	.space 40
	Input: 		.asciiz "input.txt"
	Output:		.asciiz "output.txt"
	FileWords: 	.space 1024
	str_data_end:	.asciiz ""
	CheckF:	.word 0
	wcau1:		.asciiz "1. "
	wcau2a:		.asciiz "\n2A. "
	wcau2b:		.asciiz "\n2B. "
	wcau2c:		.asciiz "\n2C. "
	wcau3:		.asciiz "\n3. "
	wcau4:		.asciiz "4. "
	wcau5:		.asciiz "5. "
	wcau6:		.asciiz "6. "
	wcau7:		.asciiz "7. "
	wcau8:		.asciiz "8. "
.text  
DocFile:     
#OPEN TO READ 
	li $v0,13           	# open_File syscall code = 13
    	la $a0,Input     	# get the File name
    	li $a1,0           	# File flag = read (0)
    	li $a2,0
	syscall
    	move $s0,$v0        	# save the File descriptor. $s0 = File
    
	#read the File
	li $v0,14		# read_File syscall code = 14
	move $a0,$s0		# File descriptor
	la $a1,FileWords  	# The buffer that holds the string of the WHOLE File
	la $a2,1024		# hardcoded buffer length
    	move $t0,$a0
	syscall 

	#close
	li $v0,16       # system call for close File
	move $a0,$s0      # File descriptor to close
	syscall            # close File

	#batdau doc File va luu vao time1, time2
	la $s5 time1
        li $t1,0
	li $t3,0
loadFile:
   	lbu 	$t1,($a1)           # doc 1 byte tai $a1 vao v0, con tro o dau tien dich dan
   	addiu 	$a1,$a1,1         # value  a1[i++]
   	beq	$t1,$0,ketthucload
   	li	$t2,'\n'
   	beq	$t2,$t1,doitime
   	li 	$t2,' '
   	bne	$t1,$t2,ct
   	li 	$t1,'/'
ct:
   	sb	$t1,($s5)
   	addiu	$s5,$s5,1
   	
   	j loadFile
doitime:
 	la $s5 time2
 	j loadFile
 
ketthucload:
#OPEN output File to write
	li $v0, 13
    	la $a0, Output
   	li $a1, 1
    	li $a2, 0
   	syscall  # File descriptor gets returned in $v0
   	move	$t5 $v0	
   
#Check time1 co dung dinh dang hay khong
	la	$a0 time1
	jal Year
	move $a2,$v0
	la	$a0 time1
	jal Month
	move	$a1,$v0
	la	$a0 time1
	jal Day
	move	$a0,$v0
	jal CheckDate #v0 = 1 neu dung or = 0 neu sai
	la	$a0,time1
	jal	F_Check__Alpha
	move $t1 $v0

#Check time2 co dung dinh dang hay khong
	la	$a0 time2
	jal Year
	
	move $a2,$v0
	la	$a0 time2
	jal Month
	move	$a1,$v0
	la	$a0 time2
	jal Day
	move	$a0,$v0
	jal CheckDate #v0 = 1 neu dung or = 0 neu sai
	la	$a0,time2
	jal	F_Check__Alpha
	move $t2 $v0
	beqz	$t1,time1sai
	beqz	$t2,time2sai
	j	Out_File
time1sai:
	beqz	$t2,ca2sai
	move $a0, $t5  # Syscall 15 requieres File descriptor in $a0
    	la $a1, time1k_hople
   	jal Write_File
	j	endF

time2sai:
	move $a0, $t5  # Syscall 15 requieres File descriptor in $a0
    	la $a1, time2k_hople
   	jal Write_File
	j	endF	

ca2sai:
	move $a0, $t5  # Syscall 15 requieres File descriptor in $a0
    	la $a1, time12k_hople
   	jal Write_File

	j endF
F_Check__Alpha:
	addi $sp,$sp,-20
	sw $t2,16($sp)
	sw $a0, 12($sp)			#store
	sw $ra, 8($sp)
	sw $t0,	4($sp)
	sw $t1, 0($sp)
	li	$t1,9
	Check_Alpha:
	addi	$t1,$t1,-1
	lbu 	$t0,($a0)           # doc 1 byte tai $a3 vao t0
   	addiu 	$a0,$a0,1         # value  a1[i++]	
	li 	$t2,'/'
   	beq	$t0,$t2,Check_Alpha
   	li	$t2, '0'
	blt 	$t0, $t2, falseDateF  # char < '0'
	li	$t2, '9'
        bgt 	$t0, $t2, falseDateF  # char > '9'
	bgez	$t1,Check_Alpha	

end_CheckdateF:
	lw $t1,0($sp)			#restore
	lw $t0,4($sp)
	lw $ra,8($sp)
	lw $a0,12($sp)	
	sw $t2,16($sp)
	addi $sp,$sp,20
	jr $ra

falseDateF:
	li	$v0,0
	j 	end_CheckdateF

endF:
	#in ra cau da ghi du lieu vao File
	la	$a0,daghidulieu
	li	$v0,4
	syscall  

	#close File  
	li $v0, 16 
   	syscall	
	
	j Exit     
########################################################	
Out_File:
	#in yc1 vao output
	#1
	move	$a0,$t5
	la	$a1,wcau1
	jal Write_File
	la	$a1,time1
	jal Write_File
        
        #2
	#2A
	move	$a0,$t5
	la	$a1,wcau2a
	jal Write_File
	la $a0 time1
	addi $a1,$0,65  ### gan gia tri choose
        jal Convert
	move	$a0,$t5
	move	$a1,$v0
	jal Write_File
	#2B
	move	$a0,$t5
	la	$a1,wcau2b
	jal Write_File
	la $a0 time1
	addi $a1,$0,66  ### gan gia tri choose
        jal Convert
	move	$a0,$t5
	move	$a1,$v0
	jal Write_File
	#2C
	move	$a0,$t5
	la	$a1,wcau2c
	jal Write_File
	la $a0 time1
	addi $a1,$0,67  ### gan gia tri choose
        jal Convert
	move	$a0,$t5
	move	$a1,$v0
	jal Write_File
	
	#3
	move	$a0,$t5
	la	$a1,wcau3
	jal Write_File
	la	$a0 time1
	la	$a1 Ftemp
	lb	$t1 6($a0)
	sb	$t1 0($a1)
	lb	$t1 7($a0)
	sb	$t1 1($a1)
	lb	$t1 8($a0)
	sb	$t1 2($a1)
	lb	$t1 9($a0)
	sb	$t1 3($a1)
	move	$t3 $a1	
	move	$a0,$t5
	jal Write_File
	
	la	$a0 time1
	jal 	LeapYear
	
	bgtz	$v0,Fnnhuan
	move	$a0,$t5
	la	$a1,Fnamthuong
	jal Write_File
	j outin4
Fnnhuan:
	
	move	$a0,$t5
	la	$a1,Fnamnhuan
	jal Write_File
	
	
	#4
outin4:
	move	$a0,$t5
	la	$a1,wcau4
	jal Write_File
	la	$a1,time1
	li	$a2,10
	li	$v0,15
	syscall

	la	$a1,lathu
	jal Write_File
	la	$a0,time1

	jal WeekDay
	move	$a1,$v0
	move	$a0 $t5
	jal Write_File
	
	#5
	move	$a0,$t5
	la	$a1,wcau5
	jal Write_File
	la	$a1,Fkhoangcach
	jal Write_File
	la	$a1,time1
	li	$a2,10
	li	$v0,15
	syscall
	la	$a1,lathu
	jal Write_File
	la	$a0 time1
	
	jal FullDate

	move	$a0 $v0
	la	$a1,Ftemp2
	jal ItoA
	
	move	$a0,$t5
	jal Write_File
	
	move	$a0,$t5
	la	$a1,Fngay
	jal Write_File
	
	
	#6
	move	$a0,$t5
	la	$a1,wcau6
	jal Write_File
	
	move	$a1,$t3
	jal Write_File
	
	
	la $a1,Flanam
	jal Write_File
	
	la $a0,time1
	jal Can
	move	$a0,$t5
	move	$a1,$v0
	jal Write_File
	la $a0,time1
	jal Chi
	move	$a0,$t5
	move	$a1,$v0
	jal Write_File
	
	
	#7
	move	$a0,$t5
	la	$a1,wcau7
	jal Write_File
	la	$a1,Fkhoangcachtu
	jal Write_File
	
	la	$a1,time1
	li	$a2,10
	li	$v0,15
	syscall
	
	la	$a1,Fdenngay
	jal Write_File
	la	$a1,time2
	li	$a2,10
	li	$v0,15
	syscall
	la	$a1,lathu
	jal Write_File
	
	la $a0,time1
	la $a1,time2

	
	jal DateDiff
	move	$a0,$v0
	la	$a1,Ftemp2
	jal ItoA
	move	$a0,$t5
	jal Write_File
	move	$a0,$t5
	la 	$a1,Fngay
	jal Write_File

	#8
	move	$a0,$t5
	la	$a1,wcau8
	jal Write_File
	la	$a1,F2namnhuan
	jal Write_File
	move	$a1,$t3
	jal Write_File
	la	$a1,Flanam
	jal Write_File
	la	$a0,time1
	jal TwoNearestLeapYear
	move	$a0 $v0
	la	$a1,Ftemp2
	jal ItoA
	move	$a0,$t5
	jal Write_File  
	
	move	$a0,$t5
	la	$a1,Fva
	jal Write_File
	
	la	$a0,time1
	jal TwoNearestLeapYear
	move	$a0,$v1
	la	$a1,Ftemp2
	jal ItoA
	move	$a0,$t5
	jal Write_File  
	#end
        j endF
###############################################################        
Write_File:	
	#a0 : File descriptor
	#a1: string
	li	$a2,0
	move	$v0,$a1
	dodaistr:    
		lb	$t1,($v0)
		addi	$v0,$v0,1
		beq	$t1,$0,ctWrite_File
		addi	$a2,$a2,1
		j dodaistr
	ctWrite_File: 
		li	$v0,15
		syscall
	
	jr $ra                    

###############################################################
# int ItoA(int, char*)
# arguments:
#    $a0 - integer to convert
#    $a1 - character buffer to write to
# return:  number of characters in converted string
#
ItoA:
  bnez $a0, ItoA.non_zero  # first, handle the special case of a value of zero
 la	$a1,Ftemp
 la	$t1,Ftemp2
  li   $t0, '0'
  sb   $t0, 0($a1)
  sb   $zero, 1($a1)
  li   $v0, 1
  jr   $ra
ItoA.non_zero:
  addi $t0, $zero, 10     # now check for a negative value
  li $v0, 0
    
  bgtz $a0, ItoA.recurse
  nop
  li   $t1, '-'
  sb   $t1, 0($a1)
  addi $v0, $v0, 1
  neg  $a0, $a0
ItoA.recurse:
  addi $sp, $sp, -24
  sw   $fp, 8($sp)
  addi $fp, $sp, 8
  sw   $a0, 4($fp)
  sw   $a1, 8($fp)
  sw   $ra, -4($fp)
  sw   $s0, -8($fp)
  sw   $s1, -12($fp)
   
  div  $a0, $t0       # $a0/10
  mflo $s0            # $s0 = quotient
  mfhi $s1            # s1 = remainder  
  beqz $s0, ItoA.write
ItoA.continue:
  move $a0, $s0  
  jal ItoA.recurse
  nop
ItoA.write:
  add  $t1, $a1, $v0
  addi $v0, $v0, 1    
  addi $t2, $s1, 0x30 # convert to ASCII
  sb   $t2, 0($t1)    # store in the buffer
  sb   $zero, 1($t1)
  
ItoA.exit:
  lw   $a1, 8($fp)
  lw   $a0, 4($fp)
  lw   $ra, -4($fp)
  lw   $s0, -8($fp)
  lw   $s1, -12($fp)
  lw   $fp, 8($sp)    
  addi $sp, $sp, 24
  jr $ra
