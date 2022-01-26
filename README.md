# AES_in_verilog
An algorithmic state machine verilog code for AES Encryption/Decryption Algorithm
This project was designed by Mojtaba Almadan and Hasan Alhussain, two Computer Engineering students at KFUPM.

AES brief explanation:
In AES encryption there are two input and one output. The inputs are the 
key and the plaintext, while the output is the cipher text or the encrypted text. 
However, there is a key expansion block that expands the key and generate 10 
keys so that each one is used in a round either for encryption or decryption. After 
having the keys ready for all rounds then the rounds are executed. Initially, as a 
first step an add round key layer is executed. After that, 10 rounds are executed 
starting with Byte Substitution layer, Shift rows layer, Mix columns layer and 
ending with add round key layer. This procedure will be executed 9 times except 
that the final tenth round will be without mix columns layer. Then, the encrypted 
text is produced.

Our control signals:
- init: 
An output signal going to the Datapath to store the inputs in the registers.
- inc_count:
An output signal that increments the counter.
- dec_count:
An output signal that decrements the counter.
- isRound0:
An output signal that indicates that we are in the first round.
- isRound9:
An output signal that indicates that we are in the nineth round.
- isRound10:
An output signal that indicates that we are in the last round.
- en_round_out:
An output signal that enables the Round_out register.
- en_Dout:
An output signal that enables the Dout register.
- en_reg_sub_out:
An output signal that enables sub bytes register.
- en_reg_row_out:
An output signal that enables shift rows register.
- en_reg_col_out,:
An output signal that enables mix coloumns register.
- en_reg_inv_sub_out:
An output signal that enables inverse sub bytes register.
- en_reg_inv_row_out:
An output signal that enables inverse shift rows register.
- en_reg_inv_col_out,:
An output signal that enables inverse mix coloumns register.
- done:
An output signal to the user that indicates that the state machine is done.
- count_lt_10:
An input signal that indicates that the counter is less than 10.
- count_lt_9:
An input signal that indicates that the counter is less than 9.
- count_gt_0:
An input signal that indicates that the counter is greater than 0.

