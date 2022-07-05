unit ClientFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormClient = class(TForm)
    ButtonConnection: TButton;
    MemoContent: TMemo;
    EditAddr: TEdit;
    EditPort: TEdit;
    Label1: TLabel;
    LabelPort: TLabel;
    GroupBox1: TGroupBox;
    MemoRecord: TMemo;
    MemoLog: TMemo;
    ButtonSend: TButton;
    procedure ButtonConnectionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClient: TFormClient;

implementation

// 引用的单元
uses Winapi.WinSock2, ScktComp;

var
  Client: TSocket;
{$R *.dfm}

procedure TFormClient.ButtonConnectionClick(Sender: TObject);
var
  ServerAddr: TSockAddrIn;
  ConnectResult, RecvResult: Integer;
  RecvContent: array [0 .. 1023] of Char;
begin

  // 创建Socket对象
  Client := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
  // 组织IP和端口信息
  // 组装信息
  with ServerAddr do
  begin
    sin_family := PF_INET;
    sin_port := strToInt(EditPort.Text);
    sin_addr.S_addr := inet_addr(PAnsiChar(AnsiString(EditAddr.Text)));
  end;
  // 连接服务器
  ConnectResult := connect(Client, TSockAddr(ServerAddr), sizeof(ServerAddr));
  if ConnectResult <> 0 then
  begin
    MemoLog.Lines.Add('连接服务器失败！');
  end;
  ButtonConnection.Enabled := false;
  // 读取数据
  RecvResult := recv(Client, RecvContent, 1024, 0);
  if RecvResult > 0 then
  begin
    MemoRecord.Lines.Add(RecvContent);
  end;

  // 正常情况下应该判断连接失败，失败时清理网络信息,这里都放到关闭窗口中

end;

procedure TFormClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Socket的清理工作
  if Client <> INVALID_SOCKET then
  begin
    closesocket(Client);
  end;

  // 清理版本库信息
  if WSACleanup = SOCKET_ERROR then
    showmessage('清理版本库失败!')

end;

procedure TFormClient.FormCreate(Sender: TObject);
const
  // 网络库版本号2.2
  WINSOCKET_VERSION = $0202;
var
  WSAData: TWSAData;
begin
  // 初始化网络库版本
  if WSAStartup(WINSOCKET_VERSION, WSAData) <> 0 then
  begin
    showmessage('初试化失败!');
  end;
  MemoLog.Lines.Add('网络库初试化成功!');
end;

end.
