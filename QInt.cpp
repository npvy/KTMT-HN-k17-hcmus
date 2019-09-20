#include "QInt.h"

// khoi tao du lieu
QInt::QInt()
{
	for (int i = 0; i < 4; i++)
		this->data[i] = 0;
}

QInt::QInt(const QInt &a)
{
	for (int i = 3; i >= 0; i--)
		data[i] = a.data[i];
}
// Hàm hủy
QInt::~QInt()
{
	for (int i = 0; i < 4; i++)
		this->data[i] = 0;
}

//----------------CÁC HÀM HỖ TRỢ-------------------

int findFirstNegativeBit(QInt str)
{
	int pos = 0;
	for (int j = 0; j < 128; j++)
	if (str.GetBit(128 - 1 - j) == 0)
		pos = j - 1;
	return pos;
}
// Chuẩn hóa chuỗi bằng cách xóa các chữ số 0 ở đầu
//vd: 00011->11
void simply(string &a)
{
	while (a[0] == '0')
		a.erase(a.begin() + 0);
}

char numTochar(int a)
{
	return a + '0';
}

int charTonum(char a)
{
	return a - '0';
}

string div_2(string a)
{
	string result;
	int value, mod = 0;  // mod: số dư

	for (unsigned int i = 0; i < a.length(); i++)
	{
		value = mod * 10 + charTonum(a[i]);
		result += numTochar(value / 2);
		mod = value % 2;
	}
	simply(result); // chuẩn hóa lại kết quả
	return result;
}

// Hàm cộng 2 chuỗi 
string Add(string a, string b)
{
	string kq;
	// chuẩn hóa độ dài 2 chuỗi vd: 123 +13579 -> 00123 +13579
	if (a.length() < b.length())
		a.swap(b);

	int size = a.length() - b.length();
	for (int i = 0; i < size; i++)
		b.insert(0, 1, '0');

	int temp = 0;
	for (int i = a.length() - 1; i >= 0; i--) // duyệt và cộng
	{
		temp = charTonum(a[i]) + charTonum(b[i]) + temp; // tính tổng từng đôi một
		kq.insert(0, 1, numTochar(temp % 10)); // gán phần đơn vị vào chuỗi kết quả
		temp = temp / 10;     // lấy lại phần chục
	}

	if (temp>0) // nếu hàng chục lớn hơn 0 thì thêm vào kết quả
	{
		kq.insert(0, 1, numTochar(temp));
	}
	return kq;
}

// Nhân một số cho 2
string mul_2(string a) // x*2
{
	return Add(a, a);
}

// 2 mũ n
string mu_2(int n) //2^n
{
	if (n == 0)
		return "1";

	string kq = "2"; // hệ số 2
	for (int i = 1; i < n; i++)
		kq = mul_2(kq);
	return kq;
}

// vd: abcd -> dcba
void ReverseString(string &a)
{
	for (unsigned int i = 0; i < a.length() / 2; i++)
		swap(a[i], a[a.length() - i - 1]);
}

string Bu2(string bin)
{
	// bù 1
	for (unsigned int i = 0; i < bin.length(); i++)
		bin[i] = (bin[i] == '0') ? '1' : '0';

	//cộng thêm 1
	for (int i = bin.length() - 1; i >= 0; i--)
	{
		bool remember = 1;
		if (bin[i] == '0' && remember == 1)
		{
			bin[i] = '1';
			break;
		}
		else if (bin[i] == '1' && remember == 1)
			bin[i] = '0';
	}
	return bin;
}

string DecToBin(string a)
{
	string bit;
	string tmp = a;
	bool ktsoam = false;// neu la so duong thi false, so am la true

	if (a[0] == '-') // kiểm tra dấu
	{
		tmp = a.erase(0, 1);
		ktsoam = true;
	}

	if (a == "0") // nếu a=0 thì bit=0
		return bit = "0";
	else
	{
		while (tmp != "0"&&tmp != "")
		{
			int length = tmp.length();
			bit += numTochar(charTonum(tmp[length - 1]) % 2); //lấy phần dư
			tmp = div_2(tmp);
		}
		ReverseString(bit); // đảo chuổi
	}

	if (ktsoam) // nếu là số âm thì lấy bù 2
	{
		int n = bit.length();
		for (int i = 128; i > n; i--)
			bit = "0" + bit;

		bit = Bu2(bit);
	}
	return bit;
}

