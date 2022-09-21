unit frmClassificacaoPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, dmClassificacao;

type
  TfrmClassificacaoPadrao = class(TForm)
    pnAll: TPanel;
    pnBotton: TPanel;
    pnTop: TPanel;
    DBGrid1: TDBGrid;
    dtPesquisar: TEdit;
    Button1: TButton;
    Button2: TButton;
    btIncluir: TButton;
    btAlterar: TButton;
    btSair: TButton;
    btExcluir: TButton;
    DataSource1: TDataSource;
    procedure btIncluirClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClassificacaoPadrao: TfrmClassificacaoPadrao;

implementation

{$R *.dfm}

procedure TfrmClassificacaoPadrao.btIncluirClick(Sender: TObject);
begin
    frmClassificacao.Show;
end;

procedure TfrmClassificacaoPadrao.btSairClick(Sender: TObject);
begin
      frmClassificacaoPadrao.Close;
end;

end.
