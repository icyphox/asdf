#include <iostream>
#include <fstream>
#include <string>
#include <cstring>

using namespace std;

class Book {
	char name[100];
	char author[100];
	int copies;
	public:
		void addRecord();
		void showRecord();
		void checkAvail();
		void modifyRecord();
		void delRecord();
};

void Book::addRecord() {
	cout << "Book name: ";
	cin.ignore();
	cin.getline(name, 100);
	cout << "Author: ";
	cin.getline(author, 100);
	cout << "Number of copies: ";
	cin >> this->copies;

	/* file stuff */

	ofstream out("book.dat", ios::binary | ios::app);
	out.write(reinterpret_cast<char *>(this), sizeof(Book));
}

void Book::showRecord(){
	ifstream in("book.dat", ios::binary);
	while(in.read(reinterpret_cast<char *>(this), sizeof(Book))){
		cout << "Book name: " << this->name << endl;
		cout << "Author: " << this->author << endl;
		cout << "Copies: " << this->copies << endl;
		cout << endl;
	}
}

void Book::checkAvail(){
	char checkname[100];
	int found = 0;

	cout << "Enter the name of book to check: ";
	cin.ignore();
	cin.getline(checkname, 100);

	ifstream in("book.dat", ios::binary);

	while(in.read(reinterpret_cast<char *>(this), sizeof(Book))){
		if(!strcmp(checkname, this->name)) {
			found = 1;
			break;
		}
	}
	if(found)
		cout << "Book exists!" << endl;
	else
		cout << "Book not found :/" << endl;
}

void Book::modifyRecord(){
	char modname[100];
	int pos = 0;

	cout << "Enter the name of book you wish to modify: ";
	cin.ignore();
	cin.getline(modname, 100);

	ifstream in("book.dat", ios::binary | ios::in);
	ofstream out("book.dat", ios::binary | ios::out);

	while(in.read(reinterpret_cast<char *>(this), sizeof(Book))){
		cout << "book name: " << this->name << endl;
		if(strcmp(modname, this->name) == 0){
			pos = in.tellg();
			cout << pos;
			cout << "here";
			break;
		} else {
			cout << "Book not found!" << endl;
			exit(0);
		}
	}

	out.seekp(0, ios::cur);
	cout << "Enter the new name: ";
	cin.getline(this->name, 100);
	cout << "Enter the new author: ";
	cin.getline(this->author, 100);
	cout << "Enter the new copies: ";
	cin >> this->copies;
	out.seekp(pos);
	out.write(reinterpret_cast<char *>(this), sizeof(Book));
}

void Book::delRecord(){
	char delname[100];
	cout << "Enter the name of book to be deleted: ";
	cin >> delname;
	ifstream in("book.dat", ios::binary);
	ofstream out("newbook.dat", ios::binary);

	in.read(reinterpret_cast<char *>(this), sizeof(Book));
	while(!in.eof()){
		if(strcmp(delname, this->name) != 0){
			out.write(reinterpret_cast<char *>(this), sizeof(Book));				
			break;
		}
		
		else {
			continue;
		}
	}
	remove("book.dat");
	rename("newbook.dat", "book.dat");
}


int main() {
	Book b;
	int choice;
	do {
		cout << "Book Shop" << endl;
		cout << endl;
		cout << "1. Add books \n2. Show books\n3. Modify books\n4. Check availability\n5. Delete books\n6. Quit" << endl;
		cout << endl;
		cout << "Choose an option: ";
		cin >> choice; 
		cout << endl;
	
		switch(choice) {
			case 1:
				b.addRecord();
				break;
			case 2:
				b.showRecord();
				break;
			case 3:
				b.modifyRecord();
				break;
			case 4:
				b.checkAvail();
				break;
			case 5:
				b.delRecord();
			case 6:
				exit(0);
			default:
				cout << "Invalid option" << endl;;
		}
	} while(choice != 6);

	return 0;
}
