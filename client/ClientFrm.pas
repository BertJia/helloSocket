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

// ���õĵ�Ԫ
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

  // ����Socket����
  Client := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
  // ��֯IP�Ͷ˿���Ϣ
  // ��װ��Ϣ
  with ServerAddr do
  begin
    sin_family := PF_INET;
    sin_port := strToInt(EditPort.Text);
    sin_addr.S_addr := inet_addr(PAnsiChar(AnsiString(EditAddr.Text)));
  end;
  // ���ӷ�����
  ConnectResult := connect(Client, TSockAddr(ServerAddr), sizeof(ServerAddr));
  if ConnectResult <> 0 then
  begin
    MemoLog.Lines.Add('���ӷ�����ʧ�ܣ�');
  end;
  ButtonConnection.Enabled := false;
  // ��ȡ����
  RecvResult := recv(Client, RecvContent, 1024, 0);
  if RecvResult > 0 then
  begin
    MemoRecord.Lines.Add(RecvContent);
  end;

  // ���������Ӧ���ж�����ʧ�ܣ�ʧ��ʱ����������Ϣ,���ﶼ�ŵ��رմ�����

end;

procedure TFormClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Socket��������
  if Client <> INVALID_SOCKET then
  begin
    closesocket(Client);
  end;

  // ����汾����Ϣ
  if WSACleanup = SOCKET_ERROR then
    showmessage('����汾��ʧ��!')

end;

procedure TFormClient.FormCreate(Sender: TObject);
const
  // �����汾��2.2
  WINSOCKET_VERSION = $0202;
var
  WSAData: TWSAData;
begin
  // ��ʼ�������汾
  if WSAStartup(WINSOCKET_VERSION, WSAData) <> 0 then
  begin
    showmessage('���Ի�ʧ��!');
  end;
  MemoLog.Lines.Add('�������Ի��ɹ�!');
end;

end.
