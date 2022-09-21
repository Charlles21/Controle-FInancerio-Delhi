unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Usuarios;

type
  TfrmLogin = class(TForm)
    pnEsquerda: TPanel;
    imgLogo: TImage;
    pnPrincipalTop: TPanel;
    pnPrincipal: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    pnPrincipalDados: TPanel;
    dtLogin: TEdit;
    dtSenha: TEdit;
    btLogar: TButton;
    procedure btLogarClick(Sender: TObject);
    procedure dtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure dtLoginKeyPress(Sender: TObject; var Key: Char);
  private
    procedure validarOsCampos;
    procedure loginValido;
    procedure enterPress(var Key: Char);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  dmUsuarios;

{$R *.dfm}

procedure TfrmLogin.btLogarClick(Sender: TObject);
begin
  validarOsCampos;
  loginValido;
      
end;

procedure TfrmLogin.validarOsCampos;
begin
  if Trim(dtLogin.Text) = '' then
  begin
    dtLogin.SetFocus;
    Application.MessageBox('campo nao pode ser vazio', 'Atençao', MB_OK + MB_ICONWARNING);
    abort;
  end;
  if Trim(dtSenha.Text) = '' then
  begin
    dtSenha.SetFocus;
    Application.MessageBox('campo nao pode ser vazio', 'Atençao', MB_OK + MB_ICONWARNING);
    abort;
  end;
end;

procedure TfrmLogin.dtLoginKeyPress(Sender: TObject; var Key: Char);
begin
     enterPress(Key);
end;

procedure TfrmLogin.dtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  enterPress(Key);
end;

procedure TfrmLogin.loginValido;
begin
  try
    DataModule2.efetuaLogin(Trim(dtLogin.Text), Trim(dtSenha.Text));
    ModalResult := mrOk;
  except
    on Erro: Exception do
    begin
      Application.MessageBox(PWideChar(Erro.Message), 'Atençao', MB_OK + MB_ICONWARNING);
      dtLogin.SetFocus;
    end;
  end;
end;

procedure TfrmLogin.enterPress(var Key: Char);
begin

   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;

end;
end.
