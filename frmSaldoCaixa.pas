unit frmSaldoCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdChargenServer, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, 
  CaixaResumo, udmCaixa;

type
  TfmSaldoCaixa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btPesquisar: TButton;
    dtInicio: TDateTimePicker;
    dtFinal: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    SaldoFinal: TLabel;
    Panel4: TPanel;
    lbSaldoParcial: TLabel;
    Panel5: TPanel;
    lbTotaldeSaidas: TLabel;
    Panel6: TPanel;
    lbTotaldeEntradas: TLabel;
    Panel7: TPanel;
    lbSaldoInicial: TLabel;
    lbSaldoInicialValor: TLabel;
    lbTotalEntradaValor: TLabel;
    lbTotalSaidaValor: TLabel;
    lbSaldoParcialValor: TLabel;
    lbSaldoFinalValor: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
  public
    { Public declarations }
  end;

var
  fmSaldoCaixa: TfmSaldoCaixa;

implementation

uses
  System.SysUtils, System.DateUtils;

{$R *.dfm}

{ TfmSaldoCaixa }

procedure TfmSaldoCaixa.btPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfmSaldoCaixa.FormShow(Sender: TObject);
begin
   dtInicio.Date := now;
   dtFinal.Date := now + 30;
   Pesquisar;
end;

procedure TfmSaldoCaixa.Pesquisar;
var
ResumoCaixa : TModelResumoCaixa;


begin
     lbSaldoInicialValor.Caption := '';
     lbTotalEntradaValor.Caption := '';
     lbTotalSaidaValor.Caption := '';
     lbSaldoParcialValor.Caption := '';
     lbSaldoFinalValor.Caption := '';
     ResumoCaixa := DataModule3.ResumoCaixa(dtInicio.Date, dtFinal.Date);

     try
         lbSaldoInicialValor.Caption := FormatCurr('0.00', ResumoCaixa.saldoInicial);
         lbTotalEntradaValor.Caption := FormatCurr('0.00',ResumoCaixa.totalEntradas);
         lbTotalSaidaValor.Caption := FormatCurr('0.00',ResumoCaixa.totalSaidas);
         lbSaldoParcialValor.Caption := FormatCurr('0.00',ResumoCaixa.saldoParcial);
         lbSaldoFinalValor.Caption := FormatCurr('0.00',ResumoCaixa.saldoFinal);
     
     finally
       ResumoCaixa.Free;
     end;
  
  
     
end;

end.