string BinToDec(string bin)
{
	int ktsoam = 0;
	string result = "0";

	if (bin[0] == '1')
	{
		ktsoam = 1;
		bin = Bu2(bin);
	}

	for (int i = 127; i >= 0; i--)
	{
		if (bin[i] == '1')
			result = Add(result, mu_2(127 - i));
	}

	if (ktsoam == 1)
	{
		result.insert(0, 1, '-');
	}
	return result;
}

string HexToBin(string hex)
{
	string bin = "";
	for (unsigned int i = 0; i < hex.length(); i++)
	{
		switch (toupper(hex[i]))
		{
		case '0': bin.append("0000"); break;
		case '1': bin.append("0001"); break;
		case '2': bin.append("0010"); break;
		case '3': bin.append("0011"); break;
		case '4': bin.append("0100"); break;
		case '5': bin.append("0101"); break;
		case '6': bin.append("0110"); break;
		case '7': bin.append("0111"); break;
		case '8': bin.append("1000"); break;
		case '9': bin.append("1001"); break;
		case 'A': bin.append("1010"); break;
		case 'B': bin.append("1011"); break;
		case 'C': bin.append("1100"); break;
		case 'D': bin.append("1101"); break;
		case 'E': bin.append("1110"); break;
		case 'F': bin.append("1111"); break;
		}
	}
	return bin;
}

//i là vị trí của bit cần set thành 1 trong chuỗi 128 bit của mảng 4 số int 
//128 bit được chia làm 4 số int mỗi số 32 bit
//i / 32 sẽ cho biết bit cần set thuộc số nào trong 4 số a[0] a[1] a[2] a[3]
//i % 32 sẽ cho biết bit cần set thuộc bit nào trong 32 bit của 1 số nguyên int  
void QInt::SetBit(QInt &a, int bit, int i)
{
	a.data[i / 32] = a.data[i / 32] | (bit << (31 - (i % 32)));
}

bool QInt::GetBit(int i)
{
	return (data[i / 32] >> (31 - i % 32)) & 1;
}

// Kiểm tra số trên chuỗi có bằng 0 hay không
bool QInt::checkIfZero()
{
	for (int i = 0; i < 4; i++)
	if (data[i] != 0)
		return 0;
	return 1;
}

// tìm kiếm vị trí bit 1 đầu tiên của 1 số dương 
int QInt::findBitN(QInt str)
{
	int kq = 0;
	int i = 3;
	while (str.data[i] == 0)
		i--;
	if (i == -1)
		kq = -1;
	for (int j = 32 * (i + 1) - 1; j >= 0; j--)
	if (str.GetBit(j))
		kq = j + 1;
	return kq;
}


void QInt::BinToQInt(string &bin, QInt &x)
{
	// Chuẩn hóa độ dài chuỗi
	// Nếu độ dài của chuỗi bin < 128 thì thêm số 0 vào đằng trước 
	if (bin.length() < 128)
	{
		int n = bin.length();
		for (int i = n; i < 128; i++)
		{
			bin.insert(0, "0");
		}
	}
	for (int i = 0; i < 128; i++)
	if (bin[abs(i - 127)] == '1')
		SetBit(x, 1, i);
}

void QInt::QIntToBin(QInt &x, string &bin)
{
	bin = "";
	for (int i = 0; i < 128; i++)
	if (x.GetBit(i) == 0)
		bin.insert(0, "0");
	else
		bin.insert(0, "1");
}

void QInt::DecToQInt(string &dec, QInt &x)
{
	string bin = DecToBin(dec);
	BinToQInt(bin, x);
}

void QInt::QIntToDec(QInt &x, string &dec)
{
	string bin;
	QIntToBin(x, bin);
	dec = BinToDec(bin);
}

