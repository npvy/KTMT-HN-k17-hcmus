#include "Qfloat.h"

Qfloat::Qfloat()
{
	for (int i = 0; i <maxLenData; i++)
		data[i] = 0;// khởi tạo giá trị 0 cho các bit
	type = 0;
	value = "";
}

void Qfloat::ScanQfloat(char *s)
{
	char*word = NULL;
	char*next_word = NULL;
	word = strtok_s(s, " ", &next_word);

	this->type = atoi(word);

	this->value = _strdup(next_word);

	if (type == 10)

		this->DecToBinFloat();
	else
	{
		int a;//phan dau
		string e, m;// 3 phan cua so cham dong
		word = strtok_s(NULL, " ", &next_word);
		a = atoi(word);
		word = strtok_s(NULL, " ", &next_word);
		e = _strdup(word);
		m = _strdup(next_word);
		this->BinToBinCD(a, e, m);
		this->XuLy();
	}
}

void Qfloat::PrintQfloat(fstream &fo)
{
	if (this->type == 10)
	for (int i = 0; i < maxLenBit; i++)
	{
		if (i == 1 || i == 16)
			fo << " ";
		fo << this->GetBit(i);
	}
	else
	for (unsigned int i = 0; i < this->value.length(); i++)
	{
		fo << value[i];
	}
}

void Qfloat::XuLy()
{
	if (this->type == 2)
		this->BinToDec();
}

string Qfloat::mul(const string &num, int val)
{
	string res = "";
	int t = 0;
	for (int i = num.length() - 1; i >= 0; --i)
	{
		t += (num[i] - '0')*val;
		res += (t % 10) + '0';
		t /= 10;
	}
	while (t > 0)
	{
		res += (t % 10) + '0';
		t /= 10;
	}
	ReverseString(res);
	return res;
}

void Qfloat::SetBit(int  value, int pos)
{
	if (value == 1)
		data[pos / 32] |= (1 << (31 - pos % 32));
	else
		data[pos / 32] &= ~(1 << (31 - pos % 32));
}

bool Qfloat::GetBit(int pos)
{
	return (data[pos / 32] >> (31 - pos % 32)) & 1;
}

Qfloat Qfloat::BinToDec()
{
	if ((*this).isINF() == true)
		this->value = "isINF";
	else if ((*this).isNaN() == true)
		this->value = "isNAN";
	else if ((*this).isDenormalizedNumber() == true)
		this->value = "is Denormalized Number";
	else
	{
		string t = "0";//phan thuc;
		int e = 0;
		// 
		for (int i = 1; i < 16; i++)
		{
			e += this->GetBit(i) * pow(2, 15 - i);
		}

		if ((e < 127) || (e>238))
		{
			this->value = "is Denormalized Number";
			return *this;
		}

		e = e - 127;// so phan thuc.
		string VE = this->GetBits(16, e + 15);// lay phan gia tri nguyen
		int ee = e;//sao chép số mũ
		t = Add(t, mu_2(e));

		for (unsigned int j = 0; j < VE.length(); j++)
		{
			e--;
			if (VE[j] == '1')
				t = Add(t, mu_2(e));
		}

		int end;

		for (int i = maxLenBit; i>0; i--)
		if (GetBit(i) != 0)
		{
			end = i;
			break;
		}	// chọn vị trí có giá trị khác 0 cuối cùng của chuỗi bit
		string fra;

		if (end < 16 + ee) fra = '0';
		else fra = BinToDec_fra(GetBits(ee + 16, end));// phần thập phân

		this->value = t + '.' + fra;
	}
	if (GetBit(0) == 1) this->value = '-' + value;
	return *this;
}

