unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMainForm = class(TForm)
    OpenPort: TButton;
    ClosePort: TButton;
    SendData: TButton;
    Edit1: TEdit;
    PortStateLabel: TLabel;
    btnUp: TButton;
    btnDown: TButton;
    btnLeft: TButton;
    btnRight: TButton;
    procedure OpenPortClick(Sender: TObject);
    procedure ClosePortClick(Sender: TObject);
    procedure SendDataClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure btnUpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnUpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDownMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDownMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnLeftMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnLeftMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnRightMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnRightMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
Var
Port:THandle;

{$R *.dfm}

procedure TMainForm.OpenPortClick(Sender: TObject);
Var
 DCB:TDCB;    //структура, содержащая настройки порта
 CommTimeouts:TCommTimeouts;
begin
  Port:=CreateFile(
    '\\.\COM11',                   //открываем десятый порт
    GENERIC_READ or GENERIC_WRITE,//открываем порт для чтения и записи
    0,                            //общий доступ к ресурсу запрещен, для портов всегда так
    nil,                          //атрибуты защиты, не используются и потому nil
    OPEN_EXISTING,                //атрибуты открытия, для портов OPEN_EXISTING
    FILE_ATTRIBUTE_NORMAL,         //для синхронной работы так
    0
  );
 if (port=INVALID_HANDLE_VALUE)  //если порт не окрылся
  then showmessage('Порт не доступен! Проверьте, не используют ли порт другие приложения и проверьте подключение устройства.') //то выводим сообщение об ошибке
  else POrtStateLabel.Caption:='Порт открыт';       //Если порт открылся, то пишем что открылся

  GetCommState(port, DCB);        //что бы не заполнять всю структуру самим, сначал считываем ее, потом поменяем нужные поля
  DCB.BaudRate:=9600;             // скорость обмена
  DCB.Parity:=NoParity;           // нет контроля четности
  DCB.ByteSize:=8;                //размер передачи
  DCB.StopBits:=ONESTOPBIT;       //один стоповый бит
  SetCommState(port, DCB);        //записываем измененную структуру, для открытого порта

  GetCommTimeouts(Port, CommTimeouts); //получаем структуру CommTimeouts что бы не заполнять все вручную
  CommTimeouts.ReadIntervalTimeout :=MAXDWORD;  //функция ReadFile возвращает
  CommTimeouts.ReadTotalTimeoutMultiplier := 0; //немедленно все имеющиеся
  CommTimeouts.ReadTotalTimeoutConstant := 0;   //байты в приемном буфере
  CommTimeouts.WriteTotalTimeoutMultiplier := 0;//общий тайм-аут для
  CommTimeouts.WriteTotalTimeoutConstant := 0;  //операции записи не используется.
  SetCommTimeouts(Port, CommTimeouts); //записываем измененную структуру

end;


procedure TMainForm.ClosePortClick(Sender: TObject);
begin
 if not CloseHandle(Port)                 //если порт  не закрылся
  then showmessage('Не закрылось')        //то пишем что он не закрылся
  else PortStateLabel.Caption:='Порт не открыт'   //если всетаки закрылся , то пишем, что закрылся :)
end;

procedure TMainForm.SendDataClick(Sender: TObject);
var
  TRBuf:PChar;    //буфер данных для передачи
  nToWrite:DWord; //число байт для записи
  nWrite:DWord;   //число записанных байт
begin
  TRBuf:=PChar(Edit1.Text);         //заполняем буфер данными
  nToWrite:=length(TRBuf)+1;        //число передаваемых байт
  WriteFile(port,TRBuf^,nToWrite,nWrite,nil); //собственно отпавляем данные
//  WriteFile(port,Edit1.Text[1],nToWrite,nWrite,nil); //собственно отпавляем данные
//  WriteFile(port,TRBuf[0],nToWrite,nWrite,nil); //собственно отпавляем данные
end;


procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//CloseHandle(Port)                 //закрываем порт
end;




procedure TMainForm.btnUpMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TRBuf:PChar;    //буфер данных для передачи
  nToWrite:DWord; //число байт для записи
  nWrite:DWord;
begin
  TRBuf:=PChar('005200');         //заполняем буфер данными
  nToWrite:=6+1;        //число передаваемых байт
  WriteFile(port,TRBuf^,nToWrite,nWrite,nil); //собственно отпавляем данные
end;



procedure TMainForm.btnUpMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TRBuf:PChar;    //буфер данных для передачи
  nToWrite:DWord; //число байт для записи
  nWrite:DWord;
begin
  TRBuf:=PChar('000000');         //заполняем буфер данными
  nToWrite:=6+1;        //число передаваемых байт
  WriteFile(port,TRBuf^,nToWrite,nWrite,nil); //собственно отпавляем данные
end;



procedure TMainForm.btnDownMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TRBuf:PChar;    //буфер данных для передачи
  nToWrite:DWord; //число байт для записи
  nWrite:DWord;
begin
  TRBuf:=PChar('006200');         //заполняем буфер данными
  nToWrite:=6+1;        //число передаваемых байт
  WriteFile(port,TRBuf^,nToWrite,nWrite,nil); //собственно отпавляем данные
end;


procedure TMainForm.btnDownMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TRBuf:PChar;    //буфер данных для передачи
  nToWrite:DWord; //число байт для записи
  nWrite:DWord;
begin
  TRBuf:=PChar('000000');         //заполняем буфер данными
  nToWrite:=6+1;        //число передаваемых байт
  WriteFile(port,TRBuf^,nToWrite,nWrite,nil); //собственно отпавляем данные
end;


procedure TMainForm.btnLeftMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TRBuf:PChar;    //буфер данных для передачи
  nToWrite:DWord; //число байт для записи
  nWrite:DWord;
begin
  TRBuf:=PChar('002200003200');         //заполняем буфер данными
  nToWrite:=13;        //число передаваемых байт
  WriteFile(port,TRBuf^,nToWrite,nWrite,nil); //собственно отпавляем данные
end;

procedure TMainForm.btnLeftMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TRBuf:PChar;    //буфер данных для передачи
  nToWrite:DWord; //число байт для записи
  nWrite:DWord;
begin
  TRBuf:=PChar('000000');         //заполняем буфер данными
  nToWrite:=6+1;        //число передаваемых байт
  WriteFile(port,TRBuf^,nToWrite,nWrite,nil); //собственно отпавляем данные
end;

procedure TMainForm.btnRightMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TRBuf:PChar;    //буфер данных для передачи
  nToWrite:DWord; //число байт для записи
  nWrite:DWord;
begin
  TRBuf:=PChar('001200004200');         //заполняем буфер данными
  nToWrite:=13;        //число передаваемых байт
  WriteFile(port,TRBuf^,nToWrite,nWrite,nil); //собственно отпавляем данные
end;

procedure TMainForm.btnRightMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TRBuf:PChar;    //буфер данных для передачи
  nToWrite:DWord; //число байт для записи
  nWrite:DWord;
begin
  TRBuf:=PChar('000000');         //заполняем буфер данными
  nToWrite:=7;        //число передаваемых байт
  WriteFile(port,TRBuf^,nToWrite,nWrite,nil); //собственно отпавляем данные
end;



end.
