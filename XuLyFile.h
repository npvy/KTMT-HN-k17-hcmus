#ifndef __XULYFILE_H__
#define __XULYFILE_H__

#include "QInt.h"
#include "QFloat.h"
#include <fstream>

void DocVaXuLyFileQInt(string &in, string &out);

void Convert(ifstream &In, ofstream &Out, string heso1, string heso2, string data);

void ToanTuHaiNgoi(ifstream &In, ofstream &Out, string heso, string data1, string dau, string data2);

void ToanTuMotNgoi();// Danh cho ~

void DocVaXuLyFileQfloat(Qfloat *FL);

#endif