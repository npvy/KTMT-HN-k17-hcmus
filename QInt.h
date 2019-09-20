#ifndef __QINT_H__
#define __QINT_H__

#include<iostream>
#include <string>

using namespace std;

class QInt
{
public:
	// Dữ liệu lưu 128 bit
	unsigned int data[4];

	QInt();

	QInt(const QInt &);

	~QInt();

	// Set bit tại vị trí i
	void SetBit(QInt &a, int bit, int i);

	// Lấy bit tại vị trí i
	bool GetBit(int i);

	bool checkIfZero();

	int findBitN(QInt);

	// Chuyển chuỗi hệ nhị phân sang QInt
	void BinToQInt(string &a, QInt &x);

	// Chuyển QInt sang chuỗi hệ nhị phân
	void QIntToBin(QInt &x, string &a);

	// Chuyển chuỗi hệ thập phân sang QInt
	void DecToQInt(string &a, QInt &x);

	// Chuyển QInt sang chuỗi hệ thập phân
	void QIntToDec(QInt &x, string &a);

	// Chuyển chuỗi hệ số 16 phân sang QInt
	void HexToQInt(string &a, QInt &x);

	// Chuyển QInt sang chuỗi hệ số 16
	void QIntToHex(QInt &x, string &a);

	// Hàm nhập
	void ScanQInt(QInt &x, int &heso);

	// Hàm xuất
	void PrintQInt(QInt x, int heso);

	// Hàm chuyển đổi số QInt thập phân sang nhị phân
	string Q_DecToBin(QInt x);

	// Hàm chuyển đổi số QInt nhị phân sang thập phân
	QInt Q_BinToDec(string a);

	// Hàm chuyển đổi số QInt nhị phân sang thập lục phân
	string Q_BinToHex(string a);

	// Hàm chuyển đổi số QInt thập phân sang thập lục phân
	string Q_DecToHex(QInt a);

	// + - * /
	QInt operator+(QInt &t);

	QInt Bu_2();

	QInt operator-(QInt &t);

	QInt operator *(QInt &t);//

	QInt operator /(QInt &t);//

	// các phép so sánh
	bool operator>(QInt);

	bool operator<(QInt);

	bool operator>=(QInt);

	bool operator<=(QInt);

	bool operator ==(QInt);

	// phép gán
	QInt& operator =(QInt);

	// and
	QInt operator &(QInt &);

	// or
	QInt operator |(QInt &);

	// xor
	QInt operator ^(QInt &);

	// not
	QInt operator~();

	// dich trai
	QInt operator<<(int x);

	//dich phai
	QInt operator>>(int x);

	//xoay trai
	QInt rol(int x);

	//xoay phai
	QInt ror(int x);

};

int findFirstNegativeBit(QInt str);

// Chuẩn hóa chuỗi bằng cách xóa các chữ số 0 ở đầu
//vd: 00011->11
void simply(string &a);

// Chuyển một số nguyên ra dạng kí tự tương ứng
char numTochar(int a);

// Chuyển kí tự sang dạng số tương ứng
int charTonum(char a);

// Hàm trả ra một chuỗi là kết quả của phép chia lấy nguyên cho 2
string div_2(string a); // chia 2

string Add(string a, string b); // a + b

string mul_2(string); // x*2

string mu_2(int); //x^2

// Hàm đảo chuỗi
void ReverseString(string &a);

// Hàm bù 2 dạng chuỗi string
string Bu2(string a);

// Chuyển số hệ 10 được đưa vào dạng chuỗi trả ra một chuỗi là chuỗi số nhị phân tương ứng
string DecToBin(string a);

// Chuyển số hệ nhị phân được đưa vào dạng chuỗi trả ra một chuỗi số hệ thập phân tương ứng
string BinToDec(string a);

// Chuyển số hệ 16 được đưa vào dạng chuỗi trả ra 1 chuỗi là số nhị phân tương ứng
string HexToBin(string a);

#endif