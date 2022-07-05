unit ServerFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormServer = class(TForm)
    MemoContent: TMemo;
    ButtonStart: TButton;
    MemoRecord: TMemo;
    MemoLog: TMemo;
    GroupBox1: TGroupBox;
    EditAddr: TEdit;
    EditPort: TEdit;
    LabelAddr: TLabel;
    LabelPort: TLabel;
    ButtonSend: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormServer: TFormServer;

implementation

// ���õĵ�Ԫ
uses Winapi.WinSock2, ScktComp;

var
  Server: TSocket;
{$R *.dfm}

  { ��ʼ�� }
procedure TFormServer.ButtonStartClick(Sender: TObject);
var
  ServerAddr: TSockAddrIn;
  AddrSize, SendResult: Integer;
  ClientSocket: TSocket;
  CustomWinSocket: TCustomWinSocket;
begin
  Server := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
  // �����Ƿ�ɹ�
  if (Server = INVALID_SOCKET) then
  begin
    MemoLog.Lines.Add('����������ʧ��!');
    exit;
  end;
  MemoLog.Lines.Add('�����������ɹ�!');
  // ��������ָ��IP�Ͷ˿�
  // ��װ��Ϣ
  with ServerAddr do
  begin
    sin_family := PF_INET;
    sin_port := strToInt(EditPort.Text);
    sin_addr.S_addr := inet_addr(PAnsiChar(AnsiString(EditAddr.Text)));
  end;

  if bind(Server, TSockAddr(ServerAddr), sizeof(ServerAddr)) = SOCKET_ERROR then
  begin
    MemoLog.Lines.Add('�˿ںű�ռ��!');
    exit;
  end;
  MemoLog.Lines.Add('IP�Ͷ˿ڰ󶨳ɹ�!');

  // ������ǰIP�Ͷ˿ں��Ƿ��пͻ�������
  if listen(Server, SOMAXCONN) = SOCKET_ERROR then
  begin
    MemoLog.Lines.Add('����ʧ��!');
    exit;
  end;
  MemoLog.Lines.Add('�����ɹ�!');

  ButtonStart.Enabled := false;
  TThread.CreateAnonymousThread(
    procedure
    begin
      // ��ȡ�ͻ������Ӷ���
      AddrSize := sizeof(ServerAddr);
      ClientSocket := accept(Server, @ServerAddr, @AddrSize);

      if ClientSocket = INVALID_SOCKET then
      begin
        case ClientSocket of
          WSAEFAULT:
            MemoLog.Lines.Add('IP��ȡʧ��!');
        end;
        MemoLog.Lines.Add('��ȡ����ʧ��!');
        exit;
      end;

      // �������ClientSocket����0ʱ��ʾ�пͻ������ӵ���ǰ������
      // ���ͻ������ӳɹ�ʱ����ʾ�ͻ��˵�IP
      CustomWinSocket := TCustomWinSocket.Create(ClientSocket);
      MemoLog.Lines.Add('�ͻ���IP: ' + CustomWinSocket.RemoteAddress);

      // ����һ�仰
      // �����1024�Ƿ��͵��ַ����ȣ�����ͨ��len�����£�
      // ����д�̶�ֵ��Ϊ�˷���

      SendResult := send(ClientSocket, '��ӭ�������ݲɼ�', 1024, 0);
      if (SendResult = SOCKET_ERROR) or (SendResult <= 0) then
      begin
        MemoLog.Lines.Add('����ʧ�ܣ�');
      end;

    end).Start

end;

procedure TFormServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Socket��������
  if Server <> INVALID_SOCKET then
  begin
    closesocket(Server);
  end;

  // ����汾����Ϣ
  if WSACleanup = SOCKET_ERROR then
    showmessage('����汾��ʧ��!')

end;

procedure TFormServer.FormCreate(Sender: TObject);
const
  // �����汾��2.2
  WINSOCKET_VERSION = $0202;
var
  WSAData: TWSAData;
begin
  // ���嵱ǰʹ�õ������汾

  if WSAStartup(WINSOCKET_VERSION, WSAData) <> 0 then
  begin
    showmessage('���Ի�ʧ��!');
  end;
  MemoLog.Lines.Add('�������Ի��ɹ�!');
end;

end.
