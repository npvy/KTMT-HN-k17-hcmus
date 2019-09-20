#ifndef __QFLOAT_H__
#define __QFLOAT_H__

#include <math.h>
#include "QInt.h"
#include <fstream>

using namespace std;

const int maxLenData = 4;  // 4 data =128 bit
const int maxLenBit = 128; // số bit của  chuỗi chấm động
const int maxLenFra = 112;// max số bit của phần giá trị
const int maxLenExp = 15;// max của phần mũ

class Qfloat
{
private:
	unsigned int data[4];// lưu ở dạng chấm động 128 bit

	string value;// giá trị thực

	int type;// kiểu của số nhập vào

public:
	// hàm khởi tạo mặc định = 0
	Qfloat();

	// hàm nhập
	// File input có 2 phần: số đầu tiền là kiểu dữ liệu nhập vào 2 hoặc 10. 
	// Nếu là 10 thì có phần sau là số thực, nếu là 2 thì có 3 phần là s e m.
	void ScanQfloat(char*);

	// in ra file
	void PrintQfloat(fstream &fs);

	// nếu value là số nhị phân thì cập nhật lại thành thập phân.
	void XuLy();

	// Hàm chuyển đổi số Qfloat nhị phân sang thập phân
	Qfloat BinToDec();

	// Hàm chuyển đổi số Qfloat thập phân sang nhị phân 
	Qfloat DecToBinFloat();

	//Đưa bit vào
	void SetBit(int bit, int i);

	//Lấy bit thứ i
	bool GetBit(int pos);

	//lay bit tu vi tri nay den vi tri kia
	string GetBits(int, int);

	// kiểm tra bằng 0
	bool is0();

	//hàm kiểm tra số vô cực
	bool isINF();

	//hàm kiểm tra số báo lỗi
	bool isNaN();

	//hàm kiểm tra số không chuẩn
	bool isDenormalizedNumber();

	//ham lấy giá trị của số thực
	string GetValue();

	// hàm nhân chuỗi số dạng thập phân cho một số val nào đó
	string mul(const string &num, int val);

	//hàm chuyển đổi phần thập phân của chuỗi số thực dạng nhị phân sang thập phân
	string BinToDec_fra(string num);

	//hàm chuyển phần thập
	string DecToBin_fra(string num);

	//kiểm tra chuỗi bằng 0
	bool isZero(const string &num);

	//chuyển phần số mũ sang nhị phân
	string IntToBin_EX(int);

	//chuyển chuỗi nhị phân về chuẩn hóa chấm động
	Qfloat BinToBinCD(int, string, string);
};
#endif