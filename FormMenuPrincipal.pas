unit FormMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Conexao, FormCadastroPadrao, 
  frmSaldoCaixa, formClassificacao, Vcl.ComCtrls, CommCtrl, Vcl.StdCtrls,
  Vcl.ExtCtrls, udmCaixa, CaixaResumo, System.DateUtils, Vcl.Imaging.pngimage;

type
  TformControleFinanceiro = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    CadastroPadrao1: TMenuItem;
    Relatorios1: TMenuItem;
    Relatorios2: TMenuItem;
    Caixa1: TMenuItem;
    Financeiro1: TMenuItem;
    ResumoCaixa1: TMenuItem;
    Classificao1: TMenuItem;
    pgBar1: TProgressBar;
    Panel1: TPanel;
    pgBar2: TProgressBar;
    pgBar3: TProgressBar;
    dtInicio: TDateTimePicker;
    dtFinal: TDateTimePicker;
    Button1: TButton;
    lbTotal: TLabel;
    lbEntradas: TLabel;
    lbSaidas: TLabel;
    lbSaldoFinal: TLabel;
    Panel2: TPanel;
    lbSaldoAnterior: TLabel;
    Image1: TImage;
    procedure CadastroPadrao1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Caixa1Click(Sender: TObject);
    procedure ResumoCaixa1Click(Sender: TObject);
    procedure Classificao1Click(Sender: TObject);
   
    procedure Button1Click(Sender: TObject);
  
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formControleFinanceiro: TformControleFinanceiro;

implementation

uses
  Splash, Usuarios, Login;
  
  

{$R *.dfm}

procedure TformControleFinanceiro.Button1Click(Sender: TObject);
var
ResumoCaixa : TModelResumoCaixa;
begin
  ResumoCaixa := DataModule3.ResumoCaixa(dtInicio.Date, dtFinal.Date);

  pgBar1.Max :=  StrToInt(FormatCurr('0', ResumoCaixa.totalEntradas + ResumoCaixa.totalSaidas));
  pgBar1.Position :=  StrToInt(FormatCurr('0',ResumoCaixa.totalEntradas));
  
  
  pgBar2.Max :=  StrToInt(FormatCurr('0', ResumoCaixa.totalEntradas + ResumoCaixa.totalSaidas));
  pgBar2.Position :=  StrToInt(FormatCurr('0',ResumoCaixa.totalSaidas));
  pgBar2.State := pbsError;


  pgBar3.Max :=  StrToInt(FormatCurr('0', ResumoCaixa.totalEntradas + ResumoCaixa.totalSaidas));
  pgBar3.Position :=  StrToInt(FormatCurr('0',ResumoCaixa.saldoFinal));
  pgBar3.State := pbsPaused; 
  
  

   lbTotal.Caption :=  'entradas e saidas = R$ '+ FormatCurr('0.00', 
   ResumoCaixa.totalEntradas + ResumoCaixa.totalSaidas);

   lbEntradas.Caption := 'R$ '+FormatCurr('0.00', ResumoCaixa.totalEntradas);

   lbSaidas.caption :=  'R$ '+FormatCurr('0.00', ResumoCaixa.totalSaidas);

   lbSaldoFinal.Caption := 'R$ '+FormatCurr('0.00',ResumoCaixa.saldoFinal);

   lbSaldoAnterior.Caption := 'Saldo Anterior = R$ '+ FormatCurr('0.00', ResumoCaixa.saldoInicial);
   
end;

procedure TformControleFinanceiro.CadastroPadrao1Click(Sender: TObject);
begin
    FormUsuarios.Show;
end;

procedure TformControleFinanceiro.Caixa1Click(Sender: TObject);
begin
     Caixa.Show;
     Caixa.btRefreshCaixaClick(Sender)
end;

procedure TformControleFinanceiro.Classificao1Click(Sender: TObject);
begin
     frmClassificacao.Show;
end;

procedure TformControleFinanceiro.FormCreate(Sender: TObject);
begin
     formSplash := TformSplash.Create(nil);
     frmLogin := TfrmLogin.Create(nil);
     try
       formSplash.ShowModal;
     finally
         FreeAndNil(formSplash);         
     end;
     
     
     try
       frmLogin.ShowModal;
      if frmLogin.ModalResult <> mrOk then
      Application.Terminate;       

     finally
        FreeAndNil(frmLogin);
     end;
     
   dtInicio.Date := now;
   dtFinal.Date := now + 30;
    
end;

procedure TformControleFinanceiro.ResumoCaixa1Click(Sender: TObject);
begin    
    
     fmSaldoCaixa.Show;
    
end;

end.