void QInt::HexToQInt(string &hex, QInt &x)
{
	string bin = HexToBin(hex);
	BinToQInt(bin, x);
}

void QInt::QIntToHex(QInt &x, string &hex)
{
	string bin;
	QIntToBin(x, bin);
	hex = Q_BinToHex(bin);
}

// Hàm nhập
void QInt::ScanQInt(QInt &x, int &heso)
{
	cout << "Moi nhap he so: ";
	cin >> heso;
	string a;
	if (heso == 2)
	{
		cout << "Moi nhap du lieu:\n ";
		cin >> a;
		BinToQInt(a, x);
	}
	else if (heso == 10)
	{
		cout << "Moi nhap du lieu: ";
		cin >> a;
		DecToQInt(a, x);
	}
	else if (heso == 16)
	{
		cout << "Moi nhap du lieu: ";
		cin >> a;
		HexToQInt(a, x);
	}
	else
	{
		cout << "He so khong hop le. Xin kiem tra lai! \n";
		system("pause");
		exit(0);
	}
}

// Hàm xuất
void QInt::PrintQInt(QInt x, int heso)
{
	string a;
	if (heso == 2)
	{
		QIntToBin(x, a);
		simply(a);
		cout << a << endl;
	}
	else if (heso == 10)
	{
		QIntToDec(x, a);
		cout << a << endl;
	}
	else if (heso == 16)
	{
		QIntToHex(x, a);
		simply(a);
		cout << a << endl;
	}
	else
	{
		cout << "He so khong hop le. Xin kiem tra lai! \n";
		system("pause");
		exit(0);
	}
}

string QInt::Q_DecToBin(QInt x)
{
	string bin;
	QIntToBin(x, bin);
	return bin;
}

QInt QInt::Q_BinToDec(string a)
{
	QInt Dec;
	for (int n = 0; n < 4; n++)
	{
		Dec.data[n] = 0;
	}

	for (int i = 0; i < 128; i++)
		SetBit(Dec, a[i], i);
	return Dec;
}

string QInt::Q_BinToHex(string bin)
{
	string hex = "";
	string tmp = "0000";
	for (int j = 0; j < 128; j += 4)
	{
		tmp = bin.substr(j, 4); // tach chuoi co do dai = 4
		if (!tmp.compare("0000")) hex += "0";
		else if (!tmp.compare("0001")) hex += "1";
		else if (!tmp.compare("0010")) hex += "2";
		else if (!tmp.compare("0011")) hex += "3";
		else if (!tmp.compare("0100")) hex += "4";
		else if (!tmp.compare("0101")) hex += "5";
		else if (!tmp.compare("0110")) hex += "6";
		else if (!tmp.compare("0111")) hex += "7";
		else if (!tmp.compare("1000")) hex += "8";
		else if (!tmp.compare("1001")) hex += "9";
		else if (!tmp.compare("1010")) hex += "A";
		else if (!tmp.compare("1011")) hex += "B";
		else if (!tmp.compare("1100")) hex += "C";
		else if (!tmp.compare("1101")) hex += "D";
		else if (!tmp.compare("1110")) hex += "E";
		else if (!tmp.compare("1111")) hex += "F";
		else continue;
	}
	return hex;
}

string QInt::Q_DecToHex(QInt dec)
{
	string bin;
	bin = Q_DecToBin(dec);
	return Q_BinToHex(bin);
}

//Hàm trả về một QInt là tổng của 2 QInt
QInt QInt:: operator+(QInt &t)
{
	QInt res;
	int remember = 0;//giá trị nhớ

	for (int i = 0; i < 128; i++)
	{
		if (remember == 0)
		{
			if (this->GetBit(i) == 0 && t.GetBit(i) == 0)
				SetBit(res, 0, i);
			else if (this->GetBit(i) == 1 && t.GetBit(i) == 1)
			{
				remember = 1;
				SetBit(res, 0, i);
			}
			else SetBit(res, 1, i);
		}
		else
		{
			if (this->GetBit(i) == 0 && t.GetBit(i) == 0)
			{
				SetBit(res, 1, i);
				remember = 0;
			}
			else if (this->GetBit(i) == 1 && t.GetBit(i) == 1)
			{
				SetBit(res, 1, i);
				remember = 1;
			}
			else
			{
				SetBit(res, 0, i);
				remember = 1;
			}
		}
	}
	return res;
}