Qfloat Qfloat::DecToBinFloat()
{
	unsigned int i;
	int s;//phần dấu
	if (this->value[0] == '-')
	{
		s = 1;
		i = 1;
	}
	else
	{
		s = 0;
		i = 0;
	}
	string In, Fra = "0";// phần nguyên và thập phân
	char temp;
	do
	{
		temp = this->value[i];
		In += temp;// gán phần nguyên vào In
		i++;
	} while (this->value[i] != '.' && i<this->value.size());
	i += 1;
	if (i<this->value.size())
	do
	{
		temp = this->value[i];
		Fra += temp;
		i++;
	} while (i < this->value.length());

	string fr = DecToBin_fra(Fra);
	string in = DecToBin(In);
	int ex = in.length() - 1;// số dịch chấm động

	string in1 = "";
	for (unsigned int i = 0; i < in.length() - 1; i++)// bỏ số 1 đầu tiên để đưa về phù hợp chấm động
	{
		in[i] = in[i + 1];
		in1 += in[i];
	}

	string m = in1 + fr;//phần m của chấm động
	string EX = IntToBin_EX(ex + 127);//số mũ +127 dạng string
	this->BinToBinCD(s, EX, m);

	return *this;
}

string Qfloat::IntToBin_EX(int x)
{
	string res = "";
	do
	{
		if (x % 2 == 0) res += '0';
		else res += '1';
		x = x / 2;
	} while (x != 0);
	ReverseString(res);//vì số nhị phân tính ra ghi ngược lại
	return res;
}

string Qfloat::DecToBin_fra(string num)
{
	string res = "";
	int reslen = 0;

	do {
		int len = num.length();
		num = mul(num, 2); // nhân phần thập phân với 2
		if (len == num.length()) // khi nhân 2 độ dài chuỗi k thay đổi có nghĩa num<0
		{
			res += '0';
			reslen++;
		}
		else { //num>10
			res += '1';
			reslen++;
			num = num.erase(0, 1);// xóa đi phần đầu
		}
		if (reslen > 2 * maxLenExp) break;
	} while (!isZero(num));

	return res;
}

string Qfloat::BinToDec_fra(string num)
{
	string temp = "0";
	for (int i = num.length() - 1; i >= 0; --i)
	{
		temp = num[i] + temp;
		temp = mul(temp, 5);
	}
	return temp;
}

string Qfloat::GetBits(int begin, int end)
{
	string res = "";
	for (int i = begin; i <= end; i++)
	{
		res.push_back(this->GetBit(i) + '0'); //ép kiểu string số nguyên.
	}
	return res;
}

string Qfloat::GetValue()
{
	return this->value;
}

bool Qfloat::is0()
{
	if (data[0] != 0 && data[0] != (1 << 31))
	{
		return false;
	}
	for (int i = 1; i < 4; i++)
	{
		if (data[i] != 0)
			return false;
	}
	return true;
}

bool Qfloat::isINF()
{
	for (int i = 1; i < 16; i++)
	if (GetBit(i) == 0)
		return false;

	for (int i = 16; i < 128; i++)
	if (GetBit(i) == 1)
		return false;

	return true;
}

bool Qfloat::isNaN()
{
	for (int i = 1; i < 16; i++)
	if (GetBit(i) == 0)
		return false;

	if (isINF())
		return false;

	return true;
}

bool Qfloat::isDenormalizedNumber()
{
	for (int i = 0; i < 16; i++)
	if (GetBit(i) == 1)
		return false;

	if (is0())
		return false;

	return true;
}

bool Qfloat::isZero(const string &num)
{
	int len = num.length();
	for (int i = 0; i < len; i++)
	if (num[i] >= '1' && num[i] <= '9')
		return false;
	return true;
}

Qfloat Qfloat::BinToBinCD(int s, string e, string m)
{
	this->SetBit(s, 0);
	int demE = e.length();// dem so mu
	int n = 15;
	for (int i = demE - 1; i >= 0; i--)
	{
		if (e[i] == '0')
			this->SetBit(0, n);
		else this->SetBit(1, n);
		n--;

	}
	int j = 16;
	int demM = m.length();//dem phan gia tri
	for (int i = 0; i < demM; i++)
	{
		if (m[i] == '0')
			this->SetBit(0, j);
		else this->SetBit(1, j);
		j++;
	}
	return *this;
}

