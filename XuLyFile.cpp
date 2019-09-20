#include "XuLyFile.h"

// Vd: Input: 2 10 1010111 -> heso1 = 2, heso2 = 10, data= 1010111
void Convert(ifstream &In, ofstream &Out, string heso1, string heso2, string data)
{
	QInt x;
	if (heso1 == "2")
	{
		if (heso2 == "10")
		{
			x.BinToQInt(data, x);
			x.QIntToDec(x, data);
			simply(data);
			if (data.length() == 0)
				Out << "0" << endl;
			else
				Out << data << endl;
		}
		else if (heso2 == "16")
		{
			x.BinToQInt(data, x);
			x.QIntToHex(x, data);
			simply(data);
			if (data.length() == 0)
				Out << "0" << endl;
			else
				Out << data << endl;
		}
	}
	else if (heso1 == "10")
	{
		if (heso2 == "2")
		{
			x.DecToQInt(data, x);
			x.QIntToBin(x, data);
			simply(data);
			if (data.length() == 0)
				Out << "0" << endl;
			else
				Out << data << endl;
		}
		else if (heso2 == "16")
		{
			x.DecToQInt(data, x);
			x.QIntToHex(x, data);
			simply(data);
			if (data.length() == 0)
				Out << "0" << endl;
			else
				Out << data << endl;
		}
	}
	else if (heso1 == "16")
	{
		if (heso2 == "2")
		{
			x.HexToQInt(data, x);
			x.QIntToBin(x, data);
			simply(data);
			if (data.length() == 0)
				Out << "0" << endl;
			else
				Out << data << endl;
		}
		else if (heso2 == "10")
		{
			x.HexToQInt(data, x);
			x.QIntToDec(x, data);
			Out << data << endl;
		}
	}
}

bool KiemTraDau(string a)
{
	if (a == "+" || a == "-" || a == "*" || a == "/" || a == ">" || a == "<" ||
		a == "==" || a == ">=" || a == "<=" || a == "&" || a == "|" || a == "^" ||
		a == "ROR" || a == "ror" || a == "ROL" || a == "rol" || a == ">>" || a == "<<")
		return 1;
	return 0;
}

// Nếu kí tự là 0->9 hoặc A->F thì trả về 1. Ngược lại trả về 0;
bool KiemTraKyTu(char a)
{
	if (a != '1' && a != '2' && a != '3' && a != '4' && a != '5' &&
		a != '6' && a != '7' && a != '8' && a != '9' && a != 'A' &&
		a != 'B' && a != 'C' && a != 'D' && a != 'E' && a != 'F')
		return 0;
	return 1;
}

// Vd:Input: 2 1001 + 1010111 -> heso1 = 2, data1=1001,dau=+, data2= 1010111
void ToanTuHaiNgoi(ifstream &In, ofstream &Out, string heso, string data1, string dau, string data2)
{
	QInt a, b, ans;
	bool c = 0;
	string res = "";
	if (heso == "2")
	{
		a.BinToQInt(data1, a);
		b.BinToQInt(data2, b);
	}
	else if (heso == "10")
	{
		a.DecToQInt(data1, a);
		b.DecToQInt(data2, b);
	}
	else if (heso == "16")
	{
		a.HexToQInt(data1, a);
		b.HexToQInt(data2, b);
	}

	if (dau == "+") ans = a + b;

	else if (dau == "-") ans = a - b;

	else if (dau == "*") ans = a * b;

	else if (dau == "/") ans = a / b;

	else if (dau == "&") ans = a & b;

	else if (dau == "^") ans = a ^ b;

	else if (dau == "|") ans = a | b;

	else if (dau == ">>")
	{
		string temp;
		b.QIntToDec(b, temp);
		int k = stoi(temp);
		ans = a >> k;
	}
	else if (dau == "<<")
	{
		string temp;
		b.QIntToDec(b, temp);
		int k = stoi(temp);
		ans = a << k;
	}
	else if (dau == "ror")
	{
		string temp;
		b.QIntToDec(b, temp);
		int k = stoi(temp);
		ans.ror(k);
	}
	else if (dau == "rol")
	{
		string temp;
		b.QIntToDec(b, temp);
		int k = stoi(temp);
		ans.rol(k);
	}
	// so sanh
	else if (dau == "==") c = (a == b);

	else if (dau == ">=") c = (a >= b);

	else if (dau == "<=") c = (a <= b);

	else if (dau == ">") c = (a > b);

	else if (dau == "<") c = (a < b);

	if (ans.checkIfZero())
	{
		if (c)
			ans.SetBit(ans, 1, 0);
		else
			ans.SetBit(ans, 0, 0);
	}

	if (heso == "2")
	{
		ans.QIntToBin(ans, res);
		simply(res);
		if (res.length() == 0)
			Out << "0" << endl;
		else
			Out << res << endl;
	}
	else if (heso == "10")
	{
		ans.QIntToDec(ans, res);
		Out << res << endl;
	}
	else if (heso == "16")
	{
		{
			ans.QIntToHex(ans, res);
			simply(res);
			if (res.length() == 0)
				Out << "0" << endl;
			else
				Out << res << endl;
		}
	}
}