//Hàm trả về một QInt là bù 2 của QInt
QInt QInt::Bu_2()
{
	QInt one;
	SetBit(one, 1, 0);
	return ~*this + one;
}

//Hàm trả về một QInt là hiệu của 2 QInt
QInt QInt:: operator-(QInt &t)
{
	return *this + t.Bu_2();
}

// trả về 1 biến QInt là kết quả của A*B
QInt QInt ::operator *(QInt &str)
{
	QInt zero;
	if (this->checkIfZero() || str.checkIfZero())
		return zero;

	int pos1 = 0, pos2 = 0;
	if (this->GetBit(127) == 1)
		pos1 = 128 - findFirstNegativeBit(*this);
	else
		pos1 = findBitN(*this);
	if (str.GetBit(127) == 1)
		pos2 = 128 - findFirstNegativeBit(str);
	else
		pos2 = findBitN(str);
	int pos;


	pos = pos1 > pos2 ? pos1 + 1 : pos2 + 1;

	int k = pos;
	QInt res;


	for (int i = 0; i < pos; i++)
	if (str.GetBit(i) == 1)
		res.SetBit(res, 1, i + 1);
	;
	QInt neg = (this->Bu_2()) << (pos + 1);

	QInt positive = *this << (pos + 1);

	while (k > 0)
	{

		if (res.GetBit(0) == 0 && res.GetBit(1) == 1)
			res = res + neg;
		else if (res.GetBit(0) == 1 && res.GetBit(1) == 0)
			res = res + positive;

		if (res.GetBit(pos * 2))
			res.SetBit(res, 1, pos * 2 + 1);
		else
			res.SetBit(res, 0, pos * 2 + 1);
		res = res >> 1;


		k--;
	}


	QInt ans;

	for (int i = pos * 2; i >= 0; i--)
	{
		if (res.GetBit(i))
			ans.SetBit(ans, 1, i);


	}
	ans = ans >> 1;

	if (ans.GetBit(pos * 2 - 1) == 1)

	for (int i = pos * 2; i < 128; i++)
		ans.SetBit(ans, 1, i);

	return ans;

}

// trả về 1 biến QInt là kết quả của A/B
QInt QInt :: operator /(QInt &str)
{
	QInt A;
	bool ifNegative = 0;
	if (this->checkIfZero())
		return A;
	if (str.checkIfZero())
	{
		cout << "loi input, mau bang 0" << endl;
		exit(0);
	}
	int pos1 = 0, pos2 = 0;
	if (this->GetBit(127) == 1)
	{
		ifNegative = 1;
		*this = this->Bu_2();
	}
	else
		pos1 = findBitN(*this) + 1;
	if (str.GetBit(127) == 1)
	{
		if (ifNegative)
			ifNegative = 0;
		else
			ifNegative = 1;
		str = str.Bu_2();
	}
	else
		pos2 = findBitN(str) + 1;
	int pos;
	pos = pos1 > pos2 ? pos1 : pos2;
	int k = pos;
	A = ((A << pos) | *this);
	QInt neg;


	neg = str.Bu_2() << pos;
	str = str << pos;
	while (k > 0)
	{
		A = A << 1;
		A = A + neg;
		if (A.GetBit(127))
		{
			A.SetBit(A, 0, 0);
			A = A + (str);
		}
		else
			A.SetBit(A, 1, 0);
		k--;
	}
	QInt ans;
	for (int i = pos - 1; i >= 0; i--)
	{
		if (A.GetBit(i) == 1)
			ans.SetBit(ans, 1, i);
	}
	if (ifNegative)
		return ans.Bu_2();
	return ans;

}

// --------------Các hàm so sánh------------------

