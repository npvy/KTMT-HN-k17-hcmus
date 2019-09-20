#include "XuLyFile.h"
int main()
{
	
	int chon = 0;
	do
	{
		cout << "1. Xu li so nguyen lon.\n2. Xu li so thuc.\nVui long nhap lua chon!\nBan chon: ";
		cin >> chon;
		if (chon<1 && chon>2)
		{
			cout << "Nhap khong hop le. Nhap lai.\n";
			break;
		}
		if (chon == 1)
		{
			string fileNameIn, fileNameOut;

			cout << "Moi nhap ten file input: ";
			getline(cin >> ws, fileNameIn);

			cout << "Moi nhap ten file output: ";
			getline(cin >> ws, fileNameOut);

			DocVaXuLyFileQInt(fileNameIn, fileNameOut);
		}
		else if (chon == 2)
		{
			Qfloat *Fl = new Qfloat[100];
			DocVaXuLyFileQfloat(Fl);
		}
	} while (chon<0 || chon>3);

	system("pause");
	return 0;
}