void ToanTuMotNgoi(ifstream &In, ofstream &Out, string heso, string dau, string data)
{
	QInt a;
	if (heso == "2")
	{
		a.BinToQInt(data, a);
		a = ~a;
		a.QIntToBin(a, data);
		Out << data << endl;
	}
	else if (heso == "16")
	{
		a.HexToQInt(data, a);
		a = ~a;
		a.QIntToHex(a, data);
		Out << data << endl;
	}
	else if (heso == "10")
	{
		a.DecToQInt(data, a);
		a = ~a;
		a.QIntToDec(a, data);
		Out << data << endl;
	}
}

void DocVaXuLyFileQInt(string &in, string &out)
{
	int TH = 0;
	ifstream fileIn;
	fileIn.open(in, ios::in);

	ofstream fileOut;
	fileOut.open(out, ios::out);

	string a1, a2, a3, a4;

	if (fileIn.fail())
	{
		cout << "Failed to open this file!" << endl;
		return;
	}
	else
	{
		while (!fileIn.eof())
		{
			getline(fileIn, a1, ' ');
			getline(fileIn, a2, ' ');
			getline(fileIn, a3, '\n');

			if (!KiemTraKyTu(a3[0])) //nếu bắt đầu chuỗi không phải là 0->9 va A-> F =>phép tính toán 2 ngôi
			{
				if (a3[1] == ' ') // tinh toan
				{
					a4 = a3;
					string temp;
					temp.push_back(a3[0]);
					a3 = temp;
					a4.erase(a4.begin());
					a4.erase(a4.begin());
				}
				else if (a3[2] == ' ')	//dấu == >= <= >> <<
				{
					a4 = a3;
					string temp;
					temp.push_back(a3[0]);
					temp.push_back(a3[1]);
					a3 = temp;
					a4.erase(a4.begin());
					a4.erase(a4.begin());
					a4.erase(a4.begin());
				}
				else if (a3[3] == ' ')	//ror, rol
				{
					a4 = a3;
					string temp;
					temp.push_back(a3[0]);
					temp.push_back(a3[1]);
					temp.push_back(a3[2]);
					a3 = temp;
					a4.erase(a4.begin());
					a4.erase(a4.begin());
					a4.erase(a4.begin());
					a4.erase(a4.begin());
				}
			}
			//nếu là các phép tính toán
			if (KiemTraDau(a3))
			{
				ToanTuHaiNgoi(fileIn, fileOut, a1, a2, a3, a4);
			}
			//nếu là phép tính toán 1 ngôi ( toán tử not )
			else if (a2 == "~")
			{
				ToanTuMotNgoi(fileIn, fileOut, a1, a2, a3);
			}
			else  //nếu là phép chuyển đổi
			{
				Convert(fileIn, fileOut, a1, a2, a3);
			}
		}
		cout << "THANH CONG!" << endl;
	}
	fileIn.close();
	fileOut.close();
}
void DocVaXuLyFileQfloat(Qfloat *FL)
{

	fstream fi("INPUT.txt", ios::in);
	fstream fo("OUTPUT.txt", ios::out);
	int j = 0;
	while (!fi.eof())
	{
		char *s = new char[maxLenBit];
		fi.getline(s, strlen(s));
		FL[j].ScanQfloat(s);
		j++;
	}
	for (int i = 0; i < j + 1; i++)
	{
		FL[i].PrintQfloat(fo);
		fo << endl;
	}
}