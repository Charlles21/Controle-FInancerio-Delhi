unit Splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Imaging.pngimage;

type
  TformSplash = class(TForm)
    pnPrincipal: TPanel;
    imgLogo: TImage;
    pgBar: TProgressBar;
    lbName: TLabel;
    lbPgBar: TLabel;
    timer: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    arquivos: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure timerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formSplash: TformSplash;

implementation

{$R *.dfm}

procedure TformSplash.timerTimer(Sender: TObject);
begin
     if pgBar.Position <= 100 then
     begin
         pgBar.StepIt;
         case pgBar.position of
              0 :  lbPgBar.Caption := 'Carregando dependencias';
             20 :  lbPgBar.Caption := 'Conectando ao Banco de Dados';
             50 :  lbPgBar.Caption := 'Carregando Configuraçoes';
             85 :  lbPgBar.Caption := 'Iniciando o Sistema'
         end;           
     end; 
     
      if pgBar.Position = 100 then
          close;
          
end;

end.