bool QInt ::operator>(QInt str)
{
	bool flag = 1;

	if (this->GetBit(127) == 1 && str.GetBit(127) == 1)
	{
		return str.Bu_2() > this->Bu_2() ? 1 : 0;
	}
	else if (this->GetBit(127) == 1)
		return 0;
	else if (str.GetBit(127) == 1)
		return 1;
	else
	for (int i = 5; i >= 0; i--)
	{
		if (this->GetBit(i) && str.GetBit(i))
			flag = 0;
		if ((this->GetBit(i) < str.GetBit(i)) && !flag)
			return 0;
		else if ((this->GetBit(i) < str.GetBit(i)) && flag)
			return 1;

		if ((this->GetBit(i) > str.GetBit(i)) && !flag)
			return 1;

		if ((this->GetBit(i) > str.GetBit(i)) && flag)
			return 0;
	}
	return 0;
}

bool QInt ::operator<(QInt str)
{
	bool flag = 1;

	if (this->GetBit(127) == 1 && str.GetBit(127) == 1)
	{
		return str.Bu_2() < this->Bu_2() ? 1 : 0;
	}
	else if (this->GetBit(127) == 1)
		return 1;
	else if (str.GetBit(127) == 1)
		return 0;
	else
	for (int i = 127; i >= 0; i--)
	{
		if (this->GetBit(i) && str.GetBit(i))
			flag = 0;
		if ((this->GetBit(i) < str.GetBit(i)) && !flag)
			return 1;
		else if ((this->GetBit(i) < str.GetBit(i)) && flag)
			return 1;
		else if ((this->GetBit(i) > str.GetBit(i)) && !flag)
			return 0;
		else if ((this->GetBit(i) > str.GetBit(i)) && flag)
			return 0;
	}
	return 0;
}

bool QInt ::operator>=(QInt str)
{
	if (*this < str)
		return 0;
	return 1;
}

bool QInt ::operator<=(QInt str)
{
	if (*this < str || str == *this)
		return 1;
	return 0;
}

bool QInt ::operator ==(QInt str)
{
	for (int i = 0; i < 4; i++)
	if (data[i] != str.data[i])
		return 0;
	return 1;
}

QInt& QInt::operator =(QInt num)
{
	if (this == &num)
		return *this;

	for (int i = 0; i < 4; i++)
		this->data[i] = num.data[i];
	return *this;
}

QInt QInt:: operator &(QInt &str)
{
	for (int i = 0; i < 4; i++)
		data[i] = data[i] & str.data[i];
	return *this;
}
QInt QInt:: operator |(QInt &str)
{
	for (int i = 0; i < 4; i++)
		data[i] = data[i] | str.data[i];
	return *this;
}

QInt QInt:: operator ^(QInt &str)
{
	for (int i = 0; i < 4; i++)
		data[i] = data[i] ^ str.data[i];
	return *this;
}

QInt QInt:: operator ~()
{
	QInt res;
	for (int i = 0; i < 128; i++)
	{
		if (this->GetBit(i) == 1)
			SetBit(res, 0, i);
		else
			SetBit(res, 1, i);
	}
	return res;
}

QInt QInt::operator>>(int num)
{
	QInt temp;
	for (int i = 128 - 1; i >= num; i--)
	if (this->GetBit(i))
		SetBit(temp, 1, i - num);
	return temp;
}

QInt QInt::operator<<(int num)
{
	QInt temp;

	for (int i = 0; i <128 - num; i++)
	if (this->GetBit(i))
		SetBit(temp, 1, i + num);
	return temp;
}
QInt QInt::ror(int num)
{
	QInt temp;
	for (int i = 0; i < num; i++)
	if (this->GetBit(i))
		SetBit(temp, 1, 127 - num + i);

	for (int i = 128 - 1; i >= num; i--)
	if (this->GetBit(i))
		SetBit(temp, 1, i - num);

	return temp;
}

QInt QInt::rol(int num)
{
	QInt temp;
	for (int i = 128 - num; i < 128; i++)
	if (this->GetBit(i))
		SetBit(temp, 1, i - (128 - num));
	for (int i = 0; i < 128 - num; i++)
	if (this->GetBit(i))
		SetBit(temp, 1, i + num);
	return temp;
}