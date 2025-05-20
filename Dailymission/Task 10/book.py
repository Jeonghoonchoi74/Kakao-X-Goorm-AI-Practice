import os
import sys

sys.stdin.reconfigure(encoding='utf-8')

# books.txt 파일 경로 설정
book_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "books.txt")

class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author
        self.is_borrowed = False

    def borrow(self):
        self.is_borrowed = True

    def return_book(self):
        self.is_borrowed = False

class Ebook(Book):
    def __init__(self, title, author, file_size):
        super().__init__(title, author)
        self.file_size = file_size

    def download(self):
        print(f"📥 <{self.title}> 다운로드 완료! ({self.file_size}MB)")

class Library:
    def __init__(self):
        self.books = []

    def add_book(self, book):
        self.books.append(book)
        self.save_books()

    def borrow_book(self, title):
        try:
            # 책이 library에 있는지 확인
            book = self.find_book_in_file(title)
            if book is None:
                raise ValueError("⚠️ 해당 책이 없습니다.")
            
            # 책이 이미 대출된 상태인지 확인
            if book.is_borrowed:
                raise ValueError("⚠️ 이미 대출된 책입니다!")
            
            # 책 대출
            book.borrow()
            self.save_books()
            print(f"<{book.title}> 대출되었습니다.")
        except ValueError as e:
            print(e)

    def return_book(self, title):
        try:
            # 책이 존재하는지 확인
            book = self.find_book_in_file(title)
            if book is None:
                raise ValueError("⚠️ 해당 책이 없습니다.")
            
            # 책이 대출 중인 경우 반납 처리
            if book.is_borrowed:
                book.return_book()
                self.save_books()
                print(f"<{book.title}>이 반납되었습니다.")
            else:
                print(f"<{book.title}>은 대출되지 않았습니다.")
        
        except ValueError as e:
            print(e)

    def show_books(self):
        print("📚 도서 목록 📚")
        self.load_books()  # 파일에서 도서 목록을 불러옴
        for book in self.books:
            if isinstance(book, Ebook):  # Ebook 확인
                print(f" 📄 {book.title} {book.author} ({'대출 중' if book.is_borrowed else '대출 가능'}) - {book.file_size}MB")
            elif isinstance(book, Book):  # PaperBook 확인
                print(f" 📕 {book.title} {book.author} ({'대출 중' if book.is_borrowed else '대출 가능'})")
            else:
                print("⚠️ 알 수 없는 책 유형입니다.")

    def download_book(self, title):
        try:
            # 책이 존재하는지 확인
            book = self.find_book_in_file(title)
            if book is None:
                raise ValueError("⚠️ 해당 책이 없습니다.")
            
            # 전자책만 다운로드 가능
            if isinstance(book, Ebook):
                book.download()
            else:
                print(f"⚠️ 종이책은 다운로드할 수 없습니다!")
        
        except ValueError as e:
            print(e)

    def find_book_in_file(self, title):
        self.load_books()  # 파일에서 도서 목록을 로드
        for book in self.books:
            if book.title == title:
                return book
        return None

    def save_books(self):
        with open(book_path, "w", encoding="utf-8") as file:
            for book in self.books:
                if isinstance(book, Ebook):
                    file.write(f"Ebook|{book.title}|{book.author}|{book.file_size}|{book.is_borrowed}\n")
                else:
                    file.write(f"PaperBook|{book.title}|{book.author}|{book.is_borrowed}\n")

    def load_books(self):
        self.books = []  # 기존 목록 초기화
        try:
            with open(book_path, "r", encoding="utf-8") as file:
                for line in file:
                    parts = line.strip().split("|")
                    if parts[0] == "Ebook":
                        self.books.append(Ebook(parts[1], parts[2], int(parts[3])))
                    elif parts[0] == "PaperBook":
                        book = Book(parts[1], parts[2])
                        book.is_borrowed = parts[3] == "True"
                        self.books.append(book)           
        except FileNotFoundError:
            print("⚠️ 기존 도서 목록을 불러올 수 없습니다. 새로운 파일로 시작합니다.")

# 프로그램 시작
library = Library()
library.load_books()  # 기존 도서 목록을 불러오기

print("📚 도서 관리 시스템 📚")
while True:

    print("\n1. 종이책 추가")
    print("2. 전자책 추가")
    print("3. 책 대출")
    print("4. 책 반납")
    print("5. 전자책 다운로드")
    print("6. 책 목록 보기")
    print("7. 종료")

    user_input = input("선택 : ")
    try:
        user_input = int(user_input)
    except ValueError:
        print("⚠️ 숫자만 입력해 주세요.")
        continue

    if user_input == 1:
        title = input("책 제목: ")
        author = input("저자: ")
        book = Book(title, author)
        library.add_book(book)
        print(f"<{title}>이 추가되었습니다.")

    elif user_input == 2:
        title = input("전자책 제목: ")
        author = input("저자: ")
        file_size = input("파일 크기(MB): ")
        ebook = Ebook(title, author, file_size)
        library.add_book(ebook)
        print(f"<{title}>이 전자책으로 추가되었습니다.")

    elif user_input == 3:
        title = input("책 제목: ")
        library.borrow_book(title)

    elif user_input == 4:
        title = input("책 제목: ")
        library.return_book(title)

    elif user_input == 5:
        title = input("전자책 제목: ")
        library.download_book(title)

    elif user_input == 6:
        library.show_books()
        
    elif user_input == 7:
        print("프로그램을 종료합니다.")
        break

    else:
        print("⚠️ 잘못된 입력입니다. 종료 합니까? (y/n)")
        if input() == "y":
            print("프로그램을 종료합니다.")
            break
        else:
            continue
